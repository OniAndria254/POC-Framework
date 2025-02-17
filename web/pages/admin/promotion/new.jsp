<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Vol" %>
<%@ page import="model.TypeSiege" %>

<%
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<TypeSiege> typesSiege = (List<TypeSiege>) request.getAttribute("typesSiege");
%>

<html>
<head>
    <title>Ajouter une Promotion</title>
</head>
<body>

<h2>Ajouter une Promotion</h2>

<form action="/Ticketing/promotion/save" method="post">
    <label>Vol:</label>
    <select name="promotion.id_vol" required>
        <% if (vols != null) {
            for (Vol vol : vols) { %>
                <option value="<%= vol.getId() %>"><%= vol.getId() %> - <%= vol.getDate_depart() %></option>
        <% } } %>
    </select><br>

    <label>Type de Siège:</label>
    <select name="promotion.id_type_siege" required>
        <% if (typesSiege != null) {
            for (TypeSiege type : typesSiege) { %>
                <option value="<%= type.getId() %>"><%= type.getNom_type() %></option>
        <% } } %>
    </select><br>

    <label>Pourcentage de Promotion:</label>
    <input type="number" name="promotion.pourcentage_promotion" step="0.01" required><br>

    <label>Nombre de Sièges en Promotion:</label>
    <input type="number" name="promotion.nb_sieges_promotion" required><br>

    <label>Date Début:</label>
    <input type="datetime-local" name="promotion.date_debut" required><br>

    <label>Date Fin:</label>
    <input type="datetime-local" name="promotion.date_fin" required><br>

    <input type="submit" value="Ajouter">
</form>

<a href="/Ticketing/promotion/list">Retour à la liste</a>

</body>
</html>
