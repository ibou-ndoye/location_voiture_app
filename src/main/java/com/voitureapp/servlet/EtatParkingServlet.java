package com.voitureapp.servlet;

import com.voitureapp.dao.LocationDAO;
import com.voitureapp.dao.VoitureDAO;
import com.voitureapp.model.Location;
import com.voitureapp.model.Voiture;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/etatParking")
public class EtatParkingServlet extends HttpServlet {

    private VoitureDAO voitureDAO;
    private LocationDAO locationDAO;

    @Override
    public void init() throws ServletException {
        voitureDAO = new VoitureDAO();
        locationDAO = new LocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Vérification d'authentification
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("utilisateurConnecte") == null) {
            // Redirection vers la page de login (ex: /login)
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // ✅ Récupération des données du parking
            int nombreTotal = voitureDAO.countAll();
            List<Location> voituresEnLocation = locationDAO.getVoituresEnLocation();
            List<Voiture> voituresDisponibles = voitureDAO.getVoituresDisponibles();

            // ✅ Passage à la JSP
            request.setAttribute("nombreTotal", nombreTotal);
            request.setAttribute("voituresEnLocation", voituresEnLocation);
            request.setAttribute("voituresDisponibles", voituresDisponibles);

            request.getRequestDispatcher("/WEB-INF/views/etatParking.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // à supprimer en prod
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur : " + e.getMessage());
        }
    }
}
