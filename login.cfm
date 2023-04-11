<cfif structKeyExists(form, "submitLogin")>
    <cfset userService = createObject("component", "services.userService")>

    <!--- Validate user credentials --->
    <cfset isValidUser = userService.validateUser(form.username, form.password)>

    <cfif isValidUser>
        <!--- Set session variables for logged in user --->
        <cfset session.isLoggedIn = true>
        <cfset session.username = form.username>
        
        <!--- Redirect to home page --->
        <cflocation url="index.cfm" addtoken="false">
    <cfelse>
        <cfset errorMessage = "Invalid username or password.">
    </cfif>
</cfif>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Bookstore</title>
    <link rel="stylesheet" href="resources/css/style.css">
</head>
<body>
    <div id="wrapper">
        <cfinclude template="includes/header.cfm">
        
        <h1>Login</h1>
        
        <cfif isDefined("errorMessage")>
            <div class="error"><cfoutput>#errorMessage#</cfoutput></div>
        </cfif>
        
        <form method="post">
            <div>
                <label for="username">Username:</label>
                <input type="text" name="username" id="username">
            </div>
            <div>
                <label for="password">Password:</label>
                <input type="password" name="password" id="password">
            </div>
            <div>
                <input type="submit" name="submitLogin" value="Login">
            </div>
        </form>
        
        <cfinclude template="includes/footer.cfm">
    </div>
</body
