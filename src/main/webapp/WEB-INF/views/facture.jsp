<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<style>
    .highlight-arrow {
        animation: bounce 1.5s infinite;
        font-size: 2rem;
        color: #0d6efd;
        display: block;
        text-align: center;
        margin-top: 1rem;
    }
    @keyframes bounce {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-10px); }
    }

    .facture-card {
        max-width: 800px;
        margin: auto;
    }

    .voiture-img {
        width: 100%;
        max-width: 350px;
        height: auto;
        border-radius: 10px;
        border: 1px solid #ccc;
    }
</style>

<div class="container my-5">
    <div class="card shadow-lg p-5 facture-card">
        <h2 class="mb-4 text-center text-primary">🧾 Facture de location</h2>

        <div class="row mb-4">
            <div class="col-md-6">
                <p><strong>👤 Client :</strong> ${location.client.nom} ${location.client.prenom}</p>
                <p><strong>🚗 Voiture :</strong> ${location.voiture.marque} ${location.voiture.modele} (${location.voiture.immatriculation})</p>
                <p><strong>📅 Date début :</strong> ${location.dateDebutFormatee}</p>
                <p><strong>📅 Date fin prévue :</strong> ${location.dateFinPrevueFormatee}</p>
                <p><strong>📏 Kilométrage départ :</strong> ${location.kilometrageDepart} km</p>
                <p><strong>💰 Prix total :</strong> <span class="text-success fw-bold">${location.prixTotal} €</span></p>
            </div>
            <div class="col-md-6 text-center">
                <img src="${pageContext.request.contextPath}/voiture/${location.voiture.photo}" 
                     alt="Photo de la voiture" 
                     class="voiture-img mt-2" />
            </div>
        </div>

        <hr>

        <c:if test="${param.signatures == 'true'}">
            <div class="mt-3">
                <p><strong>✍️ Signature client :</strong> 
                    <span class="${location.signeClient ? 'text-success' : 'text-danger'}">
                        ${location.signeClient ? "✔️ Signé" : "❌ Non signé"}
                    </span>
                </p>
                <p><strong>✍️ Signature gestionnaire :</strong> 
                    <span class="${location.signeGestionnaire ? 'text-success' : 'text-danger'}">
                        ${location.signeGestionnaire ? "✔️ Signé" : "❌ Non signé"}
                    </span>
                </p>
            </div>
        </c:if>

        <!-- Flèche animée -->
        <div id="arrowContainer" class="highlight-arrow">⬇️</div>

        <div class="mt-4 text-center">
            <!-- BOUTON DE TÉLÉCHARGEMENT PDF -->
            <button id="btnTelechargerPdf" class="btn btn-outline-primary btn-lg me-2">
                📥 Télécharger la facture (PDF)
            </button>

            <a href="${pageContext.request.contextPath}/gestionvoiture" class="btn btn-secondary btn-lg">Retour</a>
        </div>
    </div>
</div>

<!-- JS: Défilement + Téléchargement PDF -->
<script>
    window.addEventListener("load", function () {
        const arrow = document.getElementById("arrowContainer");
        arrow.scrollIntoView({ behavior: "smooth", block: "center" });
    });

    document.getElementById("btnTelechargerPdf").addEventListener("click", function () {
        const url = "${pageContext.request.contextPath}/genererFacturePdf?id=${location.idLocation}";
        
        // Créer iframe invisible pour télécharger
        const iframe = document.createElement("iframe");
        iframe.style.display = "none";
        iframe.src = url;
        document.body.appendChild(iframe);

        // Nettoyage + blocage temporaire du bouton
        const btn = this;
        btn.disabled = true;
        setTimeout(() => {
            document.body.removeChild(iframe);
            btn.disabled = false;
        }, 3000);
    });
</script>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
