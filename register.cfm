<cfparam name="form.username" default="">
<cfparam name="form.email"  default="">
<cfset userService = createObject("component", "services.userService")>
<cfset errors = []>
<!--- Check if form was submitted --->
<cfif structKeyExists(form, "registerUser")>

    <!--- Set form variables --->
    <cfset username = form.username>
    <cfset email = form.email>
    <cfset password = form.password>
    <cfset confirmPassword = form.confirmPassword>

    <!--- Validate first name --->
    <cfif not len(trim(username))>
        <cfset errors[1] = "Please enter username.">
    <cfelseif userService.checkUsernameExists(username)>
        <cfset errors[1] = "This username is already taken.">
    </cfif>

    <!--- Validate password --->
    <cfif not len(trim(password))>
        <cfset errors[2] = "Please enter a password.">
    <cfelseif not refind("^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$", password)>
        <cfset errors[2] = "Password must contain at least 8 characters, including a mix of upper and lowercase letters and numbers.">
    </cfif>

    <!--- Validate confirm password --->
    <cfif not len(trim(confirmPassword))>
        <cfset errors[3] = "Please confirm your password.">
    <cfelseif password neq confirmPassword>
        <cfset errors[3] = "Password and confirm password do not match.">
    </cfif>

    <!--- Validate email --->
    <cfif not len(trim(email))>
        <cfset errors[4] = "Please enter your email.">
    <cfelseif not refind("^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$", email)>
        <cfset errors[4] = "Please enter a valid email address.">
    </cfif>

    <!--- Check if there are any errors --->
    <cfif not arrayLen(errors)>
        <cfset user = {username = username, email = email, password = password}>
        <!--- No errors, proceed with user registration --->
        <cfset userService.registerUser(user)>
		<!--- User registration successful, redirect to login page --->
		<cflocation url="login.cfm">
    </cfif>

</cfif>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Register - Bookstore</title>
	<link rel="stylesheet" href="resources/css/style.css">
</head>
<body>
	<div id="wrapper">
		<cfinclude template="includes/header.cfm">
		
		<h1>Register</h1>
		
		<cfif isDefined("errorMessage")>
			<div class="error"><cfoutput>#errorMessage#</cfoutput></div>
		</cfif>
		
		<form method="post">
			<div>
				<label for="username">Username:</label>
				<input type="text" name="username" id="username" value="<cfoutput>#form.username#</cfoutput>">
                <cfif ArrayIsDefined(errors, 1)>
                    <span class="error"><cfoutput>#errors[1]#</cfoutput></span>
                </cfif>
			</div>
			<div>
				<label for="password">Password:</label>
				<input type="password" name="password" id="password">
                <cfif ArrayIsDefined(errors, 2)>
                    <span class="error"><cfoutput>#errors[2]#</cfoutput></span>
                </cfif>
			</div>
			<div>
				<label for="confirm_password">Confirm Password:</label>
				<input type="password" name="confirmPassword" id="confirmPassword">
                <cfif ArrayIsDefined(errors, 3)>
                    <span class="error"><cfoutput>#errors[3]#</cfoutput></span>
                </cfif>
			</div>
			<div>
				<label for="email">Email:</label>
				<input type="email" name="email" id="email" value="<cfoutput>#form.email#</cfoutput>">
                <cfif ArrayIsDefined(errors, 4)>
                    <span class="error"><cfoutput>#errors[4]#</cfoutput></span>
                </cfif>
			</div><br/>
			<div>
				<input type="submit" name="registerUser" value="Register">
			</div>
		</form>
		
		<cfinclude template="includes/footer.cfm">
	</div>
</body>
</html>