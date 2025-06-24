package com.voitureapp.servlet;

import com.voitureapp.model.Voiture;
import com.voitureapp.service.VoitureService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/gestionvoiture")
public class GestionVoitureServlet extends HttpServlet {

    private VoitureService voitureService;

    @Override
    public void init() throws ServletException {
        super.init();
        voitureService = new VoitureService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String marqueFiltre = request.getParameter("marque");

        List<Voiture> voitures;

        boolean hasQuery = query != null && !query.trim().isEmpty();
        boolean hasMarque = marqueFiltre != null && !marqueFiltre.trim().isEmpty() && !marqueFiltre.equalsIgnoreCase("ALL");

        if (hasQuery || hasMarque) {
            voitures = voitureService.rechercher(query != null ? query : "", hasMarque ? marqueFiltre : null);
        } else {
            voitures = voitureService.getToutesLesVoitures();  // <-- correction ici
        }

        List<String> marques = voitureService.listerMarquesDisponibles();

        request.setAttribute("voitures", voitures);
        request.setAttribute("marques", marques);
        request.getRequestDispatcher("/WEB-INF/views/gestionvoiture.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        if (voitureService != null) {
            voitureService.fermer();
        }
        super.destroy();
    }
}
