<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>

<%
    Vol vol = (Vol) request.getAttribute("vol");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");

%>

<html>
<head>
    <title><%= (vol != null) ? "Modifier un Vol" : "Ajouter un Vol" %></title>
</head>
<body>

<h2><%= (vol != null) ? "Modifier un Vol" : "Ajouter un Vol" %></h2>

<form action="/Ticketing/vol/save" method="post">
    <input type="hidden" name="action" value="<%= (vol != null) ? "update" : "insert" %>">
    <input type="hidden" name="vol.id" value="<%= (vol != null) ? vol.getId() : "" %>">

    <label>Prix Business:</label>
    <input type="number" name="vol.prix_business" value="<%= (vol != null) ? vol.getPrix_business() : "" %>" required><br>

    <label>Prix Eco:</label>
    <input type="number" name="vol.prix_eco" value="<%= (vol != null) ? vol.getPrix_eco() : "" %>" required><br>

    <label>Date Départ:</label>
    <input type="datetime-local" name="vol.date_depart" value="<%= (vol != null) ? vol.getDate_depart() : "" %>" required><br>

    <label>Date Arrivée:</label>
    <input type="datetime-local" name="vol.date_arrivee" value="<%= (vol != null) ? vol.getDate_arrivee() : "" %>" required><br>

    <label>Ville Départ:</label>
    <select name="vol.id_ville_depart" required>
        <% if (villes != null) {
            for (Ville ville : villes) {
                String selected = (vol != null && vol.getId_ville_depart().equals(ville.getId())) ? "selected" : "";
        %>
        <option value="<%= ville.getId() %>" <%= selected %>><%= ville.getNom() %></option>
        <% } } %>
    </select><br>

    <label>Ville Arrivée:</label>
    <select name="vol.id_ville_arrivee" required>
        <% if (villes != null) {
            for (Ville ville : villes) {
                String selected = (vol != null && vol.getId_ville_arrivee().equals(ville.getId())) ? "selected" : "";
        %>
        <option value="<%= ville.getId() %>" <%= selected %>><%= ville.getNom() %></option>
        <% } } %>
    </select><br>

    <label>Avion:</label>
    <select name="vol.id_avion" required>
        <% if (avions != null) {
            for (Avion avion : avions) {
                String selected = (vol != null && vol.getId_avion().equals(avion.getId())) ? "selected" : "";
        %>
        <option value="<%= avion.getId() %>" <%= selected %>><%= avion.getModele() %></option>
        <% } } %>
    </select><br>

    <input type="submit" value="<%= (vol != null) ? "Modifier" : "Ajouter" %>">
</form>

<a href="/Ticketing/vol/list">Retour à la liste</a>

</body>
</html>
