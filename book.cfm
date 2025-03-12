<cfset bookService = createObject("component", "services.bookService")>
<cfif not structKeyExists(session, "loggedIn")>
	<!--- User is not logged in, redirect to login page --->
	<cflocation url="login.cfm">
</cfif>

<!--- Initialize message variable --->
<cfset message = "">

<!--- Process Form Submission --->
<cfif structKeyExists(form, "action") AND form.action EQ "add_to_cart">
    <cfif StructKeyExists(Form, "book_id") AND IsNumeric(Form.book_id) AND StructKeyExists(Form, "quantity") AND IsNumeric(Form.quantity)>
        <cfset book = bookService.getBook(Form.book_id)>
        <cfif NOT StructIsEmpty(book)>
            <cfset cartService.addToCart(book, Form.quantity)>
            <cfset message = "<p style='color: green;'>Book added to cart successfully!</p>">
        <cfelse>
            <cfset message = "<p style='color: red;'>Book not found.</p>">
        </cfif>
    <cfelse>
        <cfset message = "<p style='color: red;'>Invalid book ID or quantity.</p>">
    </cfif>
</cfif>

<!--- Include Header --->
<cfinclude template="includes/header.cfm">
<!--- Display Message in the Correct Place --->
<cfoutput>#message#</cfoutput>

<cfif StructKeyExists(URL, "id") and IsNumeric(URL.id)>
    <cfset book = bookService.getBook(URL.id)>
    <cfif StructIsEmpty(book)>
        <p>Book not found.</p>
    <cfelse>
        <h2><cfoutput>#book.title#</cfoutput></h2>
        <p><strong>Author: </strong><cfoutput>#book.author#</cfoutput></p>
        <p><strong>Price: </strong><cfoutput>#DollarFormat(book.price)#</cfoutput></p>
        <p><strong>Description: </strong><cfoutput>#book.description#</cfoutput></p>
        <form method="post">
            <input type="hidden" name="action" value="add_to_cart">
            <input type="hidden" name="book_id" value="#book.id#">
            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" id="quantity" value="1" min="1" max="10">
            <button type="submit">Add to Cart</button>
        </form>
    </cfif>
<cfelse>
    <p>Invalid book ID.</p>
</cfif>

	<!--- Include Footer --->
<cfinclude template="includes/footer.cfm">
