<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<div class="container mt-5">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Passer une commande de location</h4>
        </div>
        <div class="card-body">

            <form action="${pageContext.request.contextPath}/passerCommande" method="post" class="row g-4 needs-validation" id="formCommande" oninput="calculerPrix()" novalidate>

                <!-- Sélection du client -->
                <div class="col-md-6">
                    <label for="clientSelect" class="form-label">Client</label>
                    <select name="id_client" id="clientSelect" class="form-select" required>
                        <option value="">-- Sélectionner un client --</option>
                        <c:forEach var="c" items="${clients}">
                            <option value="${c.idClient}">${c.nom} ${c.prenom} (${c.cin})</option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Veuillez sélectionner un client.</div>
                </div>

                <!-- Sélection de la voiture -->
                <div class="col-md-6">
                    <label for="voitureSelect" class="form-label">Voiture</label>
                    <select name="immatriculation" id="voitureSelect" class="form-select" required onchange="updateKilometrage()">
                        <option value="">-- Sélectionner une voiture --</option>
                        <c:forEach var="v" items="${voituresDisponibles}">
                            <option value="${v.immatriculation}" data-km="${v.kilometrage}" data-prix="${v.prixJour}">
                                ${v.marque} ${v.modele} (${v.immatriculation})
                            </option>
                        </c:forEach>
                    </select>
                    <div class="invalid-feedback">Veuillez sélectionner une voiture.</div>
                </div>

                <!-- Dates de location -->
                <div class="col-md-6">
                    <label for="dateDebut" class="form-label">Date de début</label>
                    <input type="date" id="dateDebut" name="date_debut" class="form-control" required>
                    <div class="invalid-feedback">Veuillez entrer la date de début.</div>
                </div>
                <div class="col-md-6">
                    <label for="dateFin" class="form-label">Date de fin prévue</label>
                    <input type="date" id="dateFin" name="date_fin_prevue" class="form-control" required>
                    <div class="invalid-feedback">Veuillez entrer la date de fin prévue.</div>
                </div>

                <!-- Kilométrage de départ -->
                <div class="col-md-6">
                    <label for="kmDepart" class="form-label">Kilométrage de départ</label>
                    <input type="number" id="kmDepart" name="kilometrage_depart" class="form-control" readonly required>
                </div>

                <!-- Prix total -->
                <div class="col-md-6">
                    <label for="prixTotal" class="form-label">Prix total (€)</label>
                    <input type="text" id="prixTotal" name="prix_total" class="form-control" readonly required>
                </div>

                <!-- Id gestionnaire caché -->
                <input type="hidden" name="id_gestionnaire" value="${utilisateurConnecte.idGestionnaire}" />

                <!-- Boutons -->
                <div class="col-12 d-flex justify-content-end">
                    <a href="${pageContext.request.contextPath}/gestionvoiture" class="btn btn-outline-secondary me-2">Annuler</a>
                    <button type="submit" class="btn btn-success">Valider la commande</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function updateKilometrage() {
        const select = document.getElementById('voitureSelect');
        const selectedOption = select.options[select.selectedIndex];
        const km = selectedOption.getAttribute('data-km');
        document.getElementById('kmDepart').value = km || '';
        calculerPrix();
    }

    function calculerPrix() {
        const select = document.getElementById('voitureSelect');
        const selectedOption = select.options[select.selectedIndex];
        const prixJour = parseFloat(selectedOption ? selectedOption.getAttribute('data-prix') : 0) || 0;

        const dateDebut = new Date(document.getElementById('dateDebut').value);
        const dateFin = new Date(document.getElementById('dateFin').value);

        if (!isNaN(dateDebut.getTime()) && !isNaN(dateFin.getTime()) && dateFin >= dateDebut) {
            const diffTime = dateFin - dateDebut;
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24)) + 1;
            const total = prixJour * diffDays;
            document.getElementById('prixTotal').value = total.toFixed(2);
        } else {
            document.getElementById('prixTotal').value = '';
        }
    }

    document.getElementById('formCommande').addEventListener('submit', function(e) {
        const voitureVal = document.getElementById('voitureSelect').value;
        const clientVal = document.getElementById('clientSelect').value;
        if (!voitureVal || !clientVal) {
            alert("Veuillez sélectionner un client et une voiture.");
            e.preventDefault();
        }
    });
</script>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
