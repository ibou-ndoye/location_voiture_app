<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<div class="container my-5">
    <h2 class="mb-4 fw-bold text-center"><i class="bi bi-bar-chart"></i> État du Parking</h2>

    <!-- Résumé -->
    <div class="row text-center mb-4">
        <div class="col-md-4">
            <div class="card shadow-sm border-start border-primary border-4">
                <div class="card-body">
                    <h5 class="card-title text-muted">Nombre total de voitures</h5>
                    <h2 class="fw-bold text-primary">${nombreTotal}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm border-start border-warning border-4">
                <div class="card-body">
                    <h5 class="card-title text-muted">Voitures en location</h5>
                    <h2 class="fw-bold text-warning">${voituresEnLocation.size()}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm border-start border-success border-4">
                <div class="card-body">
                    <h5 class="card-title text-muted">Voitures disponibles</h5>
                    <h2 class="fw-bold text-success">${voituresDisponibles.size()}</h2>
                </div>
            </div>
        </div>
    </div>

    <!-- Liste des voitures en location -->
    <div class="card shadow-sm mb-5">
        <div class="card-header bg-warning text-white fw-semibold">
            <i class="bi bi-clock-history"></i> Voitures en location
        </div>
        <div class="table-responsive">
            <table class="table table-striped align-middle text-center">
                <caption class="visually-hidden">Liste des voitures en cours de location</caption>
                <thead class="table-warning">
                    <tr>
                        <th>Immatriculation</th>
                        <th>Marque</th>
                        <th>Modèle</th>
                        <th>Client</th>
                        <th>Téléphone</th>
                        <th>Date début location</th>
                        <th>Date fin prévue</th>
                        <th>Date fin réelle</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${voituresEnLocation}">
                        <tr>
                            <td>${v.voiture.immatriculation}</td>
                            <td>${v.voiture.marque}</td>
                            <td>${v.voiture.modele}</td>
                            <td>${v.client.nom} ${v.client.prenom}</td>
                            <td>${v.client.telephone}</td>
                            <td>${v.dateDebutFormatee}</td>
                            <td>${v.dateFinPrevueFormatee}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty v.dateFinReelleFormatee}">
                                        ${v.dateFinReelleFormatee}
                                    </c:when>
                                    <c:otherwise>
                                        En cours
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${empty v.dateFinReelleFormatee}">
                                    <form action="${pageContext.request.contextPath}/retournerVoiture" method="get">
                                        <input type="hidden" name="idLocation" value="${v.idLocation}" />
                                        <button type="submit" class="btn btn-sm btn-primary">Retourner voiture</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty voituresEnLocation}">
                        <tr>
                            <td colspan="9" class="text-muted">Aucune voiture en location</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Liste des voitures disponibles -->
    <div class="card shadow-sm">
        <div class="card-header bg-success text-white fw-semibold">
            <i class="bi bi-car-front-fill"></i> Voitures disponibles
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle text-center">
                <caption class="visually-hidden">Liste des voitures disponibles</caption>
                <thead class="table-success">
                    <tr>
                        <th>Immatriculation</th>
                        <th>Marque</th>
                        <th>Modèle</th>
                        <th>Kilométrage</th>
                        <th>Catégorie</th>
                        <th>Prix / Jour (€)</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="v" items="${voituresDisponibles}">
                        <tr>
                            <td>${v.immatriculation}</td>
                            <td>${v.marque}</td>
                            <td>${v.modele}</td>
                            <td>${v.kilometrage} km</td>
                            <td>${v.categorie}</td>
                            <td class="fw-bold text-success">${v.prixJour}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty voituresDisponibles}">
                        <tr>
                            <td colspan="6" class="text-muted">Aucune voiture disponible</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
