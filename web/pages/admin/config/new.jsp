<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="/includes/css.jsp" %>
<%@ include file="/includes/nav-admin.jsp" %>

    <div class="container">
        <h2>Ajouter une Configuration de Réservation</h2>
        <form action="/Ticketing/config/save" method="post">
            <label for="nb_heure_res">Nombre d'heures pour réserver :</label>
            <input type="number" id="nb_heure_res" name="config.nb_heure_res" required>
            <br><br>

            <label for="nb_heure_annulation">Nombre d'heures pour annuler :</label>
            <input type="number" id="nb_heure_annulation" name="config.nb_heure_annulation" required>
            <br><br>

            <label for="date_heure">Date et Heure :</label>
            <input type="datetime-local" id="date_heure" name="config.date_config" required>
            <br><br>

            <input type="submit" value="Enregistrer">
        </form>
    </div>
</body>
</html>