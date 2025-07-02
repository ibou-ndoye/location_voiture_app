package com.voitureapp.servlet;

import com.voitureapp.dao.LocationDAO;
import com.voitureapp.model.Location;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/retournerVoiture")
public class RetournerVoitureServlet extends HttpServlet {

    private LocationDAO locationDAO;

    @Override
    public void init() throws ServletException {
        locationDAO = new LocationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idLocationStr = request.getParameter("idLocation");
        if (idLocationStr == null) {
            response.sendRedirect(request.getContextPath() + "/etatParking");
            return;
        }

        int idLocation = Integer.parseInt(idLocationStr);
        Location location = locationDAO.findById(idLocation);
        if (location == null) {
            response.sendRedirect(request.getContextPath() + "/etatParking");
            return;
        }

        request.setAttribute("location", location);
        request.getRequestDispatcher("/WEB-INF/views/retournerVoitureForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idLocation = Integer.parseInt(request.getParameter("idLocation"));
            String dateRetourStr = request.getParameter("dateRetour");
            String kilometrageRetourStr = request.getParameter("kilometrageRetour");

            Location location = locationDAO.findById(idLocation);
            if (location == null) {
                response.sendRedirect(request.getContextPath() + "/etatParking");
                return;
            }

            // Parse date retour (format attendu : yyyy-MM-dd'T'HH:mm)
            LocalDateTime dateRetour = LocalDateTime.parse(dateRetourStr);

            int kilometrageRetour = Integer.parseInt(kilometrageRetourStr);

            location.setDateFinReelle(dateRetour);
            location.setKilometrageRetour(kilometrageRetour);

            // Suppose que la signature client est validée ici
            location.setSigneClient(true);
            location.setSigneGestionnaire(true);

            locationDAO.update(location);

            response.sendRedirect(request.getContextPath() + "/etatParking");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Données invalides");
        }
    }
}
