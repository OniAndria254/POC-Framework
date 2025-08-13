<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        header {
            background-color: #007BFF; /* Blue */
            color: white;
            padding: 10px 0;
            text-align: center;
        }
        nav {
            background-color: #0056b3; /* Darker blue */
            padding: 10px;
            text-align: center;
        }
        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
        }
        nav ul li {
            margin: 0 15px;
        }
        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 4px;
            transition: background-color 0.3s;
        }
        nav ul li a:hover {
            background-color: #004080; /* Darker blue */
        }
        .container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #007BFF; /* Blue */
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="/Ticketing/vol/list">Liste des Vols</a></li>
            <li><a href="/Ticketing/reservation/list">Mes Réservations</a></li>
            <li><a href="/Ticketing/reservation/new?id_vol=">Réserver un Vol</a></li>
            <li><a href="/Ticketing/disconnect">Déconnexion</a></li>

        </ul>
    </nav>

    <div class="container">
        <h2>Bienvenue sur notre plateforme de réservation de vols</h2>
        <p>Utilisez les liens ci-dessus pour explorer les vols disponibles ou effectuer une réservation.</p>
    </div>
</body>
</html>