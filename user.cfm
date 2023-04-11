<cfif not StructKeyExists(session, "loggedIn") or not StructKeyExists(session.loggedIn, "id")>
    <cflocation url="login.cfm">
</cfif>

<cfinclude template="includes/header.cfm">

<h2>User Information</h2><br/><br/>

<p><strong>Name: </strong><cfoutput>#session.loggedIn.username#</cfoutput></p>
<p><strong>Email: </strong><cfoutput>#session.loggedIn.email#</cfoutput></p>
<p><strong>Address: </strong> ToDo</p>

<!--- Include Footer --->
<cfinclude template="includes/footer.cfm">