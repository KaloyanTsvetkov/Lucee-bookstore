component {

    /**
    * Adds a book to the shopping cart
    * @param bookId - the id of the book to add
    * @param quantity - the quantity of the book to add
    */
    remote function addToCart(bookId, quantity) {
        if (!structKeyExists(session, "cart")) {
            session.cart = [];
        }
        if (!ArrayContains(session.cart, bookId)) {
            session.cart[bookId] = 0;
        }

        session.cart[bookId] = quantity;

        // Redirect to the cart page
        location("../cart.cfm", false);
    }

    /**
    * Removes a book from the shopping cart
    * @param bookId - the id of the book to remove
    * @param quantity - the quantity of the book to remove
    */
    function removeBook(bookId, quantity) {
        if (structKeyExists(session.cart, bookId)) {
            session.cart[bookId] -= quantity;
            if (session.cart[bookId] <= 0) {
                structDelete(session.cart, bookId);
            }
        }
    }

    /**
    * Gets the total price of all books in the shopping cart
    * @return - the total price of all books in the shopping cart
    */
    function getTotalPrice() {
        var totalPrice = 0;
        var bookService = new bookstore.services.book();
        for (var bookId in session.cart) {
            var book = bookService.getBook(bookId);
            totalPrice += book.price * session.cart[bookId];
        }
        return totalPrice;
    }

    /**
    * Gets the number of items in the shopping cart
    * @return - the number of items in the shopping cart
    */
    function getNumItems() {
        var numItems = 0;
        for (var bookId in session.cart) {
            numItems += session.cart[bookId];
        }
        return numItems;
    }

    /**
    * Empties the shopping cart
    */
    function clearCart() {
        structClear(session.cart);
    }
}
