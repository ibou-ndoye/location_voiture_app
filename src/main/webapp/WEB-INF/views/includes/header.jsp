<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle != null ? pageTitle : "Tableau de bord"}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
    html, body {
        height: 100%;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    .container {
        flex: 1;
    }
     .sidebar {
        min-height: 150vh; /* assure la hauteur complète */
        position:flex;
        top: 0;
        left: 0;
        padding-top: 60px; /* ajuste si tu as un header */
        width: 220px;
        background-color: #343a40;
    }
</style>
    
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Agence Auto</a>
    </div>
</nav>
