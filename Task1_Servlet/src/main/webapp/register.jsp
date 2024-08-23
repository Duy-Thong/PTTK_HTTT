<%@ page import="org.example.logindemojsp.DAO.UserDAO" %>
<%@ page import="org.example.logindemojsp.DatabaseConnection" %>
<%@ page import="org.example.logindemojsp.Model.User" %>

<html>
<head>
    <title>Sign Up</title>
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
        input[type="text"], input[type="password"], input[type="email"], input[type="submit"] {
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
    <h2>Sign Up</h2>
    <form action="register.jsp" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required>

        <input type="submit" value="Sign Up">
    </form>

    <%
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String message = null;
        String errorMessage = null;

        if (username != null && email != null && password != null) {
            try {
                UserDAO userDAO = new UserDAO(DatabaseConnection.getConnection());
                User existingUser = userDAO.getUserByUsername(username);

                if (existingUser == null) {
                    User newUser = new User();
                    newUser.setUsername(username);
                    newUser.setEmail(email); // Set the email field
                    newUser.setPassword(password);

                    userDAO.saveUser(newUser);
                    message = "Registration successful! You can now log in.";
                } else {
                    errorMessage = "Username already exists. Please choose another.";
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
