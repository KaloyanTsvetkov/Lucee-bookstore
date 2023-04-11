<cfset bookService = createObject("component", "services.bookService")>
	<!--- Include Header --->
<cfinclude template="includes/header.cfm">
<h2>Shopping Cart</h2>

<cfif ArrayIsEmpty(session.cart)>
    <p>Your cart is empty.</p>
<cfelse>
    <cfdump var="#session.cart#" >
    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Author</th>
                <th>Description</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <cfset total = 0>
            <cfloop collection="#session.cart#" item="item">
                <tr>
                    <cfset book = bookService.getBook(item)>
                    <td><cfoutput>#book.title#</cfoutput></td>
                    <td><cfoutput>#book.author#</cfoutput></td>
                    <td><cfoutput>#book.description#</cfoutput></td>
                    <td><cfoutput>#book.price#</cfoutput></td>
                    <td><cfoutput>#session.cart[item]#</cfoutput>
     <!--                   <form action="handlers/cart/updateQuantity" method="post">
                            <input type="hidden" name="bookId" value="#item.book.id#">
                            <input type="number" name="quantity" value="#item.quantity#" min="1">
                            <button type="submit">Update</button>
                        </form> -->
                    </td>
                    <cfset subtotal = book.price * session.cart[item]>
                    <td><cfoutput>#subtotal#</cfoutput></td>
   <!--                 <td>
                        <form action="handlers/cart/removeBook" method="post">
                            <input type="hidden" name="bookId" value="#item.book.id#">
                            <button type="submit">Remove</button>
                        </form>
                    </td> -->
                </tr>
                <cfset total = total + (book.price * session.cart[item])>
            </cfloop>
            <tr>
                <td colspan="5">Total:</td>
                <td><cfoutput>#total#</cfoutput></td>
            </tr>
        </tbody>
    </table>
</cfif>
	<!--- Include Footer --->
<cfinclude template="includes/footer.cfm">