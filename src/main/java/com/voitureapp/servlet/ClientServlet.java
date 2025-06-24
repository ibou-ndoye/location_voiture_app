package com.voitureapp.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.voitureapp.model.Client;
import com.voitureapp.service.ClientService;

@WebServlet("/clients")
public class ClientServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private ClientService clientService;

    @Override
    public void init() throws ServletException {
        super.init();
        clientService = new ClientService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer la liste des clients et l’envoyer à la JSP
        List<Client> clients = clientService.getTousLesClients();
        request.setAttribute("clients", clients);
        request.getRequestDispatcher("/WEB-INF/views/clientList.jsp").forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupération des données du formulaire
        String cin = request.getParameter("cin");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String sexe = request.getParameter("sexe");
        String adresse = request.getParameter("adresse");
        String email = request.getParameter("email");
        String telephone = request.getParameter("telephone");

        // Création du client
        Client client = new Client();
        client.setCin(cin);
        client.setPrenom(prenom);
        client.setNom(nom);
        client.setSexe(Client.Sexe.valueOf(sexe));
        client.setAdresse(adresse);
        client.setEmail(email);
        client.setTelephone(telephone);

        // Enregistrement en base
        clientService.ajouterClient(client);

        // Redirection vers la liste mise à jour
        response.sendRedirect(request.getContextPath() + "/clients");
    }

    @Override
    public void destroy() {
        clientService.fermer(); // Fermer EntityManagerFactory ou toute autre ressource
    }
}
