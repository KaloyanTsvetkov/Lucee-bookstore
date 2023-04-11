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
				<input type="text" name="username" id="username" value="#form.username#">
			</div>
			<div>
				<label for="password">Password:</label>
				<input type="password" name="password" id="password">
			</div>
			<div>
				<label for="confirm_password">Confirm Password:</label>
				<input type="password" name="confirm_password" id="confirm_password">
			</div>
			<div>
				<label for="email">Email:</label>
				<input type="email" name="email" id="email" value="#form.email#">
			</div>
			<div>
				<input type="submit" name="submit" value="Register">
			</div>
		</form>
		
		<cfinclude template="includes/footer.cfm">
	</div>
</body>
</html>
