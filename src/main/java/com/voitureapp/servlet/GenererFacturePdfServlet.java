package com.voitureapp.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.voitureapp.model.Location;
import com.voitureapp.service.ServiceLocation;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/genererFacturePdf")
public class GenererFacturePdfServlet extends HttpServlet {

    private ServiceLocation locationService;

    @Override
    public void init() {
        locationService = new ServiceLocation();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");

        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Paramètre manquant.");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            Location loc = locationService.getLocationById(id);

            if (loc == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Location non trouvée.");
                return;
            }

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"facture_" + id + ".pdf\"");

            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Facture de location #" + id));
            document.add(new Paragraph("Client : " + loc.getClient().getNom() + " " + loc.getClient().getPrenom()));
            document.add(new Paragraph("Voiture : " + loc.getVoiture().getMarque() + " " + loc.getVoiture().getModele()));
            document.add(new Paragraph("Montant : " + loc.getPrixTotal() + " €"));

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur PDF");
        }
    }
}
