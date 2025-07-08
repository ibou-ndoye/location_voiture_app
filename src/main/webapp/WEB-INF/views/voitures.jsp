<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<div class="container py-5">
    <h2 class="text-center mb-5">🚘 Parc Automobile - Détails</h2>

    <!-- Formulaire de recherche -->
    <form class="row g-3 mb-4" method="get" action="voitures">
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
            <div class="col-md-6">
                <div class="card shadow border-0">
                    <div class="row g-0">
                        <!-- Image -->
                        <div class="col-md-5">
                            <img src="${pageContext.request.contextPath}/voiture/${v.photo}"
                                 class="img-fluid rounded-start h-100 object-fit-cover"
                                 style="object-fit: cover; height: 100%;"
                                 alt="${v.modele}"
                                 onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default.png';">
                        </div>

                        <!-- Détails -->
                        <div class="col-md-7">
                            <div class="card-body">
                                <h5 class="card-title mb-2">${v.marque} ${v.modele}</h5>
                                <p class="text-muted small mb-2">Immatriculation: ${v.immatriculation}</p>

                                <!-- Bouton déroulant -->
                                <button class="btn btn-outline-primary btn-sm w-100 mb-2" type="button"
                                        data-bs-toggle="collapse" data-bs-target="#collapse-${v.immatriculation}">
                                    <i class="bi bi-info-circle"></i> Voir détails
                                </button>

                                <!-- Détails supplémentaires -->
                                <div class="collapse" id="collapse-${v.immatriculation}">
                                    <ul class="list-group list-group-flush small">
                                        <li class="list-group-item"><strong>Nombre de places :</strong> ${v.nbPlaces}</li>
                                        <li class="list-group-item"><strong>Date mise en circulation :</strong> ${v.dateMiseCirculation}</li>
                                        <li class="list-group-item"><strong>Catégorie :</strong> ${v.categorie}</li>
                                        <li class="list-group-item"><strong>Carburant :</strong> ${v.carburant}</li>
                                        <li class="list-group-item"><strong>Kilométrage :</strong> ${v.kilometrage} km</li>
                                        <li class="list-group-item"><strong>Prix par jour :</strong>
                                            <span class="text-success fw-semibold">${v.prixJour} €</span>
                                        </li>
                                        <li class="list-group-item"><strong>Disponible :</strong>
                                            <c:choose>
                                                <c:when test="${v.disponible}">Oui</c:when>
                                                <c:otherwise>Non</c:otherwise>
                                            </c:choose>
                                        </li>
                                    </ul>

                                    <!-- Actions -->
                                    <div class="d-flex justify-content-end mt-3 gap-2">
                                        <a href="modifierVoiture?immatriculation=${v.immatriculation}"
                                           class="btn btn-sm btn-warning">
                                            <i class="bi bi-pencil-square"></i> Modifier
                                        </a>

                                        <!-- Bouton Supprimer affiché uniquement si voiture DISPONIBLE -->
                                        <c:if test="${v.disponible}">
                                            <a href="supprimerVoiture?immatriculation=${v.immatriculation}"
                                               class="btn btn-sm btn-danger"
                                               onclick="return confirm('Supprimer cette voiture ?');">
                                                <i class="bi bi-trash"></i> Supprimer
                                            </a>
                                        </c:if>
                                    </div>
                                </div> <!-- /collapse -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
