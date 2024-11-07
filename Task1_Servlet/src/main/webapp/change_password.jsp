<!-- filepath: /d:/Learning/PTTK_HTTT/Task1_Servlet/src/main/webapp/change_password.jsp -->
<%@ page import="org.example.logindemojsp.DAO.UserDAO" %>
<%@ page import="org.example.logindemojsp.DatabaseConnection" %>
<%@ page import="org.example.logindemojsp.Model.User" %>

<%
  String username = (String) session.getAttribute("username");
  String oldPassword = request.getParameter("oldPassword");
  String newPassword = request.getParameter("newPassword");
  String confirmPassword = request.getParameter("confirmPassword");
  String errorMessage = null;
  String successMessage = null;

  if (username == null) {
    errorMessage = "You must be logged in to change your password.";
  } else if (oldPassword == null || newPassword == null || confirmPassword == null) {
    errorMessage = "All fields are required.";
  } else {
    if (!newPassword.equals(confirmPassword)) {
      errorMessage = "New password and confirm password do not match.";
    } else if (newPassword.length() < 8 || !newPassword.matches(".*\\d.*") || !newPassword.matches(".*[A-Z].*") || !newPassword.matches(".*[@#$&*].*")) {
      errorMessage = "Password must be at least 8 characters long, contain at least one numeric digit, one uppercase letter, and one special character (@, #, $, &, *).";
    } else {
      try {
        UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
        User user = userDAO.getUserByUsernameAndPassword(username, oldPassword);

        if (user != null) {
          userDAO.updatePassword(username, newPassword);
          successMessage = "Password changed successfully.";
        } else {
          errorMessage = "Invalid old password.";
        }
      } catch (Exception e) {
        e.printStackTrace();
        errorMessage = "Something went wrong. Please try again.";
      }
    }
  }
%>

<html>
<head>
  <title>Change Password</title>
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
    input[type="password"], input[type="submit"] {
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
  </style>
</head>
<body>
<div class="container">
  <h2>Change Password</h2>
  <% if (errorMessage != null) { %>
  <div class="errorMessage"><%= errorMessage %></div>
  <% } %>
  <% if (successMessage != null) { %>
  <div class="message"><%= successMessage %></div>
  <% } %>

  <form action="change_password.jsp" method="post">
    <label for="oldPassword">Old Password:</label>
    <input type="password" id="oldPassword" name="oldPassword" required><br><br>

    <label for="newPassword">New Password:</label>
    <input type="password" id="newPassword" name="newPassword" required><br><br>

    <label for="confirmPassword">Confirm New Password:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>

    <input type="submit" value="Change Password">
  </form>
</div>
</body>
</html>