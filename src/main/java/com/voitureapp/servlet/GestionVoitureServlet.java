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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Récupérer toutes les voitures sans filtre
        List<Voiture> voitures = voitureService.getToutesLesVoitures();

        // Récupérer la liste des marques pour affichage ou filtres éventuels
        List<String> marques = voitureService.listerMarquesDisponibles();

        // Passer les données à la JSP
        request.setAttribute("voitures", voitures);
        request.setAttribute("marques", marques);

        // Forward vers la page JSP de gestion voiture
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
