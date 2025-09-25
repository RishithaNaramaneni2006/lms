<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Book</title>
</head>
<body>
<form action="/addbook" method="post"  enctype="multipart/form-data" th:object="${book}">
    <input type="file" name="bookimage" aria-describedby="inputGroupFileAddon04" aria-label="Upload" required>
    <input type="text" name="name" placeholder="Enter Name">
    <input type="text" name="authors" placeholder="Enter Authors">
    <input type="number" name="quantity" placeholder="Enter Number of books available">
    <input type="number" name="ppp" placeholder="Enter Price per hour">
    <input type="submit" value="Add Book">
</form>
</body>
</html>