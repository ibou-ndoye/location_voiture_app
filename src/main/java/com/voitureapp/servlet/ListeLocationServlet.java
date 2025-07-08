package com.voitureapp.servlet;
import com.voitureapp.model.Location;
import com.voitureapp.service.ServiceLocation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/locations")
public class ListeLocationServlet extends HttpServlet {

    private ServiceLocation serviceLocation;

    @Override
    public void init() throws ServletException {
        serviceLocation = new ServiceLocation();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Location> locations = serviceLocation.getToutesLesLocations();
        request.setAttribute("locations", locations);

        request.getRequestDispatcher("/WEB-INF/views/locations.jsp").forward(request, response);
    }

    @Override
    public void destroy() {
        if (serviceLocation != null) {
            serviceLocation.fermer();
        }
    }
}
