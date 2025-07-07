package com.voitureapp.servlet;

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

        // Récupérer toutes les voitures
        List<Voiture> voitures = voitureService.getToutesLesVoitures();

        // Transmettre les voitures à la page JSP
        request.setAttribute("voitures", voitures);

        // Rediriger vers la JSP correspondante
        request.getRequestDispatcher("/WEB-INF/views/voitures.jsp")
               .forward(request, response);
    }

    @Override
    public void destroy() {
        if (voitureService != null) {
            voitureService.fermer();
        }
    }
}
