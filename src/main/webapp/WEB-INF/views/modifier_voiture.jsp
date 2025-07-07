<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container mt-4">
    <h2 class="mb-4">Modifier une voiture</h2>

    <form action="${pageContext.request.contextPath}/updateVoiture" method="post">
        <input type="hidden" name="immatriculation" value="${voiture.immatriculation}" />

        <div class="mb-3">
            <label class="form-label">Marque</label>
            <input type="text" class="form-control" name="marque" value="${voiture.marque}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Modèle</label>
            <input type="text" class="form-control" name="modele" value="${voiture.modele}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Nombre de places</label>
            <input type="number" class="form-control" name="nbPlaces" value="${voiture.nbPlaces}" required min="1" />
        </div>

        <div class="mb-3">
            <label class="form-label">Date mise en circulation</label>
            <input type="date" class="form-control" name="dateMiseCirculation" value="${voiture.dateMiseCirculation}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Kilométrage</label>
            <input type="number" class="form-control" name="kilometrage" value="${voiture.kilometrage}" required min="0" />
        </div>

        <div class="mb-3">
            <label class="form-label">Carburant</label>
            <select class="form-select" name="carburant" required>
                <option value="Essence" <c:if test="${voiture.carburant == 'Essence'}">selected</c:if>>Essence</option>
                <option value="Diesel" <c:if test="${voiture.carburant == 'Diesel'}">selected</c:if>>Diesel</option>
                <option value="Hybride" <c:if test="${voiture.carburant == 'Hybride'}">selected</c:if>>Hybride</option>
                <option value="Electrique" <c:if test="${voiture.carburant == 'Electrique'}">selected</c:if>>Electrique</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Catégorie</label>
            <select class="form-select" name="categorie" required>
                <option value="Economique" <c:if test="${voiture.categorie == 'Economique'}">selected</c:if>>Economique</option>
                <option value="Confort" <c:if test="${voiture.categorie == 'Confort'}">selected</c:if>>Confort</option>
                <option value="Luxe" <c:if test="${voiture.categorie == 'Luxe'}">selected</c:if>>Luxe</option>
                <option value="SUV" <c:if test="${voiture.categorie == 'SUV'}">selected</c:if>>SUV</option>
                <option value="Utilitaire" <c:if test="${voiture.categorie == 'Utilitaire'}">selected</c:if>>Utilitaire</option>
            </select>
        </div>

        <div class="mb-3">
            <label class="form-label">Prix par jour (€)</label>
            <input type="number" step="0.01" class="form-control" name="prixJour" value="${voiture.prixJour}" required min="0" />
        </div>

        <div class="form-check mb-3">
            <input type="checkbox" class="form-check-input" id="disponible" name="disponible"
                <c:if test="${voiture.disponible}">checked</c:if> />
            <label class="form-check-label" for="disponible">Disponible</label>
        </div>

        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="${pageContext.request.contextPath}/voitures" class="btn btn-secondary">Annuler</a>
    </form>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
