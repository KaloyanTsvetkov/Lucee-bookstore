<cfset bookService = createObject("component", "services.bookService")>
	<!--- Include Header --->
<cfinclude template="includes/header.cfm">
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