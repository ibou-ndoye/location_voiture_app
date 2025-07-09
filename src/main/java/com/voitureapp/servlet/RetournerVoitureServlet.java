package com.voitureapp.servlet;

import com.voitureapp.dao.LocationDAO;
import com.voitureapp.dao.VoitureDAO;
import com.voitureapp.model.Location;
import com.voitureapp.model.Voiture;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/retournerVoiture")
public class RetournerVoitureServlet extends HttpServlet {

    private LocationDAO locationDAO;
    private VoitureDAO voitureDAO;

    @Override
    public void init() throws ServletException {
        locationDAO = new LocationDAO();
        voitureDAO = new VoitureDAO(); // Pour modifier la disponibilité de la voiture
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idLocationStr = request.getParameter("idLocation");
        if (idLocationStr == null) {
            response.sendRedirect(request.getContextPath() + "/etatParking");
            return;
        }

        try {
            int idLocation = Integer.parseInt(idLocationStr);
            Location location = locationDAO.findByIdAvecDetails(idLocation);
            if (location == null) {
                response.sendRedirect(request.getContextPath() + "/etatParking");
                return;
            }

            request.setAttribute("location", location);
            request.getRequestDispatcher("/WEB-INF/views/retournerVoitureForm.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/etatParking");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idLocation = Integer.parseInt(request.getParameter("idLocation"));
            String dateRetourStr = request.getParameter("dateRetour");
            String kilometrageRetourStr = request.getParameter("kilometrageRetour");

            if (dateRetourStr == null || dateRetourStr.isBlank() || kilometrageRetourStr == null || kilometrageRetourStr.isBlank()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Champs manquants");
                return;
            }

            LocalDateTime dateRetour = LocalDateTime.parse(dateRetourStr);
            int kilometrageRetour = Integer.parseInt(kilometrageRetourStr);

            Location location = locationDAO.findByIdAvecDetails(idLocation);
            if (location == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Location introuvable");
                return;
            }

            // Mise à jour des informations de retour
            location.setDateFinReelle(dateRetour);
            location.setKilometrageRetour(kilometrageRetour);
            location.setSigneClient(true);
            location.setSigneGestionnaire(true);

            // Marquer la voiture comme disponible
            Voiture voiture = location.getVoiture();
            if (voiture != null) {
                voiture.setDisponible(true);
                voitureDAO.update(voiture); // Mise à jour explicite
            }

            locationDAO.update(location);

            response.sendRedirect(request.getContextPath() + "/etatParking");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Données invalides");
        }
    }
}
