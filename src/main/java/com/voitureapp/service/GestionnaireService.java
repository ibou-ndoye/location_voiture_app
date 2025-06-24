package com.voitureapp.service;

import com.voitureapp.dao.GestionnaireDAO;
import com.voitureapp.model.Gestionnaire;

import java.util.List;

public class GestionnaireService {

    private GestionnaireDAO gestionnaireDAO = new GestionnaireDAO();

    // --- Authentification ---
    public Gestionnaire authentifier(String email, String motDePasse) {
        return gestionnaireDAO.trouverParEmailEtMotDePasse(email, motDePasse);
    }

    // --- CRUD Gestionnaires ---
    public void ajouterGestionnaire(Gestionnaire gestionnaire) {
        gestionnaireDAO.create(gestionnaire);
    }

    public Gestionnaire getGestionnaireById(int id) {
        return gestionnaireDAO.findById(id);
    }

    public List<Gestionnaire> getTousLesGestionnaires() {
        return gestionnaireDAO.findAll();
    }

    public void modifierGestionnaire(Gestionnaire gestionnaire) {
        gestionnaireDAO.update(gestionnaire);
    }

    public void supprimerGestionnaire(int id) {
        gestionnaireDAO.delete(id);
    }

    public void fermer() {
        gestionnaireDAO.close();
    }
}
