<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Vol" %>
<%@ page import="model.Ville" %>
<%@ page import="database.GenericRepo" %>
<%@ page import="util.Utils" %>
<%@ page import="model.Avion" %>

<%
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Vols</title>
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
        <h2>Filtrer les Vols</h2>
        <form action="/Ticketing/vol/filter" method="get" class="filter-form">
            <input type="hidden" name="action" value="filter">
            
            <div class="filter-group">
                <label>Ville Départ:</label>
                <select name="id_ville_depart">
                    <option value="">-- Toutes --</option>
                    <% if (villes != null) {
                        for (Ville ville : villes) { %>
                            <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
                    <% } } %>
                </select>
            </div>
        
            <div class="filter-group">
                <label>Ville Arrivée:</label>
                <select name="id_ville_arrivee">
                    <option value="">-- Toutes --</option>
                    <% if (villes != null) {
                        for (Ville ville : villes) { %>
                            <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
                    <% } } %>
                </select>
            </div>
        
            <div class="filter-group">
                <label>Date Départ:</label>
                <input type="date" name="date_depart">
            </div>
        
            <div class="filter-group">
                <label>Date Arrivée:</label>
                <input type="date" name="date_arrivee">
            </div>
        
            <div class="filter-group">
                <label>Prix Min:</label>
                <input type="number" name="prix_min" step="0.01">
            </div>
        
            <div class="filter-group">
                <label>Prix Max:</label>
                <input type="number" name="prix_max" step="0.01">
            </div>
        
            <div class="filter-group">
                <label>Modèle d'Avion:</label>
                <select name="id_avion">
                    <option value="">-- Tous --</option>
                    <% if (avions != null) {
                        for (Avion avion : avions) { %>
                            <option value="<%= avion.getId() %>"><%= avion.getModele() %></option>
                    <% } } %>
                </select>
            </div>
        
            <div class="filter-group">
                <input type="submit" value="Filtrer">
            </div>
        </form>

        <h2>Liste des Vols</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Prix Business</th>
                <th>Prix Eco</th>
                <th>Date Départ</th>
                <th>Date Arrivée</th>
                <th>Ville Départ</th>
                <th>Ville Arrivée</th>
                <th>Avion</th>
                <th>Actions</th>
            </tr>
            <% if (vols != null) {
                for (Vol v : vols) { %>
            <tr>
                <td><%= v.getId() %></td>
                <td><%= v.getPrix_business() %></td>
                <td><%= v.getPrix_eco() %></td>
                <td><%= v.getDate_depart() %></td>
                <td><%= v.getDate_arrivee() %></td>
                <td><%= Utils.getNomVille(v.getId_ville_depart(), villes) %></td>
                <td><%= Utils.getNomVille(v.getId_ville_arrivee(), villes) %></td>
                <td><%= Utils.getModeleAvion(v.getId_avion(), avions) %></td>
                <td class="actions">
                    <a href="/Ticketing/reservation/new?id_vol=<%= v.getId() %>">Réserver</a>
                </td>
            </tr>
            <% } } %>
        </table>
    </div>
</body>
</html>