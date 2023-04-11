<!DOCTYPE html>
<html>
<head>
	<title>Bookstore</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<style>
		table {
		  font-family: arial, sans-serif;
		  border-collapse: collapse;
		  width: 100%;
		}
		
		td, th {
		  border: 1px solid #dddddd;
		  text-align: left;
		  padding: 8px;
		}
		
		tr:nth-child(even) {
		  background-color: #dddddd;
		}
	</style>
</head>
<body>
	<nav class="navbar navbar-inverse">
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="/bookstore">Bookstore</a>
			</div>
			<ul class="nav navbar-nav">
				<li><a href="index.cfm">Home</a></li>
				<li><a href="addBook.cfm">Add Book</a></li>
				<li><a href="cart.cfm">Cart</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
				<cfif session.isLoggedIn>
					<li><a href="order.cfm">My Orders</a></li>
					<li><a href="user.cfm">Hi, <cfoutput>#session.username#</cfoutput></a></li>
					<li><a href="logout.cfm"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				<cfelse>
					<li><a href="register.cfm"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
					<li><a href="login.cfm"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
				</cfif>
			</ul>
		</div>
	</nav>
	<div class="container">
