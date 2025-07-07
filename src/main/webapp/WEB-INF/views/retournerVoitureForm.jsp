<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container my-5">
    <h2>Retour de voiture</h2>

    <form action="${pageContext.request.contextPath}/retournerVoiture" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="idLocation" value="${location.idLocation}" />

        <!-- Champ Date Retour -->
        <div class="mb-3">
            <label for="dateRetour" class="form-label">Date de retour réelle</label>

            <c:choose>
                <c:when test="${not empty location.dateFinReelle}">
                    <fmt:formatDate value="${location.dateFinReelle}" pattern="yyyy-MM-dd'T'HH:mm" var="dateRetourFormattee" />
                </c:when>
                <c:otherwise>
                    <c:set var="dateRetourFormattee" value="" />
                </c:otherwise>
            </c:choose>

            <input type="datetime-local" class="form-control" id="dateRetour" name="dateRetour"
                   value="${dateRetourFormattee}" required />
            <div class="invalid-feedback">Veuillez saisir la date et l'heure de retour.</div>
        </div>

        <!-- Champ Kilométrage -->
        <div class="mb-3">
            <label for="kilometrageRetour" class="form-label">Kilométrage au retour</label>
            <input type="number" class="form-control" id="kilometrageRetour" name="kilometrageRetour" min="0"
                   value="${location.kilometrageRetour != null ? location.kilometrageRetour : ''}" required />
            <div class="invalid-feedback">Veuillez saisir le kilométrage au retour.</div>
        </div>

        <button type="submit" class="btn btn-success">Valider le retour</button>
        <a href="${pageContext.request.contextPath}/etatParking" class="btn btn-secondary ms-2">Annuler</a>
    </form>
</div>

<script>
    // Validation Bootstrap côté client
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

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
