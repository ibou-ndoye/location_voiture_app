<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container py-5">
    <!-- Alertes -->
    <c:if test="${param.success == '1'}">
        <div class="alert alert-success text-center fw-bold" role="alert">
            ✅ Client supprimé avec succès.
        </div>
    </c:if>

    <c:if test="${param.erreur == '1'}">
        <div class="alert alert-warning text-center fw-bold" role="alert">
            ⚠️ Ce client ne peut pas être supprimé car il possède des locations.
        </div>
    </c:if>

    <c:if test="${param.erreur == '2'}">
        <div class="alert alert-danger text-center fw-bold" role="alert">
            ❌ Client introuvable.
        </div>
    </c:if>

    <!-- En-tête -->
    <div class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-4">
        <h2 class="text-info fw-bold mb-0">
            <i class="bi bi-people-fill"></i> Liste des Clients
        </h2>
    </div>

    <!-- Bouton toggle -->
    <h5 class="mb-3 text-secondary">
        <a href="#" id="toggleClientList" class="text-decoration-none">
            <i class="bi bi-chevron-double-down"></i> Afficher / Masquer la liste
        </a>
    </h5>

    <!-- Barre de recherche -->
    <div class="row mb-3" id="searchBar">
        <form method="get" action="${pageContext.request.contextPath}/clientel" class="d-flex gap-2">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-search"></i></span>
                <input type="text" name="recherche" class="form-control" placeholder="Rechercher par nom ou CIN"
                       value="${param.recherche != null ? param.recherche : ''}" />
                <button type="submit" class="btn btn-outline-primary">Rechercher</button>
            </div>
        </form>
    </div>

    <!-- Bouton PDF -->
    <div class="mb-3" id="downloadSection">
        <button id="downloadPdfBtn" class="btn btn-danger d-flex align-items-center gap-2">
            <i class="bi bi-file-earmark-pdf-fill"></i> Télécharger PDF
        </button>
    </div>

    <!-- Liste des clients -->
    <div id="clientList" class="table-responsive">
        <table id="clientsTable" class="table table-hover table-bordered align-middle table-sm">
            <thead class="table-light text-center">
                <tr>
                    <th>ID</th>
                    <th>CIN</th>
                    <th>Prénom</th>
                    <th>Nom</th>
                    <th>Sexe</th>
                    <th>Adresse</th>
                    <th>Email</th>
                    <th>Téléphone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="client" items="${clients}">
                    <tr class="text-center">
                        <td>${client.idClient}</td>
                        <td>${client.cin}</td>
                        <td>${client.prenom}</td>
                        <td>${client.nom}</td>
                        <td>${client.sexe}</td>
                        <td>${client.adresse}</td>
                        <td>${client.email}</td>
                        <td>${client.telephone}</td>
                        <td class="d-flex justify-content-center gap-1">
                            <a href="${pageContext.request.contextPath}/clients/details?id=${client.idClient}" class="btn btn-sm btn-outline-info" title="Voir Détails">
                                <i class="bi bi-eye-fill"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/clients/modifier?id=${client.idClient}" class="btn btn-sm btn-outline-warning" title="Modifier">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/clientel?action=supprimer&id=${client.idClient}" 
   class="btn btn-sm btn-outline-danger" title="Supprimer"
   onclick="return confirm('Confirmer la suppression ?');">
    <i class="bi bi-trash-fill"></i>
</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />

<!-- jsPDF + autoTable -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

<!-- JS actions -->
<script>
    document.getElementById("toggleClientList").addEventListener("click", function (e) {
        e.preventDefault();
        const list = document.getElementById("clientList");
        const search = document.getElementById("searchBar");
        const download = document.getElementById("downloadSection");
        list.classList.toggle("d-none");
        search.classList.toggle("d-none");
        download.classList.toggle("d-none");
    });

    document.getElementById("downloadPdfBtn").addEventListener("click", function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();
        doc.text("Liste des Clients", 14, 16);

        const table = document.getElementById("clientsTable");
        const rows = Array.from(table.querySelectorAll("tbody tr")).map(row => {
            return Array.from(row.querySelectorAll("td")).slice(0, -1).map(cell => cell.innerText);
        });

        if (rows.length === 0) {
            alert("Aucun client à exporter !");
            return;
        }

        const headers = Array.from(table.querySelectorAll("thead th")).slice(0, -1).map(th => th.innerText);
        doc.autoTable({
            head: [headers],
            body: rows,
            startY: 20,
            theme: 'grid',
        });
        doc.save("liste_clients.pdf");
    });
</script>

<!-- Style -->
<style>
    tr:hover {
        background-color: #f8f9fa;
    }

    input:focus, select:focus {
        border-color: #0d6efd;
        box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
    }

    #clientList, #searchBar, #downloadSection {
        transition: all 0.4s ease;
    }
</style>
