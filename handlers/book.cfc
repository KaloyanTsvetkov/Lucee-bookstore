component {
  
    // function to retrieve all books from the database
    function getAllBooks() {
      var qBooks = new Query();
      qBooks.setSQL("
        SELECT *
        FROM books
      ");
      var books = qBooks.execute().getResult();
      return books;
    }
    
    // function to retrieve a book by its ID
    function getBookById(bookId) {
      var qBook = new Query();
      qBook.setSQL("
        SELECT *
        FROM books
        WHERE id = :id
      ");
      qBook.addParam(name="id", value=arguments.bookId, cfsqltype="CF_SQL_INTEGER");
      var book = qBook.execute().getResult();
      return book;
    }
    
    // function to add a new book to the database
    function addBook(book) {
      var qAddBook = new Query();
      qAddBook.setSQL("
        INSERT INTO books (title, author, price, description)
        VALUES (:title, :author, :price, :description)
      ");
      qAddBook.addParam(name="title", value=arguments.book.title, cfsqltype="CF_SQL_VARCHAR");
      qAddBook.addParam(name="author", value=arguments.book.author, cfsqltype="CF_SQL_VARCHAR");
      qAddBook.addParam(name="price", value=arguments.book.price, cfsqltype="CF_SQL_FLOAT");
      qAddBook.addParam(name="description", value=arguments.book.description, cfsqltype="CF_SQL_VARCHAR");
      // qAddBook.addParam(name="image_url", value=arguments.book.image_url, cfsqltype="CF_SQL_VARCHAR");
      qAddBook.execute();
    }
    
    // function to update an existing book in the database
    function updateBook(book) {
      var qUpdateBook = new Query();
      //SET title = :title, author = :author, price = :price, description = :description, image_url = :image_url
      qUpdateBook.setSQL("
        UPDATE books
        SET title = :title, author = :author, price = :price, description = :description
        WHERE id = :id
      ");
      qUpdateBook.addParam(name="title", value=arguments.book.title, cfsqltype="CF_SQL_VARCHAR");
      qUpdateBook.addParam(name="author", value=arguments.book.author, cfsqltype="CF_SQL_VARCHAR");
      qUpdateBook.addParam(name="price", value=arguments.book.price, cfsqltype="CF_SQL_FLOAT");
      qUpdateBook.addParam(name="description", value=arguments.book.description, cfsqltype="CF_SQL_VARCHAR");
      // qUpdateBook.addParam(name="image_url", value=arguments.book.image_url, cfsqltype="CF_SQL_VARCHAR");
      qUpdateBook.addParam(name="id", value=arguments.book.id, cfsqltype="CF_SQL_INTEGER");
      qUpdateBook.execute();
    }
    
    // function to delete a book from the database by its ID
    function deleteBookById(bookId) {
      var qDeleteBook = new Query();
      qDeleteBook.setSQL("
        DELETE FROM books
        WHERE id = :id
      ");
      qDeleteBook.addParam(name="id", value=arguments.bookId, cfsqltype="CF_SQL_INTEGER");
      qDeleteBook.execute();
    }
  }
  