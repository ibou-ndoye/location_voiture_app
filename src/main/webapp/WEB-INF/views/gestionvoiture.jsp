<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<div class="container mt-5">
    <!-- Titre + pastille utilisateur -->
<div class="d-flex align-items-center mb-4">
    <!-- Pastille utilisateur -->
    <div class="me-3 rounded-circle bg-primary text-white d-flex align-items-center justify-content-center"
         style="width: 60px; height: 60px; font-size: 0.75rem; text-align: center;">
        <div class="text-center">
            <strong>${utilisateurConnecte.nom}</strong><br />
            <strong>${utilisateurConnecte.prenom}</strong>
        </div>
    </div>

    <!-- Titre -->
    <h1 class="mb-0">Gestion des Voitures</h1>
</div>

    

    <!-- Barre d'actions -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <form class="d-flex" method="get" action="${pageContext.request.contextPath}/gestionvoiture">
            <input type="text" name="query" class="form-control me-2" placeholder="Rechercher...">
            <select name="marque" class="form-select me-2">
                <option value="ALL">Toutes marques</option>
                <c:forEach var="m" items="${marques}">
                    <option value="${m}">${m}</option>
                </c:forEach>
            </select>
            <button type="submit" class="btn btn-primary">Filtrer</button>
        </form>
        <div>
            <a href="${pageContext.request.contextPath}/ajouterVoiture" class="btn btn-success">Ajouter une voiture</a>
            <a href="${pageContext.request.contextPath}/clients" class="btn btn-outline-primary">Inscrire un client</a>
            <a href="${pageContext.request.contextPath}/passerCommande" class="btn btn-outline-warning">Passer une commande</a>
        </div>
    </div>

    <!-- Tableau des voitures -->
    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle">
            <thead class="table-dark text-center">
                <tr>
                   <th style="width: 120px;">Photo</th>
                    <th>Immatriculation</th>
                    <th>Marque</th>
                    <th>Modèle</th>
                    <th>Catégorie</th>
                    <th>Prix/Jour (€)</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="v" items="${voitures}">
                    <tr class="text-center">
                        <td style="width: 120px;">
    <img src="${pageContext.request.contextPath}/voiture/${v.photo}" 
         alt="Photo ${v.modele}" 
         class="img-thumbnail"
         width="100" height="70"
         style="object-fit: cover;"
         onerror="this.src='${pageContext.request.contextPath}/images/default.png';" />
</td>
                        <td>${v.immatriculation}</td>
                        <td>${v.marque}</td>
                        <td>${v.modele}</td>
                        <td>${v.categorie}</td>
                        <td>${v.prixJour} €</td>
                        <td>
                            <a href="modifierVoiture?immatriculation=${v.immatriculation}" class="btn btn-sm btn-warning">Modifier</a>
                            <a href="supprimerVoiture?immatriculation=${v.immatriculation}" 
                               class="btn btn-sm btn-danger" 
                               onclick="return confirm('Supprimer cette voiture ?');">Supprimer</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
