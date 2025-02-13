<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire</title>
</head>
<body>
    <h2>Formulaire de validation</h2>

    <form action="/Sprint14/emp/androany" method="post">
        <label for="nom">Nom:</label>
        <input type="text" name="emp.name" 
            value="${param['emp.name'] != null ? param['emp.name'] : previousValues['name']}" />
        <span style="color: red;">${errors['name']}</span>

        <label for="nom">Age:</label>

        <input type="number" name="emp.age"
            value="${param['emp.age'] != null ? param['emp.age'] : previousValues['age']}" />
        <span style="color: red;">${errors['age']}</span>

        <label for="nom">Telephone:</label>

        <input type="text" name="emp.telephone"
            value="${param['emp.telephone'] != null ? param['emp.telephone'] : previousValues['telephone']}" />
        <span style="color: red;">${errors['telephone']}</span>


        <input type="submit" value="Envoyer">
    </form>
</body>
</html>
