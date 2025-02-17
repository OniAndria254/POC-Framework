<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter une Configuration de Réservation</title>
</head>
<body>
    <h2>Ajouter une Configuration de Réservation</h2>
    <form action="/Ticketing/config/save" method="post">
        <label for="nb_heure_res">Nombre d'heures pour réserver :</label>
        <input type="number" id="nb_heure_res" name="nb_heure_res" required>
        <br><br>

        <label for="nb_heure_annulation">Nombre d'heures pour annuler :</label>
        <input type="number" id="nb_heure_annulation" name="nb_heure_annulation" required>
        <br><br>

        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>
