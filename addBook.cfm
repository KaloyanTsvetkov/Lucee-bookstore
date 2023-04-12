<cfset bookService = createObject("component", "services.bookService")>
<cfif not structKeyExists(session, "loggedIn")>
	<!--- User is not logged in, redirect to login page --->
	<cflocation url="login.cfm">
</cfif>

<!--- Include Header --->
<cfinclude template="includes/header.cfm">
<h2>Add a New Book</h2><br/><br/>

<cfif StructKeyExists(FORM, "submit")>
    <cfset errors = bookService.validateBookForm(FORM)>
    <cfif StructIsEmpty(errors)>
        <cfset book = structNew()>
        <cfset book.title = FORM.title>
        <cfset book.author = FORM.author>
        <cfset book.description = FORM.description>
        <cfset book.price = FORM.price>
        <cfset bookService.addBook(book)>
        <p>New book added successfully.</p>
    <cfelse>
        <ul class="error-list">
            <cfloop collection="#errors#" item="error">
                <li>#error#</li>
            </cfloop>
        </ul>
    </cfif>
</cfif>

<form method="post">
    <input type="hidden" name="submit" value="1">
    <div>
        <label for="title">Title:   </label>
        <input type="text" name="title" id="title" placeholder="Title" required>
    </div>
    <br/>
    <div>
        <label for="author">Author: </label>
        <input type="text" name="author" id="author" placeholder="Author" required>
    </div>
    <br/>
    <div>
        <label for="price">Price:</label>
        <input type="number" name="price" id="price" placeholder="Price" required step="0.01" min="0">
    </div>
    <br/>
    <div>
        <label for="description">Description:</label></br>
        <textarea name="description" id="description" required>Description...</textarea>
    </div>
    <br/>
    <button type="submit">Add Book</button>
</form>

<!--- Include Footer --->
<cfinclude template="includes/footer.cfm">