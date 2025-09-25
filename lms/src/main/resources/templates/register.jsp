<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Poppins', sans-serif;
    }
    body {
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 10px;
      background: linear-gradient(135deg, #71b7e6, rgb(76, 129, 241));
    }
    .container {
      max-width: 700px;
      width: 100%;
      background-color: #fff;
      padding: 25px 30px;
      border-radius: 5px;
      box-shadow: 0 5px 10px rgba(0, 0, 0, 0.15);
    }
    .container .title {
      font-size: 25px;
      font-weight: 500;
      position: relative;
    }
    .container .title::before {
      content: "";
      position: absolute;
      left: 0;
      bottom: 0;
      height: 3px;
      width: 30px;
      border-radius: 5px;
      background: linear-gradient(135deg, #71b7e6, rgb(76, 129, 241));
    }
    .content form .user-details {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      margin: 20px 0 12px 0;
    }
    form .user-details .input-box {
      margin-bottom: 15px;
      width: calc(100% / 2 - 20px);
    }
    form .input-box span.details {
      display: block;
      font-weight: 500;
      margin-bottom: 5px;
    }
    .user-details .input-box input {
      height: 45px;
      width: 100%;
      outline: none;
      font-size: 16px;
      border-radius: 5px;
      padding-left: 15px;
      border: 1px solid #ccc;
      border-bottom-width: 2px;
      transition: all 0.3s ease;
    }
    .user-details .input-box input:focus,
    .user-details .input-box input:valid {
      border-color: rgb(76, 129, 241);
    }
    form .button {
      height: 45px;
      margin: 35px 0;
    }
    form .button input {
      height: 100%;
      width: 100%;
      border-radius: 5px;
      border: none;
      color: #fff;
      font-size: 18px;
      font-weight: 500;
      letter-spacing: 1px;
      cursor: pointer;
      transition: all 0.3s ease;
      background: linear-gradient(135deg, #71b7e6, rgb(76, 129, 241));
    }
    form .button input:hover {
      background: linear-gradient(-135deg, #71b7e6, rgb(76, 129, 241));
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="title">Library Management System</div>
    <div class="content">
      <form id="registerForm" action="/register" method="POST" autocomplete="off">
        <div class="user-details">
          <div class="input-box">
            <span class="details">Full Name</span>
            <input type="text" placeholder="Enter your name" name="name" required>
          </div>
          <div class="input-box">
            <span class="details">Mobile Number</span>
            <input type="text" placeholder="Enter your mobile number" name="username" id="mobileNumber" required>
          </div>
          <div class="input-box">
            <span class="details">Email</span>
            <input type="text" placeholder="Enter your email" name="email" required>
          </div>
          <div class="input-box">
            <span class="details">Address</span>
            <input type="text" placeholder="Enter your address" name="address" required>
          </div>
          <div class="input-box">
            <span class="details">Password</span>
            <input type="password" placeholder="Enter your password" name="password" id="password" required>
          </div>
          <div class="input-box">
            <span class="details">Confirm Password</span>
            <input type="password" placeholder="Confirm your password" id="confirmPassword" required>
          </div>
          <input type="hidden" value="USER" name="role">
          <input type="hidden" value="0" name="due">
        </div>
        <div class="button">
          <input type="submit" value="Register">
        </div>
      </form>
    </div>
    <div style="text-align: center; margin-top: 15px;">
      <span>Already have an account? </span>
      <a href="/login" style="color: rgb(76, 129, 241); text-decoration: none; font-weight: 500;">Login here</a>
    </div>
  </div>

  <script>
  const existingNumbers = [[${numberslist}]];
  document.getElementById('registerForm').addEventListener('submit', function (event) {
    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    const mobileNumber = document.getElementById('mobileNumber').value;

    // Check if password and confirm password match
    if (password !== confirmPassword) {
      alert('Passwords do not match!');
      event.preventDefault();
      return;
    }

    // Check if mobile number is 10 digits
    if (!/^\d{10}$/.test(mobileNumber)) {
      alert('Mobile number must be exactly 10 digits.');
      event.preventDefault();
      return;
    }
  });
</script>
</body>
</html>
