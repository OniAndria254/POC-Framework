<%@page import="model.Employe"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <%
        Employe emp = (Employe)request.getAttribute("employe");
    %>
    <p><%= emp.getName() %></p>
    <p><%= emp.getAge() %></p>
    <p><%= emp.getTelephone() %></p>

    <!-- <p><%= request.getAttribute("errorMessage") %></p> -->

</body>
</html>