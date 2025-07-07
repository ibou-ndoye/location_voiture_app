<c:if test="${not empty sessionScope.utilisateurConnecte}">
    </div> <!-- /content -->
</c:if>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleDarkMode() {
        document.body.classList.toggle('dark-mode');
    }

    function confirmLogout() {
        if (confirm("Êtes-vous sûr de vouloir vous déconnecter ?")) {
            window.location.href = "${pageContext.request.contextPath}/login";
        }
    }
</script>
</body>
</html>
