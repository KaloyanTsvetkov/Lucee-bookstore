<cfscript>
    // Invalidate the user's session
    sessionInvalidate();
  
    session.isLoggedIn = false;
    // Redirect the user to the login page
    location(url = "login.cfm", addtoken = "false");
  </cfscript>  