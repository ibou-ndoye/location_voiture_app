package com.voitureapp.servlet;

import com.voitureapp.model.Client;
import com.voitureapp.model.Location;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ClientServlet", urlPatterns = {"/clients", "/clients/modifier", "/clients/supprimer", "/clients/details"})
public class ClientServlet extends HttpServlet {
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
                    String recherche = request.getParameter("recherche");
                    List<Client> clients;
                    if (recherche != null && !recherche.isEmpty()) {
                        clients = em.createQuery("SELECT c FROM Client c WHERE LOWER(c.nom) LIKE :r OR LOWER(c.cin) LIKE :r", Client.class)
                                .setParameter("r", "%" + recherche.toLowerCase() + "%")
                                .getResultList();
                        request.setAttribute("hasSearch", true);
                    } else {
                        clients = em.createQuery("SELECT c FROM Client c", Client.class).getResultList();
                        request.setAttribute("hasSearch", false);
                    }
                    request.setAttribute("clients", clients);
                    request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
                    break;

                case "/clients/modifier":
                    Long id = Long.parseLong(request.getParameter("id"));
                    Client client = em.find(Client.class, id);
                    request.setAttribute("client", client);
                    List<Client> allClients = em.createQuery("SELECT c FROM Client c", Client.class).getResultList();
                    request.setAttribute("clients", allClients);
                    request.setAttribute("hasSearch", true);
                    request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
                    break;

                case "/clients/supprimer":
                    Long idToDelete = Long.parseLong(request.getParameter("id"));
                    em.getTransaction().begin();
                    Client clientToDelete = em.find(Client.class, idToDelete);
                    if (clientToDelete != null) {
                        List<Location> locs = em.createQuery("SELECT l FROM Location l WHERE l.client.idClient = :id", Location.class)
                                .setParameter("id", idToDelete)
                                .getResultList();
                        if (locs.isEmpty()) {
                            em.remove(clientToDelete);
                            em.getTransaction().commit();
                            response.sendRedirect(request.getContextPath() + "/clients");
                        } else {
                            em.getTransaction().rollback();
                            request.setAttribute("messageErreur", "Ce client a des locations et ne peut pas être supprimé.");
                            request.setAttribute("client", new Client());
                            request.setAttribute("clients", em.createQuery("SELECT c FROM Client c", Client.class).getResultList());
                            request.setAttribute("hasSearch", true);
                            request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
                        }
                    } else {
                        em.getTransaction().rollback();
                        response.sendRedirect(request.getContextPath() + "/clients");
                    }
                    break;

                case "/clients/details":
                    Long idDetails = Long.parseLong(request.getParameter("id"));
                    Client cl = em.find(Client.class, idDetails);
                    List<Location> locations = em.createQuery("SELECT l FROM Location l WHERE l.client.idClient = :id", Location.class)
                            .setParameter("id", idDetails)
                            .getResultList();
                    request.setAttribute("client", cl);
                    request.setAttribute("locations", locations);
                    request.getRequestDispatcher("/WEB-INF/views/details.jsp").forward(request, response);
                    break;
            }
        } finally {
            em.close();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();
        try {
            Long id = request.getParameter("idClient") != null && !request.getParameter("idClient").isEmpty()
                    ? Long.parseLong(request.getParameter("idClient")) : null;

            Client client = (id != null) ? em.find(Client.class, id) : new Client();

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
