<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire</title>
</head>
<body>
    <form action="/Sprint12/emp/upload" method="post" enctype="multipart/form-data">
        <label for="nom">Nom:</label>
        <input type="text" name="emp.name"><br>
        <label for="age">Age:</label>
        <input type="number" name="emp.age"><br>
    
        <label for="file">Upload File:</label>
        <input type="file" name="fileUpload"><br>
    
        <input type="submit" value="Envoyer">
    </form>
    
</body>
</html>