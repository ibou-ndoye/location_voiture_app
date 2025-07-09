<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>

<div class="container py-5">
    <!-- En-tête -->
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-4">
        <h2 class="text-primary fw-bold mb-0">
            <i class="bi bi-person-lines-fill"></i> Ajouter / Modifier un client
        </h2>
    </div>

    <!-- Affichage messages d'erreur ou succès -->
    <c:if test="${not empty messageErreur}">
        <div class="alert alert-danger" role="alert">
            ${messageErreur}
        </div>
    </c:if>
    <c:if test="${not empty messageSuccess}">
        <div class="alert alert-success" role="alert">
            ${messageSuccess}
        </div>
    </c:if>

    <!-- Formulaire client -->
    <div class="bg-white p-4 rounded shadow-sm border border-2 border-light">
        <form action="${pageContext.request.contextPath}/clients" method="post" class="row g-3 needs-validation" novalidate>
<input type="hidden" name="idClient" value="${client.idClient != null ? client.idClient : ''}" />

            <h5 class="text-secondary mt-2 mb-1">Informations personnelles</h5>
            <div class="col-md-4">
                <label class="form-label" for="cin">CIN</label>
                <input type="text" id="cin" name="cin" class="form-control" placeholder="Entrez le CIN" value="${client.cin}" required />
                <div class="invalid-feedback">Veuillez entrer le CIN.</div>
            </div>
            <div class="col-md-4">
                <label class="form-label" for="prenom">Prénom</label>
                <input type="text" id="prenom" name="prenom" class="form-control" placeholder="Entrez le prénom" value="${client.prenom}" required />
                <div class="invalid-feedback">Veuillez entrer le prénom.</div>
            </div>
            <div class="col-md-4">
                <label class="form-label" for="nom">Nom</label>
                <input type="text" id="nom" name="nom" class="form-control" placeholder="Entrez le nom" value="${client.nom}" required />
                <div class="invalid-feedback">Veuillez entrer le nom.</div>
            </div>
            <div class="col-md-4">
                <label class="form-label" for="sexe">Sexe</label>
                <select id="sexe" name="sexe" class="form-select" required>
                    <option value="" disabled ${client.sexe == null ? 'selected' : ''}>-- Sélectionner --</option>
                    <option value="M" ${client.sexe == 'M' ? 'selected' : ''}>Masculin</option>
                    <option value="F" ${client.sexe == 'F' ? 'selected' : ''}>Féminin</option>
                </select>
                <div class="invalid-feedback">Veuillez sélectionner le sexe.</div>
            </div>

            <h5 class="text-secondary mt-4 mb-1">Coordonnées</h5>
            <div class="col-md-8">
                <label class="form-label" for="adresse">Adresse</label>
                <input type="text" id="adresse" name="adresse" class="form-control" placeholder="Entrez l'adresse" value="${client.adresse}" required />
                <div class="invalid-feedback">Veuillez entrer l'adresse.</div>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="email">Email</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="exemple@email.com" value="${client.email}" required />
                <div class="invalid-feedback">Veuillez entrer un email valide.</div>
            </div>
            <div class="col-md-6">
                <label class="form-label" for="telephone">Téléphone</label>
                <input type="text" id="telephone" name="telephone" class="form-control" placeholder="Entrez le numéro" value="${client.telephone}" required />
                <div class="invalid-feedback">Veuillez entrer un numéro de téléphone.</div>
            </div>

            <div class="col-12 d-flex justify-content-end">
                                <a href="${pageContext.request.contextPath}/gestionvoiture" class="btn btn-outline-secondary me-2">Annuler</a>
            
                <button type="submit" class="btn btn-success px-4">
                    <i class="bi bi-save-fill"></i> Enregistrer
                </button>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />

<!-- Validation Bootstrap 5 simple -->
<script>
    (() => {
      'use strict'
      const forms = document.querySelectorAll('.needs-validation')
      Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
          if (!form.checkValidity()) {
            event.preventDefault()
            event.stopPropagation()
          }
          form.classList.add('was-validated')
        }, false)
      })
    })()
</script>

<style>
    input:focus, select:focus, textarea:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }
</style>
