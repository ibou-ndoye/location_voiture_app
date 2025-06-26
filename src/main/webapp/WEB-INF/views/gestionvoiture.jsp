<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- CONTENU PRINCIPAL -->
<div class="container-fluid px-4 py-4">
    <!-- En-tête -->
    <div class="d-flex flex-wrap align-items-center justify-content-between mb-4">
        <div class="d-flex align-items-center gap-3">
            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center shadow"
                 style="width: 70px; height: 70px;">
                <div class="text-center small fw-semibold">
                    ${utilisateurConnecte.nom}<br />${utilisateurConnecte.prenom}
                </div>
            </div>
            <h2 class="fw-bold mb-0">Gestion des Voitures</h2>
        </div>
        <div class="btn-group mt-3 mt-md-0" role="group" aria-label="Actions principales">
            <a href="${pageContext.request.contextPath}/ajouterVoiture" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Ajouter
            </a>
            <a href="${pageContext.request.contextPath}/clients" class="btn btn-outline-primary">
                <i class="bi bi-person-plus"></i> Nouveau Client
            </a>
            <a href="${pageContext.request.contextPath}/passerCommande" class="btn btn-outline-warning">
                <i class="bi bi-cart-check"></i> Commander
            </a>
        </div>
    </div>

    <!-- Barre de recherche et filtre -->
    <div class="card shadow-sm p-3 mb-4">
        <form class="row g-2 align-items-center" method="get" action="${pageContext.request.contextPath}/gestionvoiture">
            <div class="col-md-5">
                <input type="text" name="query" class="form-control" placeholder="Rechercher une voiture...">
            </div>
            <div class="col-md-4">
                <select name="marque" class="form-select">
                    <option value="ALL">Toutes les marques</option>
                    <c:forEach var="m" items="${marques}">
                        <option value="${m}">${m}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-3 text-end">
                <button type="submit" class="btn btn-primary w-100">
                    <i class="bi bi-search"></i> Filtrer
                </button>
            </div>
        </form>
    </div>

    <!-- Tableau des voitures -->
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white fw-semibold">
            Liste des voitures disponibles
        </div>
        <div class="table-responsive">
            <table class="table table-hover table-bordered align-middle text-center mb-0">
                <thead class="table-secondary">
                    <tr>
                        <th style="width: 130px;">Photo</th>
                        <th>Immatriculation</th>
                        <th>Marque</th>
                        <th>Modèle</th>
                        <th>Catégorie</th>
                        <th>Prix/Jour (€)</th>
                        <th style="width: 140px;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${voitures}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/voiture/${v.photo}" 
                                     alt="Photo ${v.modele}" 
                                     class="img-thumbnail rounded"
                                     style="width: 110px; height: 70px; object-fit: cover;"
                                     onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default.png';" />
                            </td>
                            <td>${v.immatriculation}</td>
                            <td>${v.marque}</td>
                            <td>${v.modele}</td>
                            <td>${v.categorie}</td>
                            <td class="fw-semibold text-success">${v.prixJour} €</td>
                            <td>
                                <a href="modifierVoiture?immatriculation=${v.immatriculation}" class="btn btn-sm btn-warning me-1" title="Modifier">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="supprimerVoiture?immatriculation=${v.immatriculation}" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Supprimer cette voiture ?');"
                                   title="Supprimer">
                                    <i class="bi bi-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
