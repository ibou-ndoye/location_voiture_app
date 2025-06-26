<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil - Agence de Location</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(120deg, #007bff, #00c6ff);
            color: #fff;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
        }
        .card {
            background: #ffffff;
            color: #333;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }
        .btn-access {
            font-weight: bold;
            padding: 10px 30px;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="card p-5">
        <h1 class="mb-3"><i class="bi bi-car-front-fill text-primary"></i> VoitureApp</h1>
        <p class="mb-4 fs-5">Bienvenue dans notre système de gestion d'agence de location de voitures.</p>

        <div class="mb-4">
            <input type="password" id="accessCode" class="form-control form-control-lg text-center" placeholder="Entrez le code d’accès..." />
        </div>

        <button class="btn btn-primary btn-access" onclick="checkCode()">
            🔐 Accéder à l'application
        </button>

        <div id="errorMsg" class="text-danger mt-3 fw-semibold" style="display: none;">⛔ Code incorrect !</div>
    </div>
</div>

<script>
    function checkCode() {
        const code = document.getElementById('accessCode').value.trim();
        const error = document.getElementById('errorMsg');

        if (code === 'voiture05') {
            window.location.href = 'LoginServlet';
        } else {
            error.style.display = 'block';
        }
    }
</script>

</body>
</html>
