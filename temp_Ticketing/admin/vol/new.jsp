<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>

<%
    Vol vol = (Vol) request.getAttribute("vol");
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");
    List<Avion> avions = (List<Avion>) request.getAttribute("avions");
%>

<%@ include file="/includes/css.jsp" %>
<%@ include file="/includes/nav-admin.jsp" %>

<div class="container">
    <h2><%= (vol != null) ? "Modifier un Vol" : "Ajouter un Vol" %></h2>

    <form action="/Ticketing/vol/save" method="post">
        <input type="hidden" name="vol.id" value="${param['vol.id'] != null ? param['vol.id'] : vol.id}">

        <label>Prix Business:</label>
        <input type="number" name="vol.prix_business" 
               value="${param['vol.prix_business'] != null ? param['vol.prix_business'] : vol.prix_business}" required>
        <span style="color: red;">${errors['prix_business']}</span><br>

        <label>Prix Eco:</label>
        <input type="number" name="vol.prix_eco" 
               value="${param['vol.prix_eco'] != null ? param['vol.prix_eco'] : vol.prix_eco}" required>
        <span style="color: red;">${errors['prix_eco']}</span><br>

        <label>Date Départ:</label>
        <input type="datetime-local" name="vol.date_depart" 
               value="${param['vol.date_depart'] != null ? param['vol.date_depart'] : vol.date_depart}" required>
        <span style="color: red;">${errors['date_depart']}</span><br>

        <label>Date Arrivée:</label>
        <input type="datetime-local" name="vol.date_arrivee" 
               value="${param['vol.date_arrivee'] != null ? param['vol.date_arrivee'] : vol.date_arrivee}" required>
        <span style="color: red;">${errors['date_arrivee']}</span><br>

        <label>Ville Départ:</label>
        <select name="vol.id_ville_depart">
            <option value="">-- Choisir une ville de départ --</option>
            <% if (villes != null) {
                for (Ville ville : villes) {
                    String selected = (request.getParameter("vol.id_ville_depart") != null && 
                                    request.getParameter("vol.id_ville_depart").equals(ville.getId())) || 
                                    (vol != null && vol.getId_ville_depart().equals(ville.getId())) ? "selected" : "";
            %>
            <option value="<%= ville.getId() %>" <%= selected %>><%= ville.getNom() %></option>
            <% } } %>
        </select>
        <span style="color: red;">${errors['id_ville_depart']}</span><br>

        <label>Ville Arrivée:</label>
        <select name="vol.id_ville_arrivee">
            <option value="">-- Choisir une ville d'arrivée --</option>
            <% if (villes != null) {
                for (Ville ville : villes) {
                    String selected = (request.getParameter("vol.id_ville_arrivee") != null && 
                                    request.getParameter("vol.id_ville_arrivee").equals(ville.getId())) || 
                                    (vol != null && vol.getId_ville_arrivee().equals(ville.getId())) ? "selected" : "";
            %>
            <option value="<%= ville.getId() %>" <%= selected %>><%= ville.getNom() %></option>
            <% } } %>
        </select>
        <span style="color: red;">${errors['id_ville_arrivee']}</span><br>

        <label>Avion:</label>
        <select name="vol.id_avion" required>
            <option value="">-- Choisir un avion --</option>
            <% if (avions != null) {
                for (Avion avion : avions) {
                    String selected = (request.getParameter("vol.id_avion") != null && 
                                    request.getParameter("vol.id_avion").equals(avion.getId())) || 
                                    (vol != null && vol.getId_avion().equals(avion.getId())) ? "selected" : "";
            %>
            <option value="<%= avion.getId() %>" <%= selected %>><%= avion.getModele() %></option>
            <% } } %>
        </select>
        <span style="color: red;">${errors['id_avion']}</span><br>

        <input type="submit" value="<%= (vol != null) ? "Modifier" : "Ajouter" %>">
    </form>
</div>
</body>
</html>
