<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f4f9;
    }

    /* Navbar (Do not modify) */
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

    .title {
        font-size: 40px;
        font-weight: 600;
        padding: 30px 10px;
        border-left: none;
    }

    .title:hover {
        background-color: rgb(76, 129, 241);
    }

    .USER {
        display: none;
    }

    /* Main Content Styling */
    .container {
        padding: 20px;
    }

    .welcome {
        text-align: center;
        margin-bottom: 30px;
    }

    .welcome h1 {
        font-size: 48px;
        color: #4c81f1;
        margin-bottom: 10px;
    }

    .welcome p {
        font-size: 20px;
        color: #555;
    }

    /* Cards for Quick Stats */
    .stats-container {
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
        gap: 20px;
    }

    .card {
        background-color: white;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width: 220px;
        padding: 20px;
        text-align: center;
        transition: transform 0.2s;
    }

    .card:hover {
        transform: scale(1.05);
    }

    .card h2 {
        font-size: 36px;
        color: #4c81f1;
        margin: 10px 0;
    }

    .card p {
        font-size: 18px;
        color: #555;
    }

    /* Recent Activity Section */
    .recent-activity {
        margin-top: 40px;
    }

    .recent-activity h2 {
        color: #333;
        text-align: center;
        margin-bottom: 20px;
    }

    .activity-list {
        list-style-type: none;
        padding: 0;
        max-width: 600px;
        margin: 0 auto;
    }

    .activity-list li {
        background-color: white;
        margin: 10px 0;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        color: #555;
    }

    /* Footer Styling */
    .footer {
        background-color: rgb(76, 129, 241);
        color: white;
        text-align: center;
        padding: 15px 0;
        position: fixed;
        bottom: 0;
        width: 100%;
        font-size: 16px;
    }

    @media (max-width: 768px) {
        .stats-container {
            flex-direction: column;
            align-items: center;
        }
    }
</style>
</head>
<body>

<!-- Navbar (Do not modify) -->
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
<div class="container">
    <!-- Welcome Section -->
    <div class="welcome">
        <h1>Welcome to the Library!</h1>
        <p>Your gateway to knowledge and learning.</p>
    </div>

    <!-- Quick Stats Section -->
    <div class="stats-container">
        <div class="card">
            <h2>[[${totalBooks}]]</h2>
            <p>Total Books</p>
        </div>
        <div class="card">
            <h2>[[${borrowedBooks}]]</h2>
            <p>Borrowed Books</p>
        </div>
        <div class="card">
            <h2>[[${totalUsers}]]</h2>
            <p>Registered Users</p>
        </div>
        
    </div>

   
</div>

<!-- Footer -->
<div class="footer">
    &copy; Library Management System
</div>

</body>
</html>
