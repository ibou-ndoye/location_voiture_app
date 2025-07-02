package com.voitureapp.servlet;

import com.voitureapp.model.Location;
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
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/gestionnaire/dashboard")
public class GestionnaireDashboardServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("locationPU");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            // Statistiques globales
            Long nbTotalVoitures = em.createQuery("SELECT COUNT(v) FROM Voiture v", Long.class).getSingleResult();
            Long nbVoituresEnLocation = em.createQuery(
            	    "SELECT COUNT(DISTINCT l.voiture) FROM Location l WHERE l.dateFinReelle IS NULL", Long.class
            	).getSingleResult();

            	Long nbVoituresDisponibles = em.createQuery(
            	    "SELECT COUNT(v) FROM Voiture v WHERE v.id NOT IN (" +
            	    "SELECT l.voiture.id FROM Location l WHERE l.dateFinReelle IS NULL" +
            	    ")", Long.class
            	).getSingleResult();

            // Locations actives
            List<Location> locationsActives = em.createQuery("SELECT l FROM Location l WHERE l.dateFinReelle IS NULL", Location.class).getResultList();
            LocalDateTime now = LocalDateTime.now();
            List<LocationAvecJoursRestants> locationsAvecJours = locationsActives.stream().map(l -> {
                long joursRestants = 0;
                if (l.getDateFinPrevue() != null) {
                    joursRestants = Duration.between(now, l.getDateFinPrevue()).toDays();
                    if (joursRestants < 0) joursRestants = 0;
                }
                return new LocationAvecJoursRestants(l, joursRestants);
            }).collect(Collectors.toList());

            // Liste des voitures
            List<Voiture> listeVoitures = em.createQuery("SELECT v FROM Voiture v", Voiture.class).getResultList();

            // Voitures disponibles
            List<Voiture> voituresDisponibles = em.createQuery("SELECT v FROM Voiture v WHERE v.disponible = true", Voiture.class).getResultList();

            // Voitures les plus populaires
            List<Object[]> voituresPopularite = em.createQuery(
                    "SELECT l.voiture, COUNT(l) FROM Location l GROUP BY l.voiture ORDER BY COUNT(l) DESC", Object[].class)
                    .setMaxResults(5).getResultList();

            // ✅ Bilan financier mensuel corrigé avec MONTHNAME pour affichage lisible
            List<Object[]> bilanMensuel = em.createQuery(
                    "SELECT FUNCTION('MONTHNAME', l.dateDebut), FUNCTION('YEAR', l.dateDebut), SUM(l.prixTotal) " +
                            "FROM Location l " +
                            "GROUP BY FUNCTION('YEAR', l.dateDebut), FUNCTION('MONTH', l.dateDebut), FUNCTION('MONTHNAME', l.dateDebut) " +
                            "ORDER BY FUNCTION('YEAR', l.dateDebut) DESC, FUNCTION('MONTH', l.dateDebut) DESC", Object[].class)
                    .getResultList();

            // Attributs envoyés à la JSP
            req.setAttribute("nbTotalVoitures", nbTotalVoitures);
            req.setAttribute("nbVoituresDisponibles", nbVoituresDisponibles);
            req.setAttribute("nbVoituresEnLocation", nbVoituresEnLocation);
            req.setAttribute("locationsActives", locationsAvecJours);
            req.setAttribute("listeVoitures", listeVoitures);
            req.setAttribute("voituresDisponibles", voituresDisponibles);
            req.setAttribute("voituresPopularite", voituresPopularite);
            req.setAttribute("bilanMensuel", bilanMensuel);

            req.getRequestDispatcher("/WEB-INF/views/gestionnaire_dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur serveur lors du chargement du tableau de bord.");
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

    // Classe interne pour ajouter les jours restants à une location
    public static class LocationAvecJoursRestants {
        private final Location location;
        private final long joursRestants;

        public LocationAvecJoursRestants(Location location, long joursRestants) {
            this.location = location;
            this.joursRestants = joursRestants;
        }

        public Location getLocation() {
            return location;
        }

        public long getJoursRestants() {
            return joursRestants;
        }

        public Voiture getVoiture() {
            return location.getVoiture();
        }

        public com.voitureapp.model.Client getClient() {
            return location.getClient();
        }

        public java.time.LocalDateTime getDateDebut() {
            return location.getDateDebut();
        }

        public java.time.LocalDateTime getDateFinPrevue() {
            return location.getDateFinPrevue();
        }
    }
}
