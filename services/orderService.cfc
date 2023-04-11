<cfcomponent>
	<cfset orderObj = createObject("component", "handlers.order")>
	
    <cffunction name="placeOrder" access="public" returntype="void" output="false">
        <cfargument name="userId" type="numeric" required="true">
        <cftransaction>
            <cftry>   
                <!-- Loop through the items in the cart and insert them into the order_items table -->
                <cfloop collection="#session.cart#" item="item">
                    <cfset bookId = item>
                    <cfset quantity = session.cart[item]>
    
                    <cfset orderObj.placeOrder(session.loggedIn.id, bookId, quantity)>
                </cfloop>
    
                <!-- Clear the cart once the order has been placed -->
                <cfset session.cart = []>
    
                <cfcatch type="any">
                    <cftransaction action="rollback"/>
                    <cfthrow message="An error occurred while placing the order. #cfcatch.message#">
                </cfcatch>
            </cftry>
        </cftransaction>
    </cffunction>    
	
	<cffunction name="addBookToOrder" access="public" returntype="void">
		<cfargument name="orderId" type="numeric" required="true">
		<cfargument name="bookId" type="numeric" required="true">
		<cfargument name="quantity" type="numeric" required="true">
		<cfquery name="existingOrder" datasource="#this.dsn#">
			SELECT * FROM order_books WHERE orderId = #arguments.orderId# AND bookId = #arguments.bookId#
		</cfquery>
		<cfif existingOrder.recordcount>
			<cfquery name="updateOrder" datasource="#this.dsn#">
				UPDATE order_books SET quantity = quantity + #arguments.quantity#
				WHERE orderId = #arguments.orderId# AND bookId = #arguments.bookId#
			</cfquery>
		<cfelse>
			<cfquery name="insertOrder" datasource="#this.dsn#">
				INSERT INTO order_books(orderId, bookId, quantity)
				VALUES(#arguments.orderId#, #arguments.bookId#, #arguments.quantity#)
			</cfquery>
		</cfif>
	</cffunction>

	<cffunction name="getOrder" access="public" returntype="query">
		<cfargument name="orderId" type="numeric" required="true">
		<cfquery name="orderQuery" datasource="#this.dsn#">
			SELECT books.bookId, books.title, order_books.quantity
			FROM order_books
			INNER JOIN books ON order_books.bookId = books.bookId
			WHERE order_books.orderId = #arguments.orderId#
		</cfquery>
		<cfreturn orderQuery>
	</cffunction>
	
	<cffunction name="getAllOrdersForUser" access="public" returntype="query">
		<cfargument name="userId" type="numeric" required="true">
		<cfreturn orderObj.getOrdersByUser(userId)>
	</cffunction>

</cfcomponent>
