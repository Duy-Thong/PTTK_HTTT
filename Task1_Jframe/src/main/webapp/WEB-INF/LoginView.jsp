<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login MVC</title>
</head>
<body>
    <form action="${pageContext.request.contextPath}/login" method="post">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username"><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br>

        <input type="submit" value="Login">
    </form>
    <p>${message}</p>
</body>
</html>
