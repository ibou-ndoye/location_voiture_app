package com.voitureapp.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "voiture")
public class Voiture {

    @Id
    @Column(length = 20)
    private String immatriculation;

    @Column(name = "nb_places")
    private int nbPlaces;

    private String marque;

    private String modele;

    @Column(name = "date_mise_circulation")
    private LocalDate dateMiseCirculation;

    private int kilometrage;

    @Enumerated(EnumType.STRING)
    private Carburant carburant;

    @Enumerated(EnumType.STRING)
    private Categorie categorie;

    @Column(name = "prix_jour")
    private double prixJour;

    private boolean disponible = true;

    private String photo;

    public enum Carburant {
        Essence, Diesel, Hybride, Electrique
    }

    public enum Categorie {
        Economique, Confort, Luxe, SUV, Utilitaire
    }

    // Getters & setters

    public String getImmatriculation() {
        return immatriculation;
    }

    public void setImmatriculation(String immatriculation) {
        this.immatriculation = immatriculation;
    }

    public int getNbPlaces() {
        return nbPlaces;
    }

    public void setNbPlaces(int nbPlaces) {
        this.nbPlaces = nbPlaces;
    }

    public String getMarque() {
        return marque;
    }

    public void setMarque(String marque) {
        this.marque = marque;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public LocalDate getDateMiseCirculation() {
        return dateMiseCirculation;
    }

    public void setDateMiseCirculation(LocalDate dateMiseCirculation) {
        this.dateMiseCirculation = dateMiseCirculation;
    }

    public int getKilometrage() {
        return kilometrage;
    }

    public void setKilometrage(int kilometrage) {
        this.kilometrage = kilometrage;
    }

    public Carburant getCarburant() {
        return carburant;
    }

    public void setCarburant(Carburant carburant) {
        this.carburant = carburant;
    }

    public Categorie getCategorie() {
        return categorie;
    }

    public void setCategorie(Categorie categorie) {
        this.categorie = categorie;
    }

    public double getPrixJour() {
        return prixJour;
    }

    public void setPrixJour(double prixJour) {
        this.prixJour = prixJour;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }
}
