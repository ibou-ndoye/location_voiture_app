<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 d-none d-md-block bg-dark sidebar text-white vh-100">
            <div class="sidebar-sticky pt-3">
                <h5 class="text-white text-center mb-4">Menu</h5>
               <ul class="nav flex-column">
    <li class="nav-item">
        <a class="nav-link text-white" href="${pageContext.request.contextPath}/gestionnaire/dashboard">Dashboard</a>
    </li>
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
                <p class="text-white">Connecté en tant que : <br/><strong>${utilisateurConnecte.nom}</strong> _ <strong>${utilisateurConnecte.prenom}</strong></p>
            </div>
        </nav>

        <!-- Main content -->
        <main class="col-md-10 ms-sm-auto px-md-4">
            <div class="d-flex justify-content-between align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Tableau de bord</h1>

                <!-- Barre de recherche -->
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="Rechercher une voiture..." aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Rechercher</button>
                </form>
            </div>
            <!-- Statistiques -->
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card text-bg-primary mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Total de voitures</h5>
                            <p class="card-text fs-4">${nbTotalVoitures}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-bg-success mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Voitures disponibles</h5>
                            <p class="card-text fs-4">${nbVoituresDisponibles}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card text-bg-warning mb-3">
                        <div class="card-body">
                            <h5 class="card-title">Voitures en location</h5>
                            <p class="card-text fs-4">${nbVoituresEnLocation}</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <h2>Situation du Parking (Graphique)</h2>
<canvas id="parkingChart" width="900" height="300"></canvas>
            

            <!-- Locations Actives -->
            <h2 class="mt-4">Locations Actives</h2>
            <div class="table-responsive mb-4">
                <table class="table table-bordered table-striped">
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

            <!-- Voitures Disponibles -->
            <h2>Voitures Disponibles</h2>
            <div class="table-responsive mb-4">
                <table class="table table-bordered">
                    <thead class="table-success">
                        <tr>
                            <th>Photo</th>
                            <th>Immatriculation</th>
                            <th>Marque</th>
                            <th>Modèle</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="v" items="${voituresDisponibles}">
                            <tr>
                                <td><img src="${pageContext.request.contextPath}/voiture/${v.photo}" alt="Photo de ${v.marque}" width="80" height="50"/>
</td>
                                <td>${v.immatriculation}</td>
                                <td>${v.marque}</td>
                                <td>${v.modele}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Top Voitures -->
            <h2>Top 5 voitures les plus louées</h2>
            <div class="table-responsive mb-4">
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
                                <td><img src="${pageContext.request.contextPath}/images/${vp[0].photo}" alt="Photo" width="80" height="50"/></td>
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
            <h2>Bilan Financier Mensuel</h2>
            <div class="table-responsive mb-5">
                <table class="table table-bordered table-striped">
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
        </main>
    </div>
</div>
<script>
    const ctx = document.getElementById('parkingChart').getContext('2d');

    const data = {
        labels: ['Total Voitures', 'Voitures Disponibles', 'Voitures en Location'],
        datasets: [{
            label: 'Nombre de voitures',
            data: [${nbTotalVoitures}, ${nbVoituresDisponibles}, ${nbVoituresEnLocation}],
            backgroundColor: [
                'rgba(54, 162, 235, 0.7)',
                'rgba(75, 192, 192, 0.7)',
                'rgba(255, 206, 86, 0.7)'
            ],
            borderColor: [
                'rgba(54, 162, 235, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(255, 206, 86, 1)'
            ],
            borderWidth: 1
        }]
    };

    const config = {
        type: 'bar',
        data: data,
        options: {
            scales: {
                y: { 
                    beginAtZero: true,
                    precision: 0
                }
            }
        }
    };

    const parkingChart = new Chart(ctx, config);
</script>


<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
