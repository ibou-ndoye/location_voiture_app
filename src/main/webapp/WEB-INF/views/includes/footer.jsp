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
        if (confirm("�tes-vous s�r de vouloir vous d�connecter ?")) {
            window.location.href = "${pageContext.request.contextPath}/login";
        }
    }
</script>
</body>
</html>
