<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container my-5">
    <h2>Retour de voiture</h2>
    <form action="${pageContext.request.contextPath}/retournerVoiture" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="idLocation" value="${location.idLocation}" />

        <div class="mb-3"><%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container my-5">
    <h2>Retour de voiture</h2>
    <form action="${pageContext.request.contextPath}/retournerVoiture" method="post" class="needs-validation" novalidate>
        <input type="hidden" name="idLocation" value="${location.idLocation}" />

        <div class="mb-3">
            <label for="dateRetour" class="form-label">Date de retour réelle</label>
            <input type="datetime-local" class="form-control" id="dateRetour" name="dateRetour"
                   value="${location.dateFinReelleForInput}"
                   required />
            <div class="invalid-feedback">Veuillez saisir la date et l'heure de retour.</div>
        </div>

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
    // Bootstrap validation example
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
        
            <label for="dateRetour" class="form-label">Date de retour réelle</label>
            <input type="datetime-local" class="form-control" id="dateRetour" name="dateRetour"
                   value="<c:out value='${fn:substring(location.dateFinReelleFormatee, 6, 10)}-${fn:substring(location.dateFinReelleFormatee, 3, 5)}-${fn:substring(location.dateFinReelleFormatee, 0, 2)}T${fn:substring(location.dateFinReelleFormatee, 11, 16)}'/>"
                   required />
            <div class="invalid-feedback">Veuillez saisir la date et l'heure de retour.</div>
        </div>

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
    // Bootstrap validation example (optionnel)
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
