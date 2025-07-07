package com.voitureapp.service;

import com.voitureapp.model.Voiture;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String immatriculation = request.getParameter("immatriculation");
        String marque = request.getParameter("marque");
        String modele = request.getParameter("modele");
        int nbPlaces = Integer.parseInt(request.getParameter("nbPlaces"));
        LocalDate dateMiseCirculation = LocalDate.parse(request.getParameter("dateMiseCirculation"));
        int kilometrage = Integer.parseInt(request.getParameter("kilometrage"));
        String carburant = request.getParameter("carburant");
        String categorie = request.getParameter("categorie");
        double prixJour = Double.parseDouble(request.getParameter("prixJour"));
        boolean disponible = request.getParameter("disponible") != null;

        EntityManager em = emf.createEntityManager();

        try {
            Voiture voiture = em.find(Voiture.class, immatriculation);
            if (voiture == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Voiture non trouvée");
                return;
            }

            // Mettre à jour les champs
            em.getTransaction().begin();
            voiture.setMarque(marque);
            voiture.setModele(modele);
            voiture.setNbPlaces(nbPlaces);
            voiture.setDateMiseCirculation(dateMiseCirculation);
            voiture.setKilometrage(kilometrage);
          
            voiture.setPrixJour(prixJour);
            voiture.setDisponible(disponible);
            em.getTransaction().commit();

            // Redirection vers la liste des voitures
            response.sendRedirect(request.getContextPath() + "/voitures");

        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }
}
