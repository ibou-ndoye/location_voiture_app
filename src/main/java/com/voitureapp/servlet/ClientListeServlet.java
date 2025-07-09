package com.voitureapp.servlet;

import com.voitureapp.model.Client;
import com.voitureapp.model.Location;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/clientel")
public class ClientListeServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("locationPU");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        try {
            String action = request.getParameter("action");
            String idParam = request.getParameter("id");

            if ("supprimer".equals(action) && idParam != null && !idParam.trim().isEmpty()) {
                Long id = null;
                try {
                    id = Long.parseLong(idParam);
                } catch (NumberFormatException e) {
                    // id invalide, on peut rediriger vers liste avec erreur
                    response.sendRedirect(request.getContextPath() + "/clientel?erreur=invalidId");
                    return;
                }

                em.getTransaction().begin();

                Client client = em.find(Client.class, id);
                if (client == null) {
                    em.getTransaction().rollback();
                    response.sendRedirect(request.getContextPath() + "/clientel?erreur=clientNotFound");
                    return;
                }

                // Vérifier s'il existe une location liée à ce client
                List<Location> locations = em.createQuery(
                        "SELECT l FROM Location l WHERE l.client.idClient = :clientId", Location.class)
                        .setParameter("clientId", id)
                        .getResultList();

                if (!locations.isEmpty()) {
                    // Il y a des locations, suppression refusée
                    em.getTransaction().rollback();
                    response.sendRedirect(request.getContextPath() + "/clientel?erreur=clientHasLocations");
                    return;
                }

                // Pas de location, suppression possible
                em.remove(client);
                em.getTransaction().commit();
                response.sendRedirect(request.getContextPath() + "/clientel?success=delete");
                return;
            }

            // Sinon, affichage liste clients

            String recherche = request.getParameter("recherche");
            List<Client> clients;

            if (recherche != null && !recherche.trim().isEmpty()) {
                clients = em.createQuery(
                        "SELECT c FROM Client c WHERE LOWER(c.nom) LIKE :r OR LOWER(c.cin) LIKE :r", Client.class)
                        .setParameter("r", "%" + recherche.toLowerCase() + "%")
                        .getResultList();
                request.setAttribute("hasSearch", true);
            } else {
                clients = em.createQuery("SELECT c FROM Client c", Client.class).getResultList();
                request.setAttribute("hasSearch", false);
            }

            request.setAttribute("clients", clients);

            // Gérer les messages de succès/erreur pour suppression
            String success = request.getParameter("success");
            String erreur = request.getParameter("erreur");

            if ("delete".equals(success)) {
                request.setAttribute("messageSuccess", "Client supprimé avec succès.");
            }
            if ("clientHasLocations".equals(erreur)) {
                request.setAttribute("messageErreur", "Suppression impossible : le client a des locations en cours.");
            }
            if ("clientNotFound".equals(erreur)) {
                request.setAttribute("messageErreur", "Client introuvable.");
            }
            if ("invalidId".equals(erreur)) {
                request.setAttribute("messageErreur", "ID client invalide.");
            }

            request.getRequestDispatcher("/WEB-INF/views/clientel.jsp").forward(request, response);
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }
}
