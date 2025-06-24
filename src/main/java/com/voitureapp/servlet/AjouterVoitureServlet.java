package com.voitureapp.servlet;

import com.voitureapp.model.Voiture;
import com.voitureapp.service.VoitureService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;
import java.time.LocalDate;

@WebServlet("/ajouterVoiture")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AjouterVoitureServlet extends HttpServlet {

    private VoitureService voitureService;

    @Override
    public void init() {
        voitureService = new VoitureService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/ajouterVoiture.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Récupération des paramètres
            String immat = req.getParameter("immatriculation").trim();
            String marque = req.getParameter("marque").trim();
            String modele = req.getParameter("modele").trim();
            int nbPlaces = Integer.parseInt(req.getParameter("nbPlaces"));
            LocalDate dateMiseCirculation = LocalDate.parse(req.getParameter("dateMiseCirculation"));
            int kilometrage = Integer.parseInt(req.getParameter("kilometrage"));
            String carburantStr = req.getParameter("carburant");
            String categorieStr = req.getParameter("categorie");
            double prixJour = Double.parseDouble(req.getParameter("prixJour"));

            // Gestion de la photo
            Part part = req.getPart("photo");
            String fileName = null;
            if (part != null && part.getSize() > 0) {
                fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

                // Choix d'un dossier d'upload fixe (exemple : dossier uploads dans la racine du projet)
                String uploadDir = System.getProperty("user.home") + File.separator + "voitureapp-uploads";
                Files.createDirectories(Paths.get(uploadDir));

                try (InputStream is = part.getInputStream()) {
                    Files.copy(is,
                            Paths.get(uploadDir, fileName),
                            StandardCopyOption.REPLACE_EXISTING);
                }
            }

            // Création de l'objet Voiture
            Voiture v = new Voiture();
            v.setImmatriculation(immat);
            v.setMarque(marque);
            v.setModele(modele);
            v.setNbPlaces(nbPlaces);
            v.setDateMiseCirculation(dateMiseCirculation);
            v.setKilometrage(kilometrage);
            v.setCarburant(Voiture.Carburant.valueOf(carburantStr));
            v.setCategorie(Voiture.Categorie.valueOf(categorieStr));
            v.setPrixJour(prixJour);
            if (fileName != null) {
                v.setPhoto(fileName);
            }

            voitureService.ajouterVoiture(v);

            req.setAttribute("message", "Voiture ajoutée avec succès !");
            doGet(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Erreur lors de l'ajout de la voiture : " + e.getMessage());
            doGet(req, resp);
        }
    }

    @Override
    public void destroy() {
        if (voitureService != null) voitureService.fermer();
        super.destroy();
    }
}
   