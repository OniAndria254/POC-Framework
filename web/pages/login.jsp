<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f8ff; /* Light blue background */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
        }
        h2 {
            color: #003366; /* Dark blue */
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #003366; /* Dark blue */
            text-align: left;
        }
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }
        input[type="submit"] {
            background-color: #003366; /* Dark blue */
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #002244; /* Darker blue */
        }
        .error-message {
            color: red;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <%
            if(request.getAttribute("errorMessage") != null) {
                out.println("<p class='error-message'>" + request.getAttribute("errorMessage") + "</p>");
            }
        %>
        <h2>Login</h2>
        <form action="/Ticketing/login/process" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="utilisateur.username" required><br>
            <label for="password">Password:</label>
            <input type="password" id="password" name="utilisateur.password" required><br>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>