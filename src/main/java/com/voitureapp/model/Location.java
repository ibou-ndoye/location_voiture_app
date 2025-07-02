package com.voitureapp.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "location")
public class Location {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_location")
    private int idLocation;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_client", nullable = false)
    private Client client;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "immatriculation", nullable = false)
    private Voiture voiture;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_gestionnaire", nullable = false)
    private Gestionnaire gestionnaire;

    @Column(name = "date_debut", nullable = false)
    private LocalDateTime dateDebut;

    @Column(name = "date_fin_prevue", nullable = false)
    private LocalDateTime dateFinPrevue;

    @Column(name = "date_fin_reelle")
    private LocalDateTime dateFinReelle;

    @Column(name = "prix_total", nullable = false)
    private double prixTotal;

    @Column(name = "kilometrage_depart", nullable = false)
    private int kilometrageDepart;

    @Column(name = "kilometrage_retour")
    private Integer kilometrageRetour;

    @Column(name = "signe_client", nullable = false)
    private boolean signeClient = false;

    @Column(name = "signe_gestionnaire", nullable = false)
    private boolean signeGestionnaire = false;

    @Transient
    private String dateDebutFormatee;

    @Transient
    private String dateFinPrevueFormatee;

    @Transient
    private String dateFinReelleFormatee;

    // Méthode pour formatter toutes les dates
    public void formaterDates() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        this.dateDebutFormatee = (dateDebut != null) ? dateDebut.format(formatter) : "";
        this.dateFinPrevueFormatee = (dateFinPrevue != null) ? dateFinPrevue.format(formatter) : "";
        this.dateFinReelleFormatee = (dateFinReelle != null) ? dateFinReelle.format(formatter) : "";
    }

    // Getters et setters classiques

    public int getIdLocation() {
        return idLocation;
    }

    public void setIdLocation(int idLocation) {
        this.idLocation = idLocation;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Voiture getVoiture() {
        return voiture;
    }

    public void setVoiture(Voiture voiture) {
        this.voiture = voiture;
    }

    public Gestionnaire getGestionnaire() {
        return gestionnaire;
    }

    public void setGestionnaire(Gestionnaire gestionnaire) {
        this.gestionnaire = gestionnaire;
    }

    public LocalDateTime getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(LocalDateTime dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDateTime getDateFinPrevue() {
        return dateFinPrevue;
    }

    public void setDateFinPrevue(LocalDateTime dateFinPrevue) {
        this.dateFinPrevue = dateFinPrevue;
    }

    public LocalDateTime getDateFinReelle() {
        return dateFinReelle;
    }

    public void setDateFinReelle(LocalDateTime dateFinReelle) {
        this.dateFinReelle = dateFinReelle;
    }

    public double getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(double prixTotal) {
        this.prixTotal = prixTotal;
    }

    public int getKilometrageDepart() {
        return kilometrageDepart;
    }

    public void setKilometrageDepart(int kilometrageDepart) {
        this.kilometrageDepart = kilometrageDepart;
    }

    public Integer getKilometrageRetour() {
        return kilometrageRetour;
    }

    public void setKilometrageRetour(Integer kilometrageRetour) {
        this.kilometrageRetour = kilometrageRetour;
    }

    public boolean isSigneClient() {
        return signeClient;
    }

    public void setSigneClient(boolean signeClient) {
        this.signeClient = signeClient;
    }

    public boolean isSigneGestionnaire() {
        return signeGestionnaire;
    }

    public void setSigneGestionnaire(boolean signeGestionnaire) {
        this.signeGestionnaire = signeGestionnaire;
    }

    public String getDateDebutFormatee() {
        return dateDebutFormatee;
    }

    public String getDateFinPrevueFormatee() {
        return dateFinPrevueFormatee;
    }

    public String getDateFinReelleFormatee() {
        return dateFinReelleFormatee;
    }
}
