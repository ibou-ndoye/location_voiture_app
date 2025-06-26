<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- CONTENU PRINCIPAL --

    <!-- En-tête -->
    <div class="d-flex flex-wrap align-items-center justify-content-between mb-4 gap-3">
        <div class="d-flex align-items-center gap-3">
            <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center shadow" style="width: 70px; height: 70px;">
                <div class="text-center small fw-semibold">
                    ${utilisateurConnecte.nom}<br />${utilisateurConnecte.prenom}
                </div>
            </div>
            <h2 class="fw-bold mb-0">🚗 Gestion des Voitures</h2>
        </div>

        <div class="btn-group mt-3 mt-md-0 flex-wrap" role="group" aria-label="Actions principales">
            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-dark">
                <i class="bi bi-house-door-fill"></i> Accueil
            </a>
            <a href="${pageContext.request.contextPath}/ajouterVoiture" class="btn btn-success">
                <i class="bi bi-plus-circle"></i> Ajouter voiture
            </a>
            <a href="${pageContext.request.contextPath}/clients" class="btn btn-outline-primary">
                <i class="bi bi-people"></i> Liste Clients
            </a>
            <a href="${pageContext.request.contextPath}/passerCommande" class="btn btn-outline-warning">
                <i class="bi bi-cart-check"></i> Louer voiture
            </a>
            <a href="${pageContext.request.contextPath}/retourVoiture" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-repeat"></i> Retour voiture
            </a>
            <a href="${pageContext.request.contextPath}/etatParking" class="btn btn-dark">
                <i class="bi bi-bar-chart"></i> État Parking
            </a>
        </div>
    </div>

    <!-- Barre de recherche et filtre -->
    <div class="card shadow-sm p-3 mb-4">
        <form class="row g-2 align-items-end" method="get" action="${pageContext.request.contextPath}/gestionvoiture">
            <div class="col-md-3">
                <input type="text" name="marque" class="form-control" placeholder="Marque">
            </div>
            <div class="col-md-3">
                <input type="number" name="kilometrageMax" class="form-control" placeholder="Kilométrage max">
            </div>
            <div class="col-md-2">
                <input type="number" name="annee" class="form-control" placeholder="Année mise en circulation">
            </div>
            <div class="col-md-2">
                <select name="carburant" class="form-select">
                    <option value="ALL">Carburant</option>
                    <option value="ESSENCE">Essence</option>
                    <option value="DIESEL">Diesel</option>
                    <option value="ELECTRIQUE">Électrique</option>
                    <option value="HYBRIDE">Hybride</option>
                </select>
            </div>
            <div class="col-md-2">
                <select name="categorie" class="form-select">
                    <option value="ALL">Catégorie</option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="${cat}">${cat}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-12 text-end">
                <button type="submit" class="btn btn-primary">
                    <i class="bi bi-search"></i> Rechercher
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
                        <th>Photo</th>
                        <th>Immatriculation</th>
                        <th>Marque</th>
                        <th>Modèle</th>
                        <th>Catégorie</th>
                        <th>Carburant</th>
                        <th>Kilométrage</th>
                        <th>Prix/Jour (€)</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${voitures}">
                        <tr>
                            <td>
                                <img src="${pageContext.request.contextPath}/voiture/${v.photo}" alt="Photo ${v.modele}" class="img-thumbnail rounded" style="width: 110px; height: 70px; object-fit: cover;" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default.png';" />
                            </td>
                            <td>${v.immatriculation}</td>
                            <td>${v.marque}</td>
                            <td>${v.modele}</td>
                            <td>${v.categorie}</td>
                            <td>${v.carburant}</td>
                            <td>${v.kilometrage} km</td>
                            <td class="fw-semibold text-success">${v.prixJour} €</td>
                            <td>
                                <a href="modifierVoiture?immatriculation=${v.immatriculation}" class="btn btn-sm btn-warning me-1" title="Modifier">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <a href="supprimerVoiture?immatriculation=${v.immatriculation}" class="btn btn-sm btn-danger" onclick="return confirm('Supprimer cette voiture ?');" title="Supprimer">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
