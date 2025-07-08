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
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/voitures"> Voitures</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/locations">Locations</a></li>
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/clients">Clients</a></li>
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
<div class="container mt-5">
    <h2 class="mb-4 text-center">📄 Liste des Locations</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Client</th>
                    <th>Voiture</th>
                    <th>Gestionnaire</th>
                    <th>Date Début</th>
                    <th>Date Fin Prévue</th>
                    <th>Date Fin Réelle</th>
                    <th>Prix Total (€)</th>
                    <th>Kilométrage Départ</th>
                    <th>Kilométrage Retour</th>
                    <th>Signe Client</th>
                    <th>Signe Gestionnaire</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="l" items="${locations}">
                    <tr>
                        <td>${l.idLocation}</td>
                        <td>${l.client.nom} ${l.client.prenom}</td>
                        <td>${l.voiture.marque} ${l.voiture.modele}</td>
                        <td>${l.gestionnaire.nom} ${l.gestionnaire.prenom}</td>
                        <td>${l.dateDebut}</td>
                        <td>${l.dateFinPrevue}</td>
                        <td>
                            <c:choose>
                                <c:when test="${l.dateFinReelle != null}">
                                    ${l.dateFinReelle}
                                </c:when>
                                <c:otherwise><span class="text-muted">Pas encore</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>${l.prixTotal}</td>
                        <td>${l.kilometrageDepart}</td>
                        <td>
                            <c:choose>
                                <c:when test="${l.kilometrageRetour != null}">
                                    ${l.kilometrageRetour}
                                </c:when>
                                <c:otherwise><span class="text-muted">Pas encore</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="badge bg-${l.signeClient ? 'success' : 'secondary'}">
                                ${l.signeClient ? 'Oui' : 'Non'}
                            </span>
                        </td>
                        <td>
                            <span class="badge bg-${l.signeGestionnaire ? 'success' : 'secondary'}">
                                ${l.signeGestionnaire ? 'Oui' : 'Non'}
                            </span>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
