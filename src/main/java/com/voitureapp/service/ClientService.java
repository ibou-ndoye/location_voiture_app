package com.voitureapp.service;

import com.voitureapp.dao.ClientDAO;
import com.voitureapp.model.Client;

import java.util.List;

public class ClientService {

    private ClientDAO clientDAO = new ClientDAO();

    public void ajouterClient(Client client) {
        // ici on pourrait ajouter des validations avant l'insertion
        clientDAO.create(client);
    }

    public Client getClientById(int id) {
        return clientDAO.findById(id);
    }

    public List<Client> getTousLesClients() {
        return clientDAO.findAll();
    }

    public void modifierClient(Client client) {
        clientDAO.update(client);
    }

    public void supprimerClient(int id) {
        clientDAO.delete(id);
    }

    public void fermer() {
        clientDAO.close();
    }
}
