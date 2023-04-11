<cfcomponent>
    <cfset userbj = createObject("component", "handlers.user")>

    <cffunction name="login" access="public" returntype="boolean">
      <cfargument name="username" type="string" required="true">
      <cfargument name="password" type="string" required="true">
  
      <!--- Query the database to retrieve the user with the given username and password --->
      <cfset var user = getUserByUsernameAndPassword(username, password)>
  
      <!--- If the user is found, set session variables to indicate that the user is logged in
            and return true. Otherwise, return false. --->
      <cfif structKeyExists(user, "id")>
        <cfset session.loggedIn = true>
        <cfset session.userId = user.id>
        <cfreturn true>
      <cfelse>
        <cfreturn false>
      </cfif>
    </cffunction>
  
    <cffunction name="logout" access="public" returntype="void">
      <!--- Clear session variables to indicate that the user is no longer logged in --->
      <cfset structDelete(session, "loggedIn")>
      <cfset structDelete(session, "userId")>
    </cffunction>
  
    <cffunction name="isAuthenticated" access="public" returntype="boolean">
      <!--- Check if the user is authenticated by checking the session variables --->
      <cfif structKeyExists(session, "loggedIn") and session.loggedIn>
        <cfreturn true>
      <cfelse>
        <cfreturn false>
      </cfif>
    </cffunction>
  
    <cffunction name="getUserId" access="public" returntype="string">
      <!--- Get the user ID from the session if the user is authenticated --->
      <cfif isAuthenticated()>
        <cfreturn session.userId>
      <cfelse>
        <cfreturn "">
      </cfif>
    </cffunction>
  
    <cffunction name="validateUser" access="public" returntype="boolean">
      <cfargument name="username" type="string" required="true">
      <cfargument name="password" type="string" required="true">
  
      <!--- Query the database to retrieve the user with the given username and password --->
      <cfset user = userbj.getUserByUsernameAndPassword(username, password)>
  
      <!--- If the user is found, return true. Otherwise, return false. --->
      <cfif isEmpty(user.id)>
        <cfreturn false>
      <cfelse>
        <cfset session.loggedIn = user>
        <cfset session.cart = []>
        <cfreturn true>
      </cfif>
    </cffunction>
  
  </cfcomponent>
  