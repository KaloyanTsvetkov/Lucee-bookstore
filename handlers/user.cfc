component {

    // Get the user service
    property name="userService" inject="userService";

    /**
     * Register 
     * @httpMethod POST
     * @produces application/json
     * @consumes application/json
     * @param {string} email - The email of the user
     * @param {string} password - The password of the user
     * @param {string} firstName - The first name of the user
     * @param {string} lastName - The last name of the user
     * @return {string} - JSON string containing the new user details or an error message
     */
    remote any function register() httpmethod="POST" produces="application/json" consumes="application/json" {
        var response = {};
        var requestBody = deserializeJSON(getHttpRequestData().content);

        // Create the new user
        var user = userService.createUser(requestBody.email, requestBody.password, requestBody.firstName, requestBody.lastName);

        if (!isNull(user)) {
            // Success
            response["success"] = true;
            response["message"] = "User created successfully.";
            response["user"] = user;
            return serializeJSON(response);
        }
        else {
            // Error
            response["success"] = false;
            response["message"] = "Error creating user.";
            return serializeJSON(response);
        }
    }

    function userRegistration(user) {
        var qAddUser = new Query();
        qAddUser.setSQL("INSERT INTO users (username, password, email)
          VALUES (:username, :password, :email)");
        passHashed = hash(arguments.user.password, "SHA-512");
        qAddUser.addParam(name="username", value=arguments.user.username, cfsqltype="CF_SQL_VARCHAR");
        qAddUser.addParam(name="password", value=passHashed, cfsqltype="CF_SQL_VARCHAR");
        qAddUser.addParam(name="email", value=arguments.user.email, cfsqltype="CF_SQL_VARCHAR");

        qAddUser.execute();
      }

    /**
     * Authenticate a user
     * @httpMethod POST
     * @produces application/json
     * @consumes application/json
     * @param {string} email - The email of the user
     * @param {string} password - The password of the user
     * @return {string} - JSON string containing the user details or an error message
     */
    remote any function login() httpmethod="POST" produces="application/json" consumes="application/json" {
        var response = {};
        var requestBody = deserializeJSON(getHttpRequestData().content);

        // Authenticate the user
        var user = userService.authenticateUser(requestBody.email, requestBody.password);

        if (!isNull(user)) {
            // Success
            response["success"] = true;
            response["message"] = "User authenticated successfully.";
            response["user"] = user;
            return serializeJSON(response);
        }
        else {
            // Error
            response["success"] = false;
            response["message"] = "Invalid email or password.";
            return serializeJSON(response);
        }
    }

    /**
     * Retrieves a user record from the database based on the provided username and password.
     * @username the username to look up.
     * @password the password to verify.
     * @return a struct representing the user, or an empty struct if no user was found.
     */
    function getUserByUsernameAndPassword(username, password) {
        // Query the database to retrieve the user with the given username and password
        userQuery = new Query();
        userQuery.setSQL("SELECT id, username, password, email FROM users WHERE username = :username AND password = :password");
        userQuery.addParam(name="username", value = username, cfsqltype = "CF_SQL_VARCHAR");
        userQuery.addParam(name="password", value = password, cfsqltype = "CF_SQL_VARCHAR");
        var user = userQuery.execute().getResult();
        return user;
    }

    function checkUserExists(username) {
        // Query the database to retrieve the user with the given username and password
        userQuery = new Query();
        userQuery.setSQL("SELECT id FROM users WHERE username = :username");
        userQuery.addParam(name="username", value = username, cfsqltype = "CF_SQL_VARCHAR");
        var user = userQuery.execute().getResult();
        return user;
    }

}
