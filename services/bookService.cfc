<cfcomponent>
    <cfset bookObj = createObject("component", "handlers.book")>

	<cffunction name="getBooks" access="public" returntype="query">
		<cfreturn bookObj.getAllBooks()>
	</cffunction>

    <cffunction name="getBook" access="public" returntype="query">
        <cfargument name="id" type="string" required="true">
		<cfreturn bookObj.getBookById(toNumeric(id))>
	</cffunction>

    <cffunction name="addBook" access="public" returntype="void" output="false">
        <cfargument name="book" type="struct" required="true">
        <cfset bookObj.addBook(book) />
    </cffunction>

    <cffunction name="validateBookForm" returntype="struct" access="public" output="false">
        <cfargument name="form" required="true" type="struct">
        <cfset var errors = {}>
        <cfif not StructKeyExists(form, "title") or len(trim(form.title)) EQ 0>
            <cfset errors["title"] = "Please enter a title.">
        </cfif>
        <cfif not StructKeyExists(form, "author") or len(trim(form.author)) EQ 0>
            <cfset errors["author"] = "Please enter an author.">
        </cfif>
        <cfif not StructKeyExists(form, "description") or len(trim(form.description)) EQ 0>
            <cfset errors["description"] = "Please enter a description.">
        </cfif>
        <cfif not StructKeyExists(form, "price") or not isNumeric(form.price) or form.price lte 0>
            <cfset errors["price"] = "Please enter a valid price.">
        </cfif>
        <cfreturn errors>
    </cffunction>
    

</cfcomponent>
