package com.voitureapp.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;

import java.io.IOException;
import com.voitureapp.model.Location;
import com.voitureapp.service.ServiceLocation;

@WebServlet("/genererFacturePdf")
public class GenererFacturePdfServlet extends HttpServlet {

    private ServiceLocation locationService;

    @Override
    public void init() {
        locationService = new ServiceLocation();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Location location = locationService.getLocationById(id);

            // Mettre à jour les signatures
            location.setSigneClient(true);
            location.setSigneGestionnaire(true);
            locationService.mettreAJourLocation(location);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=facture_location_" + id + ".pdf");

            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Ajout du contenu de la facture
            document.add(new Paragraph("FACTURE DE LOCATION", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16)));
            document.add(new Paragraph("\nClient : " + location.getClient().getNom() + " " + location.getClient().getPrenom()));
            document.add(new Paragraph("Voiture : " + location.getVoiture().getMarque() + " " + location.getVoiture().getModele()));
            document.add(new Paragraph("Immatriculation : " + location.getVoiture().getImmatriculation()));
            document.add(new Paragraph("Date début : " + location.getDateDebut()));
            document.add(new Paragraph("Date fin prévue : " + location.getDateFinPrevue()));
            document.add(new Paragraph("Kilométrage départ : " + location.getKilometrageDepart() + " km"));
            document.add(new Paragraph("Prix total : " + location.getPrixTotal() + " €"));
            document.add(new Paragraph("\n✔️ Signatures : Client et Gestionnaire"));

            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/locations");
        }
    }
}
