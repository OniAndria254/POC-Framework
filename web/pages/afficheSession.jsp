<%@page import="model.Employe"%>
<%@page import="model.User"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        int id = (int) request.getSession().getAttribute("id");
        User user = User.getById(id);
    %>
    <p>Id: <%= user.getId() %></p>
    <p>Username: <%= user.getUserName() %></p>

    <a href="/Sprint8/disconnect">Disconnect</a>
</body>
</html>