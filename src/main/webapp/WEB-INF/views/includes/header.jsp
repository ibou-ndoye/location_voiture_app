<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle != null ? pageTitle : "Tableau de bord"}</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        :root {
            --gradient-bg: linear-gradient(135deg, #c3dafe, #a5b4fc, #818cf8, #6366f1);
        }

        * {
            font-family: 'Poppins', sans-serif;
        }

        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            background: var(--gradient-bg);
            color: #212529;
            display: flex;
            flex-direction: column;
        }

        .navbar {
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .navbar-brand {
            font-weight: bold;
            letter-spacing: 0.5px;
        }

        .sidebar {
            width: 220px;
            height: 100vh;
            background-color: #212529;
            position: fixed;
            top: 56px;
            left: 0;
            padding-top: 20px;
            z-index: 1000;
        }

        .sidebar a {
            color: #adb5bd;
            display: block;
            padding: 12px 20px;
            text-decoration: none;
            transition: background 0.3s ease;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: #343a40;
            color: #fff;
        }

        .content {
            margin-left: 220px;
            padding: 30px;
            margin-top: 56px;
        }

        /* Mode sombre */
        body.dark-mode {
            background: #1e1e2f;
            color: #e4e6eb;
        }

        body.dark-mode .sidebar {
            background-color: #111;
        }

        body.dark-mode .sidebar a {
            color: #ccc;
        }

        body.dark-mode .sidebar a:hover {
            background-color: #333;
            color: white;
        }

        body.dark-mode .navbar {
            background-color: #000 !important;
        }

        body.dark-mode .content {
            background-color: #1e1e2f;
        }

        .navbar .btn {
            margin-left: 10px;
        }

        @media (max-width: 768px) {
            .sidebar {
                display: none;
            }

            .content {
                margin-left: 0;
                padding: 20px;
            }
        }
    </style>
</head>

<body style="background: url('${pageContext.request.contextPath}/voiture/loc-voiture.avif') no-repeat center center fixed; background-size: cover;">


<c:if test="${not empty sessionScope.utilisateurConnecte}">
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container-fluid">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">🚗 Agence Auto</a>

            <div class="d-flex gap-2 align-items-center">
                <!-- Bouton Mode Sombre -->
                <button class="btn btn-outline-light btn-sm" onclick="toggleDarkMode()" title="Mode sombre">
                    <i class="bi bi-moon-stars-fill"></i>
                </button>

                <!-- Bouton Déconnexion avec confirmation -->
                <button class="btn btn-outline-danger btn-sm" onclick="confirmLogout()" title="Se déconnecter">
                    <i class="bi bi-box-arrow-right"></i>
                </button>
            </div>
        </div>
    </nav>

    <!-- Barre latérale -->
    <div class="sidebar">
        <a href="${pageContext.request.contextPath}/gestionvoiture" class="active"><i class="bi bi-speedometer2 me-2"></i> Tableau de bord</a>
        <a href="${pageContext.request.contextPath}/voitures"><i class="bi bi-car-front-fill me-2"></i> Voitures</a>
        <a href="${pageContext.request.contextPath}/clientel"><i class="bi bi-people-fill me-2"></i> Clients</a>
        <a href="${pageContext.request.contextPath}/passerCommande"><i class="bi bi-calendar-check-fill me-2"></i> Locations</a>
        <a href="${pageContext.request.contextPath}/etatParking"><i class="bi bi-bar-chart-fill me-2"></i> Parking</a>
    </div>

    <!-- Contenu principal -->
    <div class="content">
</c:if>
