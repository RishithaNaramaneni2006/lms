<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="ISO-8859-1">
    <title>Books</title>
    <style>
        /* General styling */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        /* Navigation Bar Styling */
        ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: rgb(76, 129, 241);
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

.title{
  font-size: 40px;
  font-weight: 600;
  padding: 30px 10px;
}
.title:hover{
  background-color: rgb(76, 129, 241);
}

        /* Search and Add Button Container */
        .action-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }

        .search-bar input[type="text"] {
            padding: 10px;
            width: 300px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .search-bar button {
            padding: 10px 20px;
            font-size: 16px;
            margin-left: 10px;
            background-color: rgb(76, 129, 241);
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .search-bar button:hover {
            background-color: rgb(7, 59, 172);
        }

        .ADMIN button{
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .USER{
            display:none;
        }

        .add-book-button:hover {
            background-color: #388E3C;
        }

        /* Grid Container */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            padding: 20px;
        }

        .book-card {
            background-color: #f8f8f8;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
            text-align: center;
            padding: 15px;
        }

        .book-card:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .book-card img {
            width: 100%;
            height: 180px;
            border-radius: 5px;
            background-color: #e0e0e0;
        }

        .book-details {
            margin-top: 10px;
        }

        .book-details h3 {
            font-size: 18px;
            margin: 10px 0 5px 0;
            color: #333;
        }

        .book-details p {
            margin: 5px 0;
            color: #555;
            font-size: 14px;
        }

        .book-details .price {
            font-weight: bold;
            color: #e63946;
        }

        /* Add Book Form Styling */
        .add-book-form {
            display: none;  /* Initially hidden */
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            margin: 20px auto;
        }

        .add-book-form input[type="text"],
        .add-book-form input[type="number"],
        .add-book-form input[type="file"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .form-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        .form-buttons input[type="submit"],
        .form-buttons button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }

        .form-buttons input[type="submit"] {
            background-color: #4CAF50;
            color: white;
        }

        .form-buttons button {
            background-color: #e63946;
            color: white;
        }

        .form-buttons input[type="submit"]:hover {
            background-color: #388E3C;
        }

        .form-buttons button:hover {
            background-color: #d62828;
        }
    </style>
</head>
<body>

<!-- Navigation Bar -->
<ul>
    <li ><a class="title">Library Management System</a></li>
    <li style="float:right"><a href="/logout">Logout</a></li>
  <li style="float:right"><a href="/payments">Payments</a></li>
  <li style="float:right"><a href="/borrows">Borrows</a></li>
  <li style="float:right"><a href="/Books">Books</a></li>
  <li th:class="${user.role}" style="float:right"><a href="/users">Users</a></li>
  <li style="float:right"><a href="/home">Home</a></li>
</ul>

<!-- Search and Add Book Section -->
<div class="action-container">
    <div class="search-bar">
        <input type="text" id="searchInput" placeholder="Search books by name...">
        <button onclick="filterBooks()">Search</button>
    </div>
    <button th:class="${user.role}" id="addBookBtn" onclick="showAddBookForm()">Add Book</button>
</div>

<!-- Add Book Form -->
<div class="add-book-form" id="addBookForm">
    <form action="/addbook" method="post" enctype="multipart/form-data" th:object="${book}">
        <input type="file" name="bookimage" required>
        <input type="text" name="name" placeholder="Enter Name" required>
        <input type="text" name="authors" placeholder="Enter Authors" required>
        <input type="number" name="quantity" placeholder="Enter Number of books available" required>
        <input type="number" name="ppp" placeholder="Enter Price per hour" required>
        <div class="form-buttons">
            <input type="submit" value="Add Book">
            <button type="button" onclick="hideAddBookForm()">Cancel</button>
        </div>
    </form>
</div>

<!-- Book Grid -->
<div class="grid-container" id="bookGrid">
    <!-- Looping through the list of books -->
    <a th:href="@{'/book/' + ${book.id}}" style="text-decoration: none; color: inherit;" th:each="book,status : ${books}" th:data-name="${book.name}">
        <div class="book-card">
            <img th:src="@{'/bookimage/' + ${book.id}}" alt="Image not found">
            <div class="book-details">
                <h3 th:text="${book.name}">Book Name</h3>
                <p class="price" th:text="'₹' + ${book.ppp} + '/hr'">Price per Hour</p>
                <p th:text="'Authors: ' + ${book.authors}">Authors</p>
                <p th:text="'Rating: ' + ${ratings[status.index]}">Rating</p>
                <p th:text="'Available: ' + ${book.quantity}">Quantity</p>
            </div>
        </div>
    </a>
</div>

<script>
    // Show Add Book Form
    function showAddBookForm() {
        document.getElementById('addBookForm').style.display = 'block';
        document.getElementById('addBookBtn').style.display = 'none';
    }

    // Hide Add Book Form
    function hideAddBookForm() {
        document.getElementById('addBookForm').style.display = 'none';
        document.getElementById('addBookBtn').style.display = 'block';
    }

    // Filter Books by Name
    function filterBooks() {
        const searchInput = document.getElementById('searchInput').value.toLowerCase();
        const books = document.querySelectorAll('.book-card');

        books.forEach(book => {
            const bookName = book.getAttribute('data-name');
            if (bookName.includes(searchInput)) {
                book.style.display = 'block';
            } else {
                book.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>
