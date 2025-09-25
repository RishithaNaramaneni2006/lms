<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="ISO-8859-1">
    <title>Library Management System - Book Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
        }

        /* Navbar Styles */
        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: rgb(76, 129, 241);
            position: fixed;  /* Keep navbar fixed at the top */
            top: 0;
            width: 100%;
            z-index: 1000;  /* Ensure navbar stays on top */
        }

        li {
            float: left;
        }

        li a {
           display: block;
  color: white;
  text-align: center;
  padding: 40px 10px;
  text-decoration: none;
  font-size: 30px;
        }

        li a:hover {
            background-color: rgb(7, 59, 172);
        }

        .title {
            font-size: 40px;
  font-weight: 600;
  padding: 30px 10px;
  border-left: none;
        }

        .title:hover {
            background-color: rgb(76, 129, 241);
        }

        /* Main Content Wrapper */
        .main-content {
            display: flex;
            justify-content: center;
            align-items: center;
            height: calc(100vh - 80px);  /* Adjusted to avoid overlap with navbar */
            padding: 20px;
            margin-top: 80px;  /* Push content below navbar */
        }

        /* Book Details Container */
        .container {
            display: flex;
            background-color: #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 80%;
            max-width: 1000px;
            overflow: hidden;
        }

        .left-section, .right-section {
            padding: 20px;
        }

        .left-section {
            width: 40%;
            background-color: #f8f8f8;
            text-align: center;
            border-right: 1px solid #ddd;
        }

        .left-section img {
            width: 60%;
            height: 300px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .left-section h2 {
            margin: 10px 0;
            color: #333;
        }

        .left-section p {
            color: #555;
            font-size: 16px;
        }

        .right-section {
            width: 60%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .right-section p {
            font-size: 18px;
            margin: 15px 0;
            color: #333;
        }

        .right-section .price {
            color: #e63946;
            font-weight: bold;
        }

        .borrow-btn, .submit-rating-btn {
            margin-top: 20px;
            padding: 12px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007BFF;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            align-self: flex-start;
        }

        .borrow-btn:hover, .submit-rating-btn:hover {
            background-color: #0056b3;
        }

        .rating-section label {
            font-size: 18px;
            color: #333;
            margin-right: 10px;
            cursor: pointer;
        }

        .rating-section input[type="radio"] {
            margin-right: 5px;
            cursor: pointer;
        }
        .USER{
        display:none;
        }
         .no {
            margin-top: 30px;
        }
        .yes{
        display:none;
        }
        
        .y{
        display:none;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<ul>
    <li><a class="title">Library Management System</a></li>
    <li style="float:right"><a href="/logout">Logout</a></li>
    <li style="float:right"><a href="/payments">Payments</a></li>
    <li style="float:right"><a href="/borrows">Borrows</a></li>
    <li style="float:right"><a href="/books">Books</a></li>
    <li th:class="${user.role}" style="float:right"><a href="/users">Users</a></li>
    <li style="float:right"><a href="/home">Home</a></li>
</ul>

<!-- Main Content -->
<div class="main-content">
    <div class="container">
        <!-- Left Section: Book Image and Details -->
        <div class="left-section">
            <img th:src="@{'/bookimage/' + ${book.id}}" alt="Image not found">
            <h2 th:text="${book.name}">Book Name</h2>
            <p th:text="'Authors: ' + ${book.authors}">Authors</p>
        </div>

        <!-- Right Section: Quantity, Price, Borrow Button, Rating -->
        <div class="right-section">
            <p th:text="'Rating: ' + ${rating}">Rating</p>
            <p th:text="'Quantity Available: ' + ${book.quantity}">Quantity</p>
            <p class="price" th:text="'Price per Hour: ₹' + ${book.ppp}">Price per Hour</p>

            <!-- Deposit Button -->
            <form th:class="${isnb}" action="/deposit" method="post" th:object="${deposit}">
                <input type="hidden" name="bookId" th:value="${book.id}">
                <input type="hidden" name="username" th:value="${user.username}">
                <button class="borrow-btn">Deposit</button>
            </form>

            <!-- Borrow Button -->
            <form th:class="${isb}" action="/borrow" method="post" th:object="${borrow}">
                <input type="hidden" name="bookId" th:value="${book.id}">
                <input type="hidden" name="username" th:value="${user.username}">
                <button class="borrow-btn">Borrow</button>
            </form>

            <!-- Rating Section -->
            <div th:class="${isr}">
                <form action="/submitRating" method="post" th:object="${rating}">
                    <input type="hidden" name="bookId" th:value="${book.id}" />
                    <input type="hidden" name="username" th:value="${user.username}" />
                    <label>Rate this Book:</label><br>

                    <label><input type="radio" name="rating" value="1"> 1</label>
                    <label><input type="radio" name="rating" value="2"> 2</label>
                    <label><input type="radio" name="rating" value="3"> 3</label>
                    <label><input type="radio" name="rating" value="4"> 4</label>
                    <label><input type="radio" name="rating" value="5"> 5</label>

                    <button type="submit" class="submit-rating-btn">Submit Rating</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>
