
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<style>
    /* styles.css */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

header {
    background-color: #003366; /* Dark blue */
    color: white;
    padding: 10px 0;
    text-align: center;
}

nav {
    background-color: #002244; /* Darker blue */
    padding: 10px;
    text-align: center;
}

nav ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
}

nav ul li {
    margin: 0 15px;
}

nav ul li a {
    color: white;
    text-decoration: none;
    font-weight: bold;
    padding: 5px 10px;
    border-radius: 4px;
    transition: background-color 0.3s;
}

nav ul li a:hover {
    background-color: #005588; /* Lighter blue */
}

.container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
    color: #003366; /* Dark blue */
    margin-bottom: 20px;
}

label {
    display: block;
    margin-bottom: 5px;
    color: #003366; /* Dark blue */
    font-weight: bold;
}

input[type="text"],
input[type="number"],
input[type="date"],
select {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
}

input[type="submit"] {
    background-color: #003366; /* Dark blue */
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
}

input[type="submit"]:hover {
    background-color: #002244; /* Darker blue */
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

th {
    background-color: #003366; /* Dark blue */
    color: white;
}

tr:nth-child(even) {
    background-color: #f9f9f9;
}

tr:hover {
    background-color: #f1f1f1;
}

.actions a {
    color: #003366; /* Dark blue */
    text-decoration: none;
    margin-right: 10px;
}

.actions a:hover {
    text-decoration: underline;
}

.add-link {
    display: inline-block;
    margin-bottom: 20px;
    color: #003366; /* Dark blue */
    text-decoration: none;
    font-weight: bold;
}

.add-link:hover {
    text-decoration: underline;
}

.filter-form {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin-bottom: 20px;
}

.filter-group {
    flex: 1;
    min-width: 150px;
}

.filter-group label {
    margin-bottom: 5px;
}

.filter-group input,
.filter-group select {
    width: 100%;
}

/* Styles spécifiques pour input[type="date"] */
input[type="datetime-local"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 16px;
    background-color: #fff;
    color: #003366; /* Dark blue */
    cursor: pointer;
}


</style>
