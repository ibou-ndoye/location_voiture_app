<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("pageTitle", "Gestion des Voitures"); %>

<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Google Fonts + Bootstrap Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
    body {
        background: var(--gradient-bg), url('${pageContext.request.contextPath}/voiture/loc-voiture.avif') no-repeat center center fixed;
            background-size: cover;
            background-blend-mode: overlay;
            display: flex;
            align-items: center;
            justify-content: center;
    }

    .main-title {
        text-align: center;
        margin-bottom: 40px;
    }

    .action-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
        gap: 30px;
        justify-items: center;
        align-items: center;
        margin-top: 40px;
    }

    .action-btn {
        background: white;
        border-radius: 1rem;
        padding: 30px;
        text-align: center;
        width: 100%;
        max-width: 300px;
        height: 180px;
        transition: all 0.3s ease;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        cursor: pointer;
        text-decoration: none;
        color: #212529;
        position: relative;
    }

    .action-btn:hover {
        transform: translateY(-8px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.15);
    }

    .action-btn i {
        font-size: 2.5rem;
        color: #6366f1;
        margin-bottom: 15px;
        display: block;
    }

    .action-btn h5 {
        font-weight: 600;
        margin: 0;
    }

    @media (max-width: 768px) {
        .action-btn {
            height: 150px;
            padding: 20px;
        }

        .action-btn i {
            font-size: 2rem;
        }
    }
</style>

<div class="container py-5">

    <div class="main-title">
        <h2 class="fw-bold text-primary">🚗 Bienvenue dans l’espace de gestion</h2>
        <p class="text-muted">Choisissez une action ci-dessous</p>
    </div>

    <div class="action-grid">

        <a href="${pageContext.request.contextPath}/ajouterVoiture" class="action-btn">
            <i class="bi bi-plus-circle-fill"></i>
            <h5>Ajouter une Voiture</h5>
        </a>

        <a href="${pageContext.request.contextPath}/clients" class="action-btn">
            <i class="bi bi-person-plus-fill"></i>
            <h5>Ajouter un Client</h5>
        </a>

        <a href="${pageContext.request.contextPath}/passerCommande" class="action-btn">
            <i class="bi bi-cart-check-fill"></i>
            <h5>Louer une Voiture</h5>
        </a>

        <a href="${pageContext.request.contextPath}/etatParking" class="action-btn">
            <i class="bi bi-bar-chart-line-fill"></i>
            <h5>État du Parking</h5>
        </a>

    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />

<!-- Bootstrap Bundle + JS optionnel -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Effet dynamique JS optionnel -->
<script>
    // Petite animation à l'apparition
    document.addEventListener("DOMContentLoaded", () => {
        document.querySelectorAll(".action-btn").forEach((btn, i) => {
            btn.style.opacity = 0;
            btn.style.transform = "translateY(20px)";
            setTimeout(() => {
                btn.style.transition = "all 0.6s ease";
                btn.style.opacity = 1;
                btn.style.transform = "translateY(0)";
            }, 150 * i);
        });
    });
</script>
