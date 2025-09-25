<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="ISO-8859-1">
    <title>Borrows - Library Management System</title>
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

<h1>Borrowed Books List</h1>

<table>
    <thead>
        <tr>
            <th>S.no</th>
            <th>User Name</th>
            <th>User Mobile Number</th>
            <th>Book Name</th>
            <th>Date-Time</th>
        </tr>
    </thead>
    <tbody>
        <tr th:each="borrow, status : ${borrows}">
            <td data-label="S.no" th:text="${status.index + 1}"></td>
            <td data-label="User Name" th:text="${ext[status.index][1]}"></td>
            <td data-label="User Mobile Number" th:text="${borrow.username}"></td>
            <td data-label="Book Name" th:text="${ext[status.index][0]}"></td>
            <td data-label="Date-Time" th:text="${borrow.date_time}"></td>
        </tr>
    </tbody>
</table>

</body>
</html>
