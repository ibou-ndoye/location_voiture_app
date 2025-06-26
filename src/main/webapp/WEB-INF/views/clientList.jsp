<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp"/>

<div class="container py-5">
    <div class="bg-light p-4 rounded shadow-sm">
        <h2 class="mb-4 text-primary fw-bold border-bottom pb-2">Ajouter un nouveau client</h2>
        <form action="${pageContext.request.contextPath}/clients" method="post" class="row g-3">
            <div class="col-md-4">
                <label class="form-label">CIN</label>
                <input type="text" name="cin" class="form-control" required/>
            </div>
            <div class="col-md-4">
                <label class="form-label">Prénom</label>
                <input type="text" name="prenom" class="form-control" required/>
            </div>
            <div class="col-md-4">
                <label class="form-label">Nom</label>
                <input type="text" name="nom" class="form-control" required/>
            </div>
            <div class="col-md-4">
                <label class="form-label">Sexe</label>
                <select name="sexe" class="form-select" required>
                    <option value="M">Masculin</option>
                    <option value="F">Féminin</option>
                </select>
            </div>
            <div class="col-md-8">
                <label class="form-label">Adresse</label>
                <input type="text" name="adresse" class="form-control" required/>
            </div>
            <div class="col-md-6">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required/>
            </div>
            <div class="col-md-6">
                <label class="form-label">Téléphone</label>
                <input type="text" name="telephone" class="form-control" required/>
            </div>
            <div class="col-12 d-flex justify-content-end">
                <button type="submit" class="btn btn-success px-4">Ajouter</button>
            </div>
        </form>
    </div>

    <hr class="my-5"/>

    <h2 class="mb-3 text-info">
        <a href="#" id="toggleClientList" class="text-decoration-none">📋 Liste des Clients</a>
    </h2>

    <div class="mb-3" id="downloadSection" style="display: none;">
        <button id="downloadPdfBtn" class="btn btn-outline-danger">📥 Télécharger la liste (PDF)</button>
    </div>

    <div id="clientList" class="table-responsive" style="display: none;">
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
    document.getElementById("toggleClientList").addEventListener("click", function(event) {
        event.preventDefault();
        const list = document.getElementById("clientList");
        const download = document.getElementById("downloadSection");
        const isHidden = list.style.display === "none";
        list.style.display = isHidden ? "block" : "none";
        download.style.display = isHidden ? "block" : "none";
    });

    document.getElementById("downloadPdfBtn").addEventListener("click", function () {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.text("Liste des Clients", 14, 16);

        const table = document.getElementById("clientsTable");
        const rows = Array.from(table.querySelectorAll("tbody tr")).map(row => {
            return Array.from(row.querySelectorAll("td")).map(cell => cell.innerText);
        });

        const headers = Array.from(table.querySelectorAll("thead th")).map(th => th.innerText);

        doc.autoTable({
            head: [headers],
            body: rows,
            startY: 20,
            theme: 'grid',
        });

        doc.save("liste_clients.pdf");
    });
</script>
