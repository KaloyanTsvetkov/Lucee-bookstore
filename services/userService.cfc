<cfcomponent>
    <cfset userbj = createObject("component", "handlers.user")>
  
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

      <cfset password = hash(password, "SHA-512")>
  
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

    <cffunction name="registerUser" access="public" returntype="void" output="false">
      <cfargument name="user" type="struct" required="true">
      <cfset userbj.userRegistration(user) />
  </cffunction>

  <cffunction name="checkUsernameExists" access="public" returnType="boolean">
    <cfargument name="username" type="string" required="true">
    
    <cfset var exists = false />
    <cfset var user = userbj.checkUserExists(username) />
    
    <cfif user.recordcount>
        <cfset exists = true />
    </cfif>
    
    <cfreturn exists>
</cffunction>

  
  </cfcomponent>
  