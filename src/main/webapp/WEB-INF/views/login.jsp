<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setAttribute("pageTitle", "Connexion"); %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    body {
        background: url('${pageContext.request.contextPath}/voiture/pixel.jpg') no-repeat center center fixed;
        background-size: cover;
    }
    .overlay {
        background-color: rgba(255, 255, 255, 0.95); /* opacité blanche pour lisibilité */
        border-radius: 1.5rem;
    }
</style>

<div class="container vh-100 d-flex align-items-center justify-content-center">
    <div class="row justify-content-center w-100">
        <div class="col-md-6 col-lg-5">
            <div class="card shadow-lg border-0 overlay">
                <div class="card-header bg-primary text-white text-center rounded-top-4">
                    <h3 class="mb-0">🔐 Connexion à l’espace gestion</h3>
                </div>
                <div class="card-body px-4 py-5">

                    <!-- Message d'erreur -->
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger text-center mb-4">
                            ${error}
                        </div>
                    </c:if>

                    <!-- Formulaire -->
                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <div class="form-floating mb-4">
                            <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                            <label for="email">Adresse Email</label>
                        </div>
                        <div class="form-floating mb-4">
                            <input type="password" class="form-control" id="password" name="password" placeholder="Mot de passe" required>
                            <label for="password">Mot de passe</label>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">Se connecter</button>
                        </div>
                    </form>

                    <div class="text-center mt-4">
                        <small class="text-muted">© ${pageContext.request.serverName} - Système de gestion</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
