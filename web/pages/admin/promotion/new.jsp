<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>

<%
    List<Vol> vols = (List<Vol>) request.getAttribute("vols");
    List<TypeSiege> typesSiege = (List<TypeSiege>) request.getAttribute("typesSiege");
%>

<%@ include file="/includes/css.jsp" %>
<%@ include file="/includes/nav-admin.jsp" %>

<div class="container">
    <h2>Ajouter une Promotion</h2>
    <form action="/Ticketing/promotion/save" method="post">
        <label>Vol:</label>
        <select name="promotion.id_vol" required>
            <option value="">-- Choisir un vol --</option>
            <% if (vols != null) {
                for (Vol vol : vols) { %>
                    <option value="<%= vol.getId() %>" ${param['promotion.id_vol'] == vol.getId() ? 'selected' : ''}><%= vol.getId() %> - <%= vol.getDate_depart() %></option>
            <% } } %>
        </select>
        <span style="color: red;">${errors['id_vol']}</span><br>

        <label>Type de Siège:</label>
        <select name="promotion.id_type_siege" required>
            <option value="">-- Choisir un type de siège --</option>
            <% if (typesSiege != null) {
                for (TypeSiege type : typesSiege) { %>
                    <option value="<%= type.getId() %>" ${param['promotion.id_type_siege'] == type.getId() ? 'selected' : ''}><%= type.getNom_type() %></option>
            <% } } %>
        </select>
        <span style="color: red;">${errors['id_type_siege']}</span><br>

        <label>Pourcentage de Promotion:</label>
        <input type="number" name="promotion.pourcentage_promotion" value="${param['promotion.pourcentage_promotion']}" required>
        <span style="color: red;">${errors['pourcentage_promotion']}</span><br>

        <label>Nombre de Sièges en Promotion:</label>
        <input type="number" name="promotion.nb_sieges_promotion" value="${param['promotion.nb_sieges_promotion']}" required>

        <input type="hidden" name="promotion.nb_sieges_restants" value="0">

        <span style="color: red;">${errors['nb_sieges_promotion']}</span><br>

        <label>Date Début:</label>
        <input type="datetime-local" name="promotion.date_debut" value="${param['promotion.date_debut']}" required>
        <span style="color: red;">${errors['date_debut']}</span><br>

        <label>Date Fin:</label>
        <input type="datetime-local" name="promotion.date_fin" value="${param['promotion.date_fin']}" required>
        <span style="color: red;">${errors['date_fin']}</span><br>

        <input type="submit" value="Ajouter">
    </form>
</div>
</body>
</html>
