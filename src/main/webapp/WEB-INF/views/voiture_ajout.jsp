<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/includes/header.jsp" />

<div class="container">
    <h2>Ajouter une voiture</h2>

    <form method="post" action="${pageContext.request.contextPath}/voiture/ajouter">
    Immatriculation : <input type="text" name="immatriculation" required><br>
    Marque : <input type="text" name="marque" required><br>
    Modèle : <input type="text" name="modele" required><br>
    Date mise en circulation : <input type="date" name="dateMiseCirculation" required><br>
    Nombre de places : <input type="number" name="nbPlaces" min="1" required><br>
    Carburant :
    <select name="carburant" required>
        <option value="Essence">Essence</option>
        <option value="Diesel">Diesel</option>
        <option value="Hybride">Hybride</option>
        <option value="Electrique">Electrique</option>
    </select><br>
    Catégorie :
    <select name="categorie" required>
        <option value="Economique">Economique</option>
        <option value="Confort">Confort</option>
        <option value="Luxe">Luxe</option>
        <option value="SUV">SUV</option>
        <option value="Utilitaire">Utilitaire</option>
    </select><br>
    Prix par jour : <input type="number" name="prixJour" step="0.01" required><br>
    Disponible : <input type="checkbox" name="disponible"><br>

    <button type="submit">Ajouter la voiture</button>
</form>

</div>

<jsp:include page="/WEB-INF/views/includes/footer.jsp" />
