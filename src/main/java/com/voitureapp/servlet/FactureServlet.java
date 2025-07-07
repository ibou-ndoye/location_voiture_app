package com.voitureapp.servlet;

import com.voitureapp.model.Location;
import com.voitureapp.service.ServiceLocation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/facture")
public class FactureServlet extends HttpServlet {

    private ServiceLocation locationService;

    @Override
    public void init() {
        locationService = new ServiceLocation();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre id manquant");
            return;
        }

        int idLocation;
        try {
            idLocation = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre id invalide");
            return;
        }

        Location location = locationService.findByIdAvecDetails(idLocation);

        if (location == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Location non trouvée");
            return;
        }

        location.formaterDates();

        request.setAttribute("location", location);
        request.getRequestDispatcher("/WEB-INF/views/facture.jsp").forward(request, response);
    }
}
