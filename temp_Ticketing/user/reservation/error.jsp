<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Erreur Réservation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-danger" role="alert">
            <h4 class="alert-heading">Erreur lors de la réservation</h4>
            <p>${error}</p>
            <hr>
            <a href="/Ticketing/reservation/new?id_vol=" class="btn btn-primary">Retour à la page de réservation</a>
        </div>
    </div>
</body>
</html>
