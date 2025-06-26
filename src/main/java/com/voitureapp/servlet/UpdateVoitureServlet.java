package com.voitureapp.servlet;

import com.voitureapp.model.Voiture;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/updateVoiture")
public class UpdateVoitureServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("locationPU");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String immatriculation = req.getParameter("immatriculation");

        if (immatriculation == null || immatriculation.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "L'immatriculation est requise.");
            return;
        }

        EntityManager em = emf.createEntityManager();
        try {
            Voiture voiture = em.find(Voiture.class, immatriculation);

            if (voiture == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Voiture introuvable.");
                return;
            }

            // Récupération des données du formulaire
            String marque = req.getParameter("marque");
            String modele = req.getParameter("modele");
            String carburantStr = req.getParameter("carburant");
            String categorieStr = req.getParameter("categorie");
            String dateStr = req.getParameter("dateMiseCirculation");
            String kmStr = req.getParameter("kilometrage");
            String prixStr = req.getParameter("prixJour");

            // Mise à jour des champs
            voiture.setMarque(marque);
            voiture.setModele(modele);
            voiture.setCarburant(Carburant.valueOf(carburantStr));
            voiture.setCategorie(Categorie.valueOf(categorieStr));
            voiture.setDateMiseCirculation(LocalDate.parse(dateStr));
            voiture.setKilometrage(Integer.parseInt(kmStr));
            voiture.setPrixJour(Double.parseDouble(prixStr));

            em.getTransaction().begin();
            em.merge(voiture);
            em.getTransaction().commit();

            // Redirection vers la page de gestion
            resp.sendRedirect(req.getContextPath() + "/gestionvoiture");

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors de la mise à jour.");
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
