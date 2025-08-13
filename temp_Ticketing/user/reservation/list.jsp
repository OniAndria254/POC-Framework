<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Booking" %>
<%@ page import="model.Utilisateur" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Réservations</title>
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
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #007BFF; /* Blue */
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .actions a {
            color: #007BFF; /* Blue */
            text-decoration: none;
            margin-right: 10px;
        }
        .actions a:hover {
            text-decoration: underline;
        }
        .filter-form {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 20px;
        }
        .filter-group {
            flex: 1;
            min-width: 150px;
        }
        .filter-group label {
            margin-bottom: 5px;
        }
        .filter-group input,
        .filter-group select {
            width: 100%;
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
        <h2>Mes Réservations</h2>
        <table>
            <tr>
                <th>Numéro de Réservation</th>
                <th>Numéro de Vol</th>
                <th>Date de Réservation</th>
                <!-- <th>Type de Siège</th> -->
                <!-- <th>Type de Passager</th> -->
                <!-- <th>Prix</th> -->
                <!-- <th>Statut</th> -->
                <th>Client</th>
                <th>Action</th>

            </tr>
            <% for (Booking booking : (List<Booking>)request.getAttribute("bookings")) { %>
            <tr>
                <td><%= booking.getId() %></td>
                <td><%= booking.getId_vol() %></td>
                <td><%= booking.getDate_booking() %></td>
                <td><%= Utilisateur.getById(booking.getId_utilisateur()).getUsername() %></td>
                <td class="actions">
                    <a href="/Ticketing/reservation/details?id=<%= booking.getId() %>">Voir détails</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
</body>
</html>
