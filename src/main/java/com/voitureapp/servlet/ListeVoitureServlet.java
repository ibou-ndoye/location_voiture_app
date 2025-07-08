package com.voitureapp.servlet;

import com.voitureapp.model.Gestionnaire; // import nécessaire pour l'enum Role
import com.voitureapp.model.Voiture;
import com.voitureapp.service.VoitureService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/voitures")
public class ListeVoitureServlet extends HttpServlet {

    private VoitureService voitureService;

    @Override
    public void init() throws ServletException {
        voitureService = new VoitureService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String marque = request.getParameter("marque");
        String carburant = request.getParameter("carburant");
        String categorie = request.getParameter("categorie");
        String anneeStr = request.getParameter("annee");
        String kmMaxStr = request.getParameter("kilometrageMax");

        Integer annee = null;
        Integer kmMax = null;

        try {
            if (anneeStr != null && !anneeStr.isEmpty()) {
                annee = Integer.parseInt(anneeStr);
            }
        } catch (NumberFormatException ignored) {}

        try {
            if (kmMaxStr != null && !kmMaxStr.isEmpty()) {
                kmMax = Integer.parseInt(kmMaxStr);
            }
        } catch (NumberFormatException ignored) {}

        List<Voiture> voitures;
        boolean filtreActif = (marque != null && !marque.isEmpty())
                || (carburant != null && !carburant.isEmpty())
                || (categorie != null && !categorie.isEmpty())
                || annee != null || kmMax != null;

        if (filtreActif) {
            voitures = voitureService.rechercherVoitures(marque, carburant, categorie, annee, kmMax);
        } else {
            voitures = voitureService.getToutesLesVoitures();
        }

        request.setAttribute("voitures", voitures);
        request.setAttribute("marque", marque);
        request.setAttribute("carburant", carburant);
        request.setAttribute("categorie", categorie);
        request.setAttribute("annee", anneeStr);
        request.setAttribute("kilometrageMax", kmMaxStr);

        // ✅ Correction : cast en enum puis comparaison
        Gestionnaire.Role role = (Gestionnaire.Role) request.getSession().getAttribute("role");

        String page;
        if (role != null && role.name().equals("CHEF")) {
            page = "/WEB-INF/views/voituresChef.jsp";
        } else {
            page = "/WEB-INF/views/voitures.jsp";
        }

        request.getRequestDispatcher(page).forward(request, response);
    }

    @Override
    public void destroy() {
        if (voitureService != null) {
            voitureService.fermer();
        }
    }
}
