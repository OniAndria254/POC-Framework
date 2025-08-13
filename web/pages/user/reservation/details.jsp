<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Reservation" %>
<%@ page import="model.TypeSiege" %>
<%@ page import="java.io.File" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails de Réservation</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <style>
        :root {
            --primary-color: #007BFF;
            --secondary-color: #0056b3;
            --accent-color: #e74c3c;
            --text-color: #333;
            --light-gray: #f5f5f5;
            --border-color: #ddd;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light-gray);
            color: var(--text-color);
            line-height: 1.6;
        }
        
        header {
            background-color: var(--primary-color);
            color: white;
            padding: 15px 0;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        nav {
            background-color: var(--secondary-color);
            padding: 12px 0;
            text-align: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
        }
        
        nav ul li {
            margin: 0 10px;
        }
        
        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 600;
            padding: 8px 15px;
            border-radius: 4px;
            transition: all 0.3s ease;
            display: inline-block;
        }
        
        nav ul li a:hover {
            background-color: rgba(255,255,255,0.2);
            transform: translateY(-2px);
        }
        
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 25px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        h2 {
            color: var(--primary-color);
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 2px solid var(--primary-color);
            font-size: 1.8rem;
        }
        
        .reservation-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }
        
        .details-section {
            background-color: var(--light-gray);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }
        
        .details-list {
            list-style-type: none;
            padding: 0;
        }
        
        .details-list li {
            padding: 10px 0;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
        }
        
        .details-list li:last-child {
            border-bottom: none;
        }
        
        .detail-label {
            font-weight: 600;
            color: var(--secondary-color);
        }
        
        .detail-value {
            font-weight: normal;
        }
        
        .document-section {
            margin-top: 20px;
        }
        
        .document-preview {
            width: 100%;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            overflow: hidden;
            margin-top: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .document-preview img {
            width: 100%;
            height: auto;
            display: block;
        }
        
        .document-preview object {
            width: 100%;
            height: 500px;
        }
        
        .document-preview .no-preview {
            padding: 20px;
            text-align: center;
            background-color: var(--light-gray);
            color: #777;
        }
        
        .action-buttons {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }
        
        .btn-danger {
            background-color: var(--accent-color);
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        @media (max-width: 768px) {
            .reservation-details {
                grid-template-columns: 1fr;
            }
            
            nav ul {
                flex-direction: column;
            }
            
            nav ul li {
                margin: 5px 0;
            }
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
            background-color: #007BFF; /* Blue */
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f1f1f1;
        }
        .actions a {
            color: #007BFF; /* Blue */
            text-decoration: none;
            margin-right: 10px;
        }
        .actions a:hover {
            text-decoration: underline;
        }
        @media print {
        body * {
            visibility: hidden;
        }
        .container, .container * {
            visibility: visible;
        }
        .container {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
        }
        .action-buttons, .action-column {
            display: none !important;
        }
        nav {
            display: none;
        }
    }
    </style>
</head>
<body>
    <nav>
        <ul>
            <li><a href="/Ticketing/vol/list">Liste des Vols</a></li>
            <li><a href="/Ticketing/reservation/list">Mes Réservations</a></li>
            <li><a href="/Ticketing/reservation/new?id_vol=">Réserver un Vol</a></li>
            <li><a href="/Ticketing/disconnect">Déconnexion</a></li>
        </ul>
    </nav>

    <%
        List<Reservation> all = (List<Reservation>) request.getAttribute("all");
        Reservation temoin = (Reservation)request.getAttribute("temoin");
        String imagePath = temoin.getImage_path();
        boolean hasDocument = imagePath != null && !imagePath.isEmpty();
        boolean isImage = hasDocument && (imagePath.toLowerCase().endsWith(".jpg") || 
                                         imagePath.toLowerCase().endsWith(".jpeg") || 
                                         imagePath.toLowerCase().endsWith(".png") || 
                                         imagePath.toLowerCase().endsWith(".gif"));
        boolean isPdf = hasDocument && imagePath.toLowerCase().endsWith(".pdf");
  
      String pdfApiBaseUrl = application.getInitParameter("pdfApiBaseUrl"); 
    %>
    
    <div class="container">
        <h2>Détails de la réservation</h2>
        
        <div class="reservation-details">
            <div class="details-section">
                <h3>Informations de réservation</h3>
                <ul class="details-list">
                    <li>
                        <span class="detail-label">Numéro de Réservation:</span>
                        <span class="detail-value"><%= temoin.getId_booking() %></span>
                    </li>
                    <li>
                        <span class="detail-label">Numéro de Vol:</span>
                        <span class="detail-value"><%= temoin.getId_vol() %></span>
                    </li>
                    <li>
                        <span class="detail-label">Date de Réservation:</span>
                        <span class="detail-value"><%= temoin.getDate_reservation() %></span>
                    </li>
                    <li>
                        <span class="detail-label">Type de siège:</span>
                        <span class="detail-value"><%= TypeSiege.getById(temoin.getId_type_siege()).getNom_type() %></span>
                    </li>
                
                </ul>
            </div>
            
            <div class="details-section">
                <h3>Informations passagers</h3>
                <ul class="details-list">
                    <li>
                        <span class="detail-label">Nombre d'adultes:</span>
                        <span class="detail-value"><%= request.getAttribute("nb_adultes") %></span>
                    </li>
                    <li>
                        <span class="detail-label">Nombre d'enfants:</span>
                        <span class="detail-value"><%= request.getAttribute("nb_enfants") %></span>
                    </li>
                </ul>
                
                <!-- <div class="document-section">
                    <h3>Document de voyage</h3>
                    <div class="document-preview">
                        <% if (hasDocument) { %>
                            <% if (isImage) { %>
                                <img src="/Ticketing/file/view?path=<%= java.net.URLEncoder.encode(imagePath, "UTF-8") %>" alt="Document de voyage" />
                            <% } else if (isPdf) { %>
                                <object data="/Ticketing/file/view?path=<%= java.net.URLEncoder.encode(imagePath, "UTF-8") %>" type="application/pdf" width="100%" height="500px">
                                    <p>Impossible d'afficher le PDF. <a href="/Ticketing/file/view?path=<%= java.net.URLEncoder.encode(imagePath, "UTF-8") %>">Télécharger le PDF</a>.</p>
                                </object>
                            <% } else { %>
                                <div class="no-preview">
                                    <p>Type de fichier non pris en charge.<br>
                                    <a href="/Ticketing/file/view?path=<%= java.net.URLEncoder.encode(imagePath, "UTF-8") %>">Télécharger le fichier</a></p>
                                </div>
                            <% } %>
                        <% } else { %>
                            <div class="no-preview">
                                <p>Aucun document fourni</p>
                            </div>
                        <% } %>
                    </div>
                </div> -->
            </div>
        </div>
        
        <table>
            <tr>
                <!-- <th>Numéro de Réservation</th> -->
                <!-- <th>Numéro de Vol</th> -->
                <!-- <th>Date de Réservation</th> -->
                <!-- <th>Type de Siège</th> -->
                <th>Type de Passager</th>
                <th>Prix</th>
                <!-- <th>Statut</th> -->
                <!-- <th>Client</th> -->
                <th class="action-column">Action</th>


            </tr>
            <% for (Reservation res : all) { %>
            <tr>
                <td><%= res.getPassenger_type() %></td>
                <td><%= res.getPrix_reservation() %> €</td>
                <td class="actions action-column">
                    <a href="/Ticketing/reservation/cancel?id=<%= res.getId() %>">Annuler</a>
                </td>
            </tr>
            <% } %>
        </table>
    </div>
    <div class="action-buttons">
        <a href="/Ticketing/reservation/pdf?id=<%= temoin.getId_booking() %>&pdfApiBaseUrl=<%= pdfApiBaseUrl != null ? pdfApiBaseUrl : "http://localhost:8081" %>" class="btn btn-primary">Télécharger PDF</a>

    </div>
    
</body>
</html>
