<cfset bookService = createObject("component", "services.bookService")>
<cfset getBooks = bookService.getBooks()>

<cfif not structKeyExists(session, "loggedIn")>
	<!--- User is not logged in, redirect to login page --->
	<cflocation url="login.cfm">
</cfif>

<!DOCTYPE html>
<html>
<head>
	<title>Bookstore</title>
	<link rel="stylesheet" href="css/styles.css">
</head>
<body>
	<!--- Include Header --->
	<cfinclude template="includes/header.cfm">

	<!--- Display Books --->
	<div class="book-list">
		<cfloop query="getBooks">
			<div class="book">
				<div class="book-image">
					<img src="#getBooks.image#">
				</div>
				<div class="book-details">
					<cfset link = "book.cfm?id=" & id />
					<h2><a href="<cfoutput>#link#</cfoutput>"><cfoutput>#title#</cfoutput></a></h2>
					<p><strong>Author: </strong><cfoutput>#author#</cfoutput></p>
					<p><strong>Price: </strong><cfoutput>#price#</cfoutput></p>
					<form action="handlers/cart.cfc?method=addToCart" method="post">
						<input type="hidden" name="bookId" value="<cfoutput>#id#</cfoutput>">
						<input type="number" name="quantity" value="1" min="1">
						<input type="submit" value="Add to Cart">
					</form>
				</div>
			</div>
			<br/><br/>
		</cfloop>
	</div>

	<!--- Include Footer --->
	<cfinclude template="includes/footer.cfm">
</body>
</html>
