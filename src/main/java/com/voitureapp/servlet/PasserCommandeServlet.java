package com.voitureapp.servlet;

import com.voitureapp.model.Client;
import com.voitureapp.model.Voiture;
import com.voitureapp.model.Gestionnaire;
import com.voitureapp.model.Location;
import com.voitureapp.service.ClientService;
import com.voitureapp.service.VoitureService;
import com.voitureapp.service.ServiceLocation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/passerCommande")
public class PasserCommandeServlet extends HttpServlet {

    private ClientService clientService;
    private VoitureService voitureService;
    private ServiceLocation locationService;

    @Override
    public void init() {
        clientService = new ClientService();
        voitureService = new VoitureService();
        locationService = new ServiceLocation();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Client> clients = clientService.getTousLesClients();
        List<Voiture> voituresDisponibles = voitureService.getVoituresDisponibles();


        HttpSession session = request.getSession();
        Gestionnaire gestionnaire = (Gestionnaire) session.getAttribute("utilisateurConnecte");

        request.setAttribute("clients", clients);
        request.setAttribute("voituresDisponibles", voituresDisponibles);
        request.setAttribute("utilisateurConnecte", gestionnaire);

        request.getRequestDispatcher("/WEB-INF/views/passerCommande.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int idClient = Integer.parseInt(request.getParameter("id_client"));
            String immatriculation = request.getParameter("immatriculation");
            int idGestionnaire = Integer.parseInt(request.getParameter("id_gestionnaire"));

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate dateDebut = LocalDate.parse(request.getParameter("date_debut"), formatter);
            LocalDate dateFinPrevue = LocalDate.parse(request.getParameter("date_fin_prevue"), formatter);

            double prixTotal = Double.parseDouble(request.getParameter("prix_total"));
            int kmDepart = Integer.parseInt(request.getParameter("kilometrage_depart"));

            Client client = clientService.getClientById(idClient);
            Voiture voiture = voitureService.getVoitureById(immatriculation);
            Gestionnaire gestionnaire = new Gestionnaire();
            gestionnaire.setIdGestionnaire(idGestionnaire);

            Location location = new Location();
            location.setClient(client);
            location.setVoiture(voiture);
            location.setGestionnaire(gestionnaire);
            location.setDateDebut(dateDebut.atStartOfDay());
            location.setDateFinPrevue(dateFinPrevue.atStartOfDay());
            location.setPrixTotal(prixTotal);
            location.setKilometrageDepart(kmDepart);
            location.setSigneClient(false);
            location.setSigneGestionnaire(false);

            locationService.ajouterLocation(location);

            // ✅ Redirection vers la page facture avec ID de la location
            response.sendRedirect(request.getContextPath() + "/facture?id=" + location.getIdLocation());

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erreur", "Erreur lors de la création de la commande.");
            doGet(request, response);
        }
    }
}
