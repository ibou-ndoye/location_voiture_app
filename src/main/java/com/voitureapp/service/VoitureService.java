package com.voitureapp.service;

import com.voitureapp.dao.VoitureDAO;
import com.voitureapp.model.Voiture;

import java.util.List;

public class VoitureService {

    private final VoitureDAO voitureDAO = new VoitureDAO();

    public void ajouterVoiture(Voiture voiture) {
        voitureDAO.create(voiture);
    }

    public Voiture getVoitureById(String immatriculation) {
        return voitureDAO.findById(immatriculation);
    }

    public List<Voiture> getToutesLesVoitures() {
        return voitureDAO.findAll();
    }

    public List<Voiture> rechercher(String query, String marque) {
        return voitureDAO.rechercherParMotCleEtMarque(query, marque);
    }

    public List<String> listerMarquesDisponibles() {
        return voitureDAO.findDistinctMarques();
    }

    public void modifierVoiture(Voiture voiture) {
        voitureDAO.update(voiture);
    }

    public void supprimerVoiture(String immatriculation) {
        voitureDAO.delete(immatriculation);
    }
    

    public void fermer() {
        voitureDAO.close();
    }
    
}