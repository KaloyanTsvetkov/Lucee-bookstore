component {

	function getOrdersByUser(userId) {
        // Query the database to retrieve the user with the given username and password
        orderQuery = new Query();
        orderQuery.setSQL("SELECT o.id, o.user_id, o.book_id, o.quantity, o.order_date as orderDate, b.title, b.price, (o.quantity * b.price) AS Total
			FROM orders o
			INNER JOIN books b ON o.book_id = b.id
			WHERE o.user_id = :userId 
			ORDER BY o.order_date DESC");
        orderQuery.addParam(name="userId", value = userId, cfsqltype = "CF_SQL_INTEGER");
        var orders = orderQuery.execute().getResult();
        return orders;
    }

	// Define the function to place an order
	function placeOrder(required numeric userId, required numeric bookId, required numeric quantity) {
        orderQuery = new Query();
        orderQuery.setSQL("INSERT INTO orders (user_id, book_id, quantity, order_date)
							VALUES (:userId, :bookId, :quantity, now())");
        orderQuery.addParam(name="userId", value = userId, cfsqltype = "CF_SQL_INTEGER");
		orderQuery.addParam(name="bookId", value = bookId, cfsqltype = "CF_SQL_INTEGER");
		orderQuery.addParam(name="quantity", value = quantity, cfsqltype = "CF_SQL_INTEGER");
        var orders = orderQuery.execute();
	}
	
}
