<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>

<style>
    .label-cell {
        width: 200px;
        background-color: #f8f9fa;
        font-weight: 600;
    }
    .details-section {
        border-left: 5px solid #0d6efd;
        background-color: #ffffff;
        padding: 2rem;
        border-radius: .5rem;
        box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    }
</style>

<div class="container-fluid bg-light min-vh-100 py-5 px-4">
    <div class="details-section mx-auto" style="max-width: 1200px;">
        <h2 class="mb-4 text-primary fw-bold border-bottom pb-2">📄 Détails du client</h2>

        <div class="row">
            <div class="col-lg-6 col-md-8">
                <table class="table table-bordered table-hover table-sm mb-4">
                    <tr><td class="label-cell">ID</td><td>${client.idClient}</td></tr>
                    <tr><td class="label-cell">CIN</td><td>${client.cin}</td></tr>
                    <tr><td class="label-cell">Nom</td><td>${client.nom}</td></tr>
                    <tr><td class="label-cell">Prénom</td><td>${client.prenom}</td></tr>
                    <tr><td class="label-cell">Sexe</td><td>${client.sexe}</td></tr>
                    <tr><td class="label-cell">Email</td><td>${client.email}</td></tr>
                    <tr><td class="label-cell">Téléphone</td><td>${client.telephone}</td></tr>
                    <tr><td class="label-cell">Adresse</td><td>${client.adresse}</td></tr>
                </table>
            </div>
        </div>

        <h4 class="text-info mt-5">🚗 Locations associées</h4>
        <c:choose>
            <c:when test="${empty locations}">
                <div class="alert alert-warning mt-3">Aucune location enregistrée pour ce client.</div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive mt-3">
                    <table class="table table-striped table-hover table-bordered align-middle">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>ID</th>
                                <th>Voiture</th>
                                <th>Date début</th>
                                <th>Date fin prévue</th>
                                <th>Montant total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="loc" items="${locations}">
                                <tr class="text-center">
                                    <td>${loc.idLocation}</td>
                                    <td>${loc.voiture.marque} ${loc.voiture.modele}</td>
                                    <td>${loc.dateDebut}</td>
                                    <td>${loc.dateFinPrevue}</td>
                                    <td>${loc.prixTotal} FCFA</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="mt-4 d-flex justify-content-start">
            <a href="${pageContext.request.contextPath}/clientel" class="btn btn-secondary">
                ⬅ Retour à la liste des clients
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp"/>
