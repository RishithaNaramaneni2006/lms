<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Payments</title>
<style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            background-color: #ffffff;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 15px 20px;
            text-align: center;
        }

        thead {
            background-color: #4c81f1;
            color: #ffffff;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tbody tr:nth-child(odd) {
            background-color: #ffffff;
        }

        tbody tr:hover {
            background-color: #dce6ff;
            transition: background-color 0.3s ease;
        }

        th {
            font-size: 16px;
            border-bottom: 2px solid #ddd;
        }

        td {
            color: #333;
            font-size: 15px;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            table, thead, tbody, th, td, tr {
                display: block;
            }

            thead tr {
                display: none;
            }

            tbody tr {
                margin-bottom: 15px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
                padding: 10px;
                background-color: #ffffff;
            }

            tbody td {
                text-align: right;
                position: relative;
                padding-left: 50%;
                font-size: 14px;
            }

            tbody td::before {
                content: attr(data-label);
                position: absolute;
                left: 20px;
                width: 45%;
                text-align: left;
                font-weight: bold;
                color: #555;
                text-transform: uppercase;
            }
        }
        
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
  border-left: none;
}
.title:hover{
  background-color: rgb(76, 129, 241);
}
.USER{
display:none;
}

/* Add Payment Form Styling */
.add-payment-form {
    display: none;  /* Initially hidden */
    background-color: white;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    max-width: 400px;
    margin: 20px auto;
}

.add-payment-form select,
.add-payment-form input[type="number"] {
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
.y{
display:none;
}

</style>
</head>
<body>
<ul>
        <li ><a class="title">Library Management System</a></li>
        <li style="float:right"><a href="/logout">Logout</a></li>
        <li style="float:right"><a href="/payments">Payments</a></li>
        <li style="float:right"><a href="/borrows">Borrows</a></li>
        <li style="float:right"><a href="/books">Books</a></li>
        <li th:class="${user.role}" style="float:right"><a href="/users">Users</a></li>
        <li style="float:right"><a href="/home">Home</a></li>
</ul>

<h1>Payments List<br><a th:class="${r}">DUE:[[${user.due}]]</a></h1>

<!-- Add Payment Button -->
<button th:class="${user.role}" style="background-color: rgb(76, 129, 241);"  onclick="showAddPaymentForm()">Add Payment</button>

<!-- Add Payment Form -->
<div class="add-payment-form" id="addPaymentForm">
    <form action="/addPayment" method="post" th:object="${payment}">
            <select name="username" required>
                <option value="" disabled selected>Select Number</option>
                <!-- Dynamically populate with ${usernames} -->
                <option th:each="username : ${usernames}" th:value="${username}" th:text="${username}"></option>
            </select>
        <input type="number" name="paid" placeholder="Amount Paid" required>
        <div class="form-buttons">
            <input type="submit" value="Submit Payment">
            <button type="button" onclick="hideAddPaymentForm()">Cancel</button>
        </div>
    </form>
</div>

<table>
    <thead>
        <tr>
            <th>S.no</th>
            <th>User Name</th>
            <th>User Mobile Number</th>
            <th>Payment</th>
            <th>Date-Time</th>
        </tr>
    </thead>
    <tbody>
        <tr th:each="payment, status : ${payments}">
            <td data-label="S.no" th:text="${status.index + 1}"></td>
            <td data-label="User Name" th:text="${ext[status.index]}"></td>
            <td data-label="User Mobile Number" th:text="${payment.username}"></td>
            <td data-label="Book Name" th:text="${payment.paid}"></td>
            <td data-label="Date-Time" th:text="${payment.date_time}"></td>
        </tr>
    </tbody>
</table>

<script>
    // Show Add Payment Form
    function showAddPaymentForm() {
        document.getElementById('addPaymentForm').style.display = 'block';
        document.getElementById('addPaymentBtn').style.display = 'none';
    }

    // Hide Add Payment Form
    function hideAddPaymentForm() {
        document.getElementById('addPaymentForm').style.display = 'none';
        document.getElementById('addPaymentBtn').style.display = 'block';
    }
</script>

</body>
</html>
