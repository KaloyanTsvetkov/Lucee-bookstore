component {

	this.name = "Bookstore";
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan(0, 0, 30, 0);
	this.datasource = "bookstore_datasource";
  
	function onRequestStart(targetPage) {
		if(NOT StructKeyExists(session, "isLoggedIn")){
			session.isLoggedIn = false;
		}
	}
  
	function onSessionStart() {
	  // Initialize the cart
	  session.cart = [];
	}
  
	function onSessionEnd() {
	  // Clean up the cart
	  session.cart = [];
	}
  
	// Define error handling
	this.customErrorTemplate = "includes/error.cfm";
	
	// Define function to handle missing templates
	this.onMissingTemplate = function(targetPage) {
		include "includes/header.cfm";
		writeOutput("<h2>Error: Template not found</h2>");
		writeOutput("<p>The requested page, #targetPage#, could not be found.</p>");
		include "includes/footer.cfm";
		abort;
	};

	// Define function to handle missing include files
	this.onMissingInclude = function(targetPage) {
		include "includes/header.cfm";
		writeOutput("<h2>Error: Include file not found</h2>");
		writeOutput("<p>The requested include file, #targetPage#, could not be found.</p>");
		include "includes/footer.cfm";
		abort;
	};
  
  }
  