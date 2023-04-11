component {

	// Define the function to place an order
	function placeOrder(required string firstName, required string lastName, required string email, required array cart) {
		
		// Create a new order object
		order = new Order();
		
		// Set the order properties
		order.setFirstName(firstName);
		order.setLastName(lastName);
		order.setEmail(email);
		order.setOrderDate(now());
		
		// Calculate the total cost of the order
		totalCost = 0;
		for (item in cart) {
			totalCost += item.price;
		}
		order.setTotalCost(totalCost);
		
		// Save the order to the database
		order.save();
		
		// Create order items for each item in the cart
		for (item in cart) {
			orderItem = new OrderItem();
			orderItem.setOrder(order);
			orderItem.setBook(item.book);
			orderItem.setQuantity(item.quantity);
			orderItem.setPrice(item.price);
			orderItem.save();
		}
		
		// Return the order ID
		return order.getID();
	}
	
}
