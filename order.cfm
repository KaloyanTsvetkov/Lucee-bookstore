<cfset orderService = createObject("component", "services.orderService")>
<cfset orders = orderService.getAllOrdersForUser(session.loggedIn.id)>

	<!--- Include Header --->
<cfinclude template="includes/header.cfm">

<h2>My Orders</h2><br/><br/>

<cfif orders.recordCount eq 0>
    <p>No orders found.</p>
<cfelse>
    <table>
        <thead>
            <tr>
                <th>Order Date</th>
                <th>Book</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <cfloop query="orders">
                <tr>
                    <td><cfoutput>#DateFormat(orders.orderDate, "mm/dd/yyyy")#</cfoutput></td>
                    <td><cfoutput>#orders.title#</cfoutput></td>
                    <td><cfoutput>#orders.quantity#</cfoutput></td>
                    <td><cfoutput>#orders.price#</cfoutput></td>
                    <td><cfoutput>#NumberFormat(orders.total, "$9,999.99")#</cfoutput></td>
                </tr>
            </cfloop>
        </tbody>
    </table>
</cfif>

<cfinclude template="includes/footer.cfm">