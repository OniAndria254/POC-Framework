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

<html>
<head>
    <title>Liste des Vols</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid black; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        form { margin-bottom: 20px; }
    </style>
</head>
<body>
    <h2>Filtrer les Vols</h2>
    <form action="/Ticketing/vol/filter" method="get">
        <input type="hidden" name="action" value="filter">
        
        <label>Ville Départ:</label>
        <select name="id_ville_depart">
            <option value="">-- Toutes --</option>
            <% if (villes != null) {
                for (Ville ville : villes) { %>
                    <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
            <% } } %>
        </select>
    
        <label>Ville Arrivée:</label>
        <select name="id_ville_arrivee">
            <option value="">-- Toutes --</option>
            <% if (villes != null) {
                for (Ville ville : villes) { %>
                    <option value="<%= ville.getId() %>"><%= ville.getNom() %></option>
            <% } } %>
        </select>
    
        <label>Date Départ:</label>
        <input type="date" name="date_depart">
    
        <label>Date Arrivée:</label>
        <input type="date" name="date_arrivee">
    
        <label>Prix Min:</label>
        <input type="number" name="prix_min" step="0.01">
    
        <label>Prix Max:</label>
        <input type="number" name="prix_max" step="0.01">
    
        <label>Modèle d'Avion:</label>
        <select name="id_avion">
            <option value="">-- Tous --</option>
            <% if (avions != null) {
                for (Avion avion : avions) { %>
                    <option value="<%= avion.getId() %>"><%= avion.getModele() %></option>
            <% } } %>
        </select>
    
        <input type="submit" value="Filtrer">
    </form>
    

<h2>Liste des Vols</h2>
<a href="/Ticketing/vol/new">Ajouter un Vol</a>
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
        <td>
            <a href="/Ticketing/vol/edit?id=<%= v.getId() %>">Modifier</a>
            <a href="/Ticketing/vol/delete?id=<%= v.getId() %>" onclick="return confirm('Voulez-vous supprimer ce vol ?');">Supprimer</a>
        </td>
    </tr>
    <% } } %>
</table>

</body>
</html>
