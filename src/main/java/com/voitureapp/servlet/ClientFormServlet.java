package com.voitureapp.servlet;

import com.voitureapp.model.Client;
import com.voitureapp.model.Location;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/clients", "/clients/modifier", "/clients/details"}) 
// NOTE : suppression retirée de cette servlet, gérer dans une autre servlet dédiée
public class ClientFormServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("locationPU");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        EntityManager em = emf.createEntityManager();

        try {
            switch (path) {
                case "/clients":
                    request.setAttribute("client", new Client());
                    request.setAttribute("clients", em.createQuery("SELECT c FROM Client c", Client.class).getResultList());
                    request.setAttribute("hasSearch", false);
                    request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
                    break;

                case "/clients/modifier":
                    String idParam = request.getParameter("id");
                    if (idParam == null || idParam.trim().isEmpty()) {
                        response.sendRedirect(request.getContextPath() + "/clients");
                        return;
                    }
                    Long idMod = Long.parseLong(idParam);
                    Client clientMod = em.find(Client.class, idMod);
                    if (clientMod == null) {
                        // Client non trouvé, rediriger vers la liste avec message
                        request.setAttribute("messageErreur", "Client introuvable pour modification.");
                        request.setAttribute("client", new Client());
                    } else {
                        request.setAttribute("client", clientMod);
                    }
                    request.setAttribute("clients", em.createQuery("SELECT c FROM Client c", Client.class).getResultList());
                    request.setAttribute("hasSearch", true);
                    request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
                    break;

                case "/clients/details":
                    String idDetailParam = request.getParameter("id");
                    if (idDetailParam == null || idDetailParam.trim().isEmpty()) {
                        response.sendRedirect(request.getContextPath() + "/clients");
                        return;
                    }
                    Long idDetail = Long.parseLong(idDetailParam);
                    Client clientDetail = em.find(Client.class, idDetail);
                    if (clientDetail == null) {
                        response.sendRedirect(request.getContextPath() + "/clients");
                        return;
                    }
                    List<Location> locations = em.createQuery("SELECT l FROM Location l WHERE l.client.idClient = :id", Location.class)
                            .setParameter("id", idDetail)
                            .getResultList();
                    request.setAttribute("client", clientDetail);
                    request.setAttribute("locations", locations);
                    request.getRequestDispatcher("/WEB-INF/views/details.jsp").forward(request, response);
                    break;

                default:
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } finally {
            em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        String idClientStr = request.getParameter("idClient");
        Long id = null;

        try {
            // On considère id = null si absent, vide, ou 0 (pas modif)
            if (idClientStr != null && !idClientStr.trim().isEmpty() && !idClientStr.trim().equals("0")) {
                id = Long.parseLong(idClientStr.trim());
            }
        } catch (NumberFormatException e) {
            id = null;
        }

        System.out.println("idClient reçu : '" + idClientStr + "', parsé en Long: " + id);

        try {
            Client client;

            if (id != null) {
                client = em.find(Client.class, id);
                if (client == null) {
                    request.setAttribute("messageErreur", "Client introuvable pour la modification.");
                    request.setAttribute("client", new Client());
                    request.setAttribute("clients", em.createQuery("SELECT c FROM Client c", Client.class).getResultList());
                    request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
                    return;
                }
            } else {
                client = new Client();
            }

            // Remplissage des champs du client
            client.setCin(request.getParameter("cin"));
            client.setPrenom(request.getParameter("prenom"));
            client.setNom(request.getParameter("nom"));
            client.setSexe(Client.Sexe.valueOf(request.getParameter("sexe")));
            client.setAdresse(request.getParameter("adresse"));
            client.setEmail(request.getParameter("email"));
            client.setTelephone(request.getParameter("telephone"));

            em.getTransaction().begin();
            if (id == null) {
                em.persist(client);
            } else {
                em.merge(client);
            }
            em.getTransaction().commit();

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("messageErreur", "Erreur lors de l'enregistrement du client.");
            request.setAttribute("client", new Client());
            request.setAttribute("clients", em.createQuery("SELECT c FROM Client c", Client.class).getResultList());
            request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
            return;
        } finally {
            em.close();
        }

        response.sendRedirect(request.getContextPath() + "/clients");
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }
}
