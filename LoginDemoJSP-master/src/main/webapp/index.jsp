<%@ page import="org.example.logindemojsp.Model.User" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head><title>Welcome</title></head>
<body>
<%
    User user = (User) session.getAttribute("user");
    if (user != null) {
%>
<h1>Welcome, <%= user.getUsername() %></h1>
<a href="logout">Logout</a>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
</body>
</html>
