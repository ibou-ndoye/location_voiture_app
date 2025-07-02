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
                        <li class="nav-item"><a class="nav-link text-white" href="${pageContext.request.contextPath}/voitures">Voitures</a></li>
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

        <!-- Main content -->
        <main class="col-md-10 offset-md-2 px-4">
            <div class="pt-4 pb-2 mb-4 border-bottom d-flex justify-content-between align-items-center">
                <h2 class="fw-bold">Tableau de bord</h2>
                <form class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Rechercher une voiture..." />
                    <button class="btn btn-outline-success">Rechercher</button>
                </form>
            </div>

            <!-- Statistiques -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card shadow-sm rounded text-bg-primary">
                        <div class="card-body text-center">
                            <h5>Total de voitures</h5>
                            <p class="fs-3">${nbTotalVoitures}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-sm rounded text-bg-success">
                        <div class="card-body text-center">
                            <h5>Voitures disponibles</h5>
                            <p class="fs-3">${nbVoituresDisponibles}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-sm rounded text-bg-warning">
                        <div class="card-body text-center">
                            <h5>Voitures en location</h5>
                            <p class="fs-3">${nbVoituresEnLocation}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Graphique -->
            <div class="mb-5">
                <h4 class="mb-3">Situation du Parking</h4>
                <canvas id="parkingChart" width="100%" height="40"></canvas>
            </div>

            <!-- Locations Actives -->
            <h4>Locations Actives</h4>
            <div class="table-responsive mb-5">
                <table class="table table-striped table-bordered align-middle">
                    <thead class="table-dark">
                        <tr>
                            <th>Client</th>
                            <th>Voiture</th>
                            <th>Date début</th>
                            <th>Date fin prévue</th>
                            <th>Jours restants</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="loc" items="${locationsActives}">
                            <tr>
                                <td>${loc.client.nom} ${loc.client.prenom}</td>
                                <td>${loc.voiture.marque} ${loc.voiture.modele}</td>
                                <td>${loc.dateDebut}</td>
                                <td>${loc.dateFinPrevue}</td>
                                <td>${loc.joursRestants}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Top 5 Voitures les plus louées -->
            <h4>Top 5 voitures les plus louées</h4>
            <div class="table-responsive mb-5">
                <table class="table table-bordered table-hover">
                    <thead class="table-info">
                        <tr>
                            <th>Photo</th>
                            <th>Immatriculation</th>
                            <th>Marque</th>
                            <th>Modèle</th>
                            <th>Nombre de locations</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="vp" items="${voituresPopularite}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/voiture/${vp[0].photo}" alt="Photo" class="img-thumbnail" style="width: 80px; height: 50px; object-fit: cover;" />
                                </td>
                                <td>${vp[0].immatriculation}</td>
                                <td>${vp[0].marque}</td>
                                <td>${vp[0].modele}</td>
                                <td>${vp[1]}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Bilan Financier -->
            <h4>Bilan Financier Mensuel</h4>
            <div class="table-responsive mb-3">
                <table class="table table-striped table-bordered">
                    <thead class="table-warning">
                        <tr>
                            <th>Mois</th>
                            <th>Année</th>
                            <th>Total (€)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="b" items="${bilanMensuel}">
                            <tr>
                                <td>${b[0]}</td>
                                <td>${b[1]}</td>
                                <td>${b[2]}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Graphique du Bilan Financier Mensuel -->
            <h4>Bilan Financier - Graphique</h4>
            <canvas id="bilanChart" width="100%" height="40"></canvas>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Graphique Situation du Parking (barres)
    const ctx = document.getElementById('parkingChart').getContext('2d');
    const config = {
        type: 'bar',
        data: {
            labels: ['Total Voitures', 'Disponibles', 'En Location'],
            datasets: [{
                label: 'Nombre de voitures',
                data: [${nbTotalVoitures}, ${nbVoituresDisponibles}, ${nbVoituresEnLocation}],
                backgroundColor: ['#0d6efd', '#198754', '#ffc107'],
                borderColor: ['#0d6efd', '#198754', '#ffc107'],
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    precision: 0
                }
            }
        }
    };
    new Chart(ctx, config);

    // Graphique Bilan Financier Mensuel (ligne)
    const bilanLabels = [];
    const bilanData = [];

    <c:forEach var="b" items="${bilanMensuel}">
        bilanLabels.push("${b[0]}-${b[1]}");
        bilanData.push(${b[2]});
    </c:forEach>

    const ctxBilan = document.getElementById('bilanChart').getContext('2d');
    const configBilan = {
        type: 'line',
        data: {
            labels: bilanLabels,
            datasets: [{
                label: 'Total en €',
                data: bilanData,
                backgroundColor: 'rgba(13, 110, 253, 0.2)',
                borderColor: 'rgba(13, 110, 253, 1)',
                borderWidth: 2,
                fill: true,
                tension: 0.4,
                pointBackgroundColor: '#fff',
                pointBorderColor: '#0d6efd'
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: { display: true }
            },
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    };
    new Chart(ctxBilan, configBilan);
</script>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
