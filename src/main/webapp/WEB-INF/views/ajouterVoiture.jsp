<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter une voiture</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/gestionvoiture">VoitureApp</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/gestionvoiture">Voitures</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/inscriptionClient">Clients</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/passerCommande">Commandes</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h3>Ajouter une nouvelle voiture</h3>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/ajouterVoiture" method="post" enctype="multipart/form-data">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="immatriculation" class="form-label">Immatriculation</label>
                        <input type="text" class="form-control" id="immatriculation" name="immatriculation" required>
                    </div>
                    <div class="col-md-6">
                        <label for="marque" class="form-label">Marque</label>
                        <input type="text" class="form-control" id="marque" name="marque" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="modele" class="form-label">Modèle</label>
                        <input type="text" class="form-control" id="modele" name="modele" required>
                    </div>
                    <div class="col-md-6">
                        <label for="categorie" class="form-label">Catégorie</label>
                        <select class="form-select" id="categorie" name="categorie" required>
                            <option value="">-- Choisir --</option>
                            <option value="Economique">Économique</option>
                            <option value="Confort">Confort</option>
                            <option value="Luxe">Luxe</option>
                            <option value="SUV">SUV</option>
                            <option value="Utilitaire">Utilitaire</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="nbPlaces" class="form-label">Nombre de places</label>
                        <input type="number" min="1" max="9" class="form-control" id="nbPlaces" name="nbPlaces" required>
                    </div>
                    <div class="col-md-4">
                        <label for="dateMiseCirculation" class="form-label">Date mise en circulation</label>
                        <input type="date" class="form-control" id="dateMiseCirculation" name="dateMiseCirculation" required>
                    </div>
                    <div class="col-md-4">
                        <label for="kilometrage" class="form-label">Kilométrage</label>
                        <input type="number" min="0" class="form-control" id="kilometrage" name="kilometrage" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="carburant" class="form-label">Carburant</label>
                        <select class="form-select" id="carburant" name="carburant" required>
                            <option value="">-- Choisir --</option>
                            <option value="Essence">Essence</option>
                            <option value="Diesel">Diesel</option>
                            <option value="Hybride">Hybride</option>
                            <option value="Electrique">Électrique</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="prixJour" class="form-label">Prix par jour (€)</label>
                        <input type="number" step="0.01" min="0" class="form-control" id="prixJour" name="prixJour" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="photo" class="form-label">Photo de la voiture</label>
                    <input type="file" class="form-control" id="photo" name="photo" accept="image/*">
                </div>

                <div class="d-flex justify-content-between">
                    <a href="${pageContext.request.contextPath}/gestionvoiture" class="btn btn-secondary">Annuler</a>
                    <button type="submit" class="btn btn-success">Ajouter la voiture</button>
                </div>
            </form>

            <!-- Messages -->
            <c:if test="${not empty message}">
                <div class="alert alert-success mt-3">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
