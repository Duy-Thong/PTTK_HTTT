<%@ page import="org.example.logindemojsp.DAO.UserDAO" %>
<%@ page import="org.example.logindemojsp.DatabaseConnection" %>
<%@ page import="org.example.logindemojsp.Model.User" %>

<%
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  String errorMessage = null;

  if (username != null && password != null) {
    try {
      UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
      User user = userDAO.getUserByUsernameAndPassword(username, password);

      if (user != null) {
        errorMessage = "Login success";
      } else {
        errorMessage = "Invalid username or password";
      }
    } catch (Exception e) {
      e.printStackTrace();
      errorMessage = "Something went wrong. Please try again.";
    }
  }
%>

<html>
<head>
  <title>Login</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f2f2f2;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }
    .container {
      background-color: #fff;
      padding: 20px;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      width: 300px;
    }
    h2 {
      text-align: center;
      color: #333;
    }
    label {
      display: block;
      margin-bottom: 8px;
      color: #333;
    }
    input[type="text"], input[type="password"], input[type="submit"] {
      width: 100%;
      padding: 10px;
      margin-bottom: 10px;
      border: 1px solid #ccc;
      border-radius: 4px;
    }
    input[type="submit"] {
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
    }
    input[type="submit"]:hover {
      background-color: #45a049;
    }
    .message {
      text-align: center;
      color: green;
    }
    .errorMessage {
      text-align: center;
      color: red;
    }
    .links {
      text-align: center;
    }
    .links a {
      text-decoration: none;
      color: #4CAF50;
      margin: 0 10px;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>Login</h2>
  <% if (errorMessage != null) { %>
  <div class="errorMessage"><%= errorMessage %></div>
  <% } %>

  <form action="login.jsp" method="post">
    <label for="username">Username:</label>
    <input type="text" id="username" name="username" required><br><br>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required><br><br>

    <input type="submit" value="Login">
  </form>

  <div class="links">
    <a href="forgot_password.jsp">Forgot Password</a>
    <a href="register.jsp">Sign Up</a>
  </div>
</div>
</body>
</html>
