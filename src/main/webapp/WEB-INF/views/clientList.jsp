<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>

<c:set var="hasSearch" value="${not empty param.recherche}" />

<div class="container py-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary fw-bold mb-0">Ajouter / Modifier un client</h2>
        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
            <i class="bi bi-house-door-fill"></i> Accueil
        </a>
    </div>

    <div class="bg-light p-4 rounded shadow-sm mb-5">
        <form action="${pageContext.request.contextPath}/clients" method="post" class="row g-3">
            <input type="hidden" name="idClient" value="${client.idClient}" />
            <div class="col-md-4">
                <label class="form-label">CIN</label>
                <input type="text" name="cin" class="form-control" value="${client.cin}" required />
            </div>
            <div class="col-md-4">
                <label class="form-label">Prénom</label>
                <input type="text" name="prenom" class="form-control" value="${client.prenom}" required />
            </div>
            <div class="col-md-4">
                <label class="form-label">Nom</label>
                <input type="text" name="nom" class="form-control" value="${client.nom}" required />
            </div>
            <div class="col-md-4">
                <label class="form-label">Sexe</label>
                <select name="sexe" class="form-select" required>
                    <option value="M" ${client.sexe == 'M' ? 'selected' : ''}>Masculin</option>
                    <option value="F" ${client.sexe == 'F' ? 'selected' : ''}>Féminin</option>
                </select>
            </div>
            <div class="col-md-8">
                <label class="form-label">Adresse</label>
                <input type="text" name="adresse" class="form-control" value="${client.adresse}" required />
            </div>
            <div class="col-md-6">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="${client.email}" required />
            </div>
            <div class="col-md-6">
                <label class="form-label">Téléphone</label>
                <input type="text" name="telephone" class="form-control" value="${client.telephone}" required />
            </div>
            <div class="col-12 d-flex justify-content-end">
                <button type="submit" class="btn btn-success px-4">Enregistrer</button>
            </div>
        </form>
    </div>

    <hr class="my-5" />

    <h2 class="mb-3 text-info">
        <a href="#" id="toggleClientList" class="text-decoration-none">📋 Liste des Clients</a>
    </h2>

    <div class="row mb-3" id="searchBar" style="display: ${hasSearch ? 'flex' : 'none'};">
        <form method="get" action="${pageContext.request.contextPath}/clients" class="d-flex gap-2">
            <input type="text" name="recherche" class="form-control" placeholder="Rechercher par nom ou CIN">
            <button type="submit" class="btn btn-outline-primary">Rechercher</button>
        </form>
    </div>

    <div class="mb-3" id="downloadSection" style="display: ${hasSearch ? 'block' : 'none'};">
        <button id="downloadPdfBtn" class="btn btn-outline-danger">📥 Télécharger la liste (PDF)</button>
    </div>

    <div id="clientList" class="table-responsive" style="display: ${hasSearch ? 'block' : 'none'};">
        <table id="clientsTable" class="table table-hover table-striped table-bordered align-middle">
            <thead class="table-primary text-center">
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
                        <td>
                            <a href="clients/details?id=${client.idClient}" class="btn btn-sm btn-info" title="Voir Détails">
                                <i class="bi bi-eye"></i>
                            </a>
                            <a href="clients/modifier?id=${client.idClient}" class="btn btn-sm btn-warning" title="Modifier">
                                <i class="bi bi-pencil"></i>
                            </a>
                            <a href="clients/supprimer?id=${client.idClient}" class="btn btn-sm btn-danger" title="Supprimer"
                               onclick="return confirm('Confirmer la suppression ?');">
                                <i class="bi bi-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp"/>

<!-- jsPDF & autoTable -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>

<!-- JS toggle + PDF -->
<script>
    document.getElementById("toggleClientList").addEventListener("click", function (event) {
        event.preventDefault();
        const list = document.getElementById("clientList");
        const download = document.getElementById("downloadSection");
        const search = document.getElementById("searchBar");
        const isHidden = list.style.display === "none";
        list.style.display = isHidden ? "block" : "none";
        download.style.display = isHidden ? "block" : "none";
        search.style.display = isHidden ? "flex" : "none";
    });

    document.getElementById("downloadPdfBtn").addEventListener("click", function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.text("Liste des Clients", 14, 16);

        const table = document.getElementById("clientsTable");
        const rows = Array.from(table.querySelectorAll("tbody tr")).map(row => {
            return Array.from(row.querySelectorAll("td")).slice(0, -1).map(cell => cell.innerText);
        });

        const headers = Array.from(table.querySelectorAll("thead th")).slice(0, -1).map(th => th.innerText);

        doc.autoTable({
            head: [headers],
            body: rows,
            startY: 20,
            theme: 'grid',
        });

        doc.save("liste_clients.pdf");
    });

    // Force l'affichage de la liste si une recherche est en cours
    window.addEventListener("DOMContentLoaded", () => {
        const hasSearch = "${hasSearch}" === "true";
        if (hasSearch) {
            document.getElementById("clientList").style.display = "block";
            document.getElementById("downloadSection").style.display = "block";
            document.getElementById("searchBar").style.display = "flex";
        }
    });
</script>
