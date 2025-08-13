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

<%@ include file="/includes/css.jsp" %>
<%@ include file="/includes/nav-admin.jsp" %>

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
        <!-- <a href="/Ticketing/vol/new" class="add-link">Ajouter un Vol</a> -->
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
                    <a href="/Ticketing/vol/edit?id=<%= v.getId() %>">Modifier</a>
                    <a href="/Ticketing/vol/delete?id=<%= v.getId() %>" onclick="return confirm('Voulez-vous supprimer ce vol ?');">Supprimer</a>
                </td>
            </tr>
            <% } } %>
        </table>
    </div>
</body>
</html>