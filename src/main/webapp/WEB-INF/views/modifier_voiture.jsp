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
            <label class="form-label">Catégorie</label>
            <input type="text" class="form-control" name="categorie" value="${voiture.categorie}" required />
        </div>

        <div class="mb-3">
            <label class="form-label">Prix par jour (€)</label>
            <input type="number" class="form-control" name="prixJour" value="${voiture.prixJour}" required />
        </div>

        <button type="submit" class="btn btn-primary">Enregistrer</button>
        <a href="${pageContext.request.contextPath}/gestionvoiture" class="btn btn-secondary">Annuler</a>
    </form>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
