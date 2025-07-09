<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 d-none d-md-block bg-dark sidebar text-white vh-100 position-fixed">
            <div class="pt-4 text-center">
                <h4>Menu</h4>
                <ul class="nav flex-column mt-4">
                    <c:if test="${role == 'CHEF'}">
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/gestionnaire/dashboard">TABLEAU DE BORD</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/voitures"> Voitures</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/locations">Locations</a></li>
                    </c:if>
                    <c:if test="${role == 'GESTIONNAIRE'}">
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/clients">Liste des Clients</a></li>
                    </c:if>
                </ul>
                <hr class="text-white" />
                <div class="text-center small">
                    <p class="mb-1">Connecté en tant que :</p>
                    <strong>${utilisateurConnecte.nom} ${utilisateurConnecte.prenom}</strong>
                </div>
            </div>
        </nav>
<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>
    .car-card {
        transition: transform 0.2s;
    }
    .car-card:hover {
        transform: scale(1.02);
    }
</style>

<div class="container py-5">
    <h2 class="text-center mb-5 text-primary">🚘 Parc Automobile</h2>

    <!-- Formulaire de recherche -->
    <form class="row g-3 mb-4 shadow-sm p-3 rounded bg-light" method="get" action="voitures">
        <div class="col-md-2">
            <input type="text" class="form-control" name="marque" value="${marque}" placeholder="Marque">
        </div>
        <div class="col-md-2">
            <input type="number" class="form-control" name="kilometrageMax" value="${kilometrageMax}" placeholder="Km max">
        </div>
        <div class="col-md-2">
            <input type="number" class="form-control" name="annee" value="${annee}" placeholder="Année">
        </div>
        <div class="col-md-2">
            <select class="form-select" name="carburant">
                <option value="">Carburant</option>
                <option ${carburant == 'Essence' ? 'selected' : ''}>Essence</option>
                <option ${carburant == 'Diesel' ? 'selected' : ''}>Diesel</option>
                <option ${carburant == 'Hybride' ? 'selected' : ''}>Hybride</option>
                <option ${carburant == 'Electrique' ? 'selected' : ''}>Electrique</option>
            </select>
        </div>
        <div class="col-md-2">
            <select class="form-select" name="categorie">
                <option value="">Catégorie</option>
                <option ${categorie == 'Economique' ? 'selected' : ''}>Economique</option>
                <option ${categorie == 'Confort' ? 'selected' : ''}>Confort</option>
                <option ${categorie == 'Luxe' ? 'selected' : ''}>Luxe</option>
                <option ${categorie == 'SUV' ? 'selected' : ''}>SUV</option>
                <option ${categorie == 'Utilitaire' ? 'selected' : ''}>Utilitaire</option>
            </select>
        </div>
        <div class="col-md-2 d-grid">
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-search"></i> Rechercher
            </button>
        </div>
    </form>

    <!-- Affichage des voitures -->
    <div class="row g-4">
        <c:forEach var="v" items="${voitures}">
            <div class="col-md-6 col-lg-4">
                <div class="card car-card shadow-sm border-0 h-100">
                    <img src="${pageContext.request.contextPath}/voiture/${v.photo}"
                         class="card-img-top img-fluid"
                         alt="${v.modele}"
                         style="height: 200px; object-fit: cover;"
                         onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default.png';">

                    <div class="card-body">
                        <h5 class="card-title text-primary">${v.marque} ${v.modele}</h5>
                        <p class="text-muted small">Immatriculation : ${v.immatriculation}</p>

                        <ul class="list-group list-group-flush small mb-3">
                            <li class="list-group-item"><strong>Places :</strong> ${v.nbPlaces}</li>
                            <li class="list-group-item"><strong>Mise en circulation :</strong> ${v.dateMiseCirculation}</li>
                            <li class="list-group-item"><strong>Catégorie :</strong> ${v.categorie}</li>
                            <li class="list-group-item"><strong>Carburant :</strong> ${v.carburant}</li>
                            <li class="list-group-item"><strong>Kilométrage :</strong> ${v.kilometrage} km</li>
                            <li class="list-group-item"><strong>Prix par jour :</strong> 
                                <span class="text-success fw-semibold">${v.prixJour} €</span>
                            </li>
                            <li class="list-group-item">
                                <strong>Disponible :</strong>
                                <c:choose>
                                    <c:when test="${v.disponible}">
                                        <span class="text-success">Oui</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger">Non</span>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>

                       
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
