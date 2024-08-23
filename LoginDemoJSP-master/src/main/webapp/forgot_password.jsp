<%@ page import="org.example.logindemojsp.DAO.UserDAO" %>
<%@ page import="org.example.logindemojsp.DatabaseConnection" %>
<%@ page import="org.example.logindemojsp.Model.User" %>
<%@ page import="java.util.UUID" %>

<html>
<head>
    <title>Forgot Password</title>
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
        input[type="email"], input[type="submit"] {
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
    <h2>Forgot Password</h2>
    <form action="forgot_password.jsp" method="post">
        <label for="email">Enter your email:</label>
        <input type="email" id="email" name="email" required><br><br>
        <input type="submit" value="Submit">
    </form>

    <%
        String email = request.getParameter("email");
        String message = null;
        String errorMessage = null;

        if (email != null) {
            try {
                UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
                User user = userDAO.getUserByEmail(email);

                if (user != null) {
                    String token = UUID.randomUUID().toString();
                    // Gửi email với token
                    message = "Check your email to reset your password";
                } else {
                    errorMessage = "Email not found";
                }
            } catch (Exception e) {
                e.printStackTrace();
                errorMessage = "Something went wrong. Please try again.";
            }
        }
    %>

    <%-- Hiển thị thông báo lỗi hoặc thông báo thành công --%>
    <% if (errorMessage != null) { %>
    <p class='errorMessage'><%= errorMessage %></p>
    <% } else if (message != null) { %>
    <p class='message'><%= message %></p>
    <% } %>
</div>
</body>
</html>
