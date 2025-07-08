package com.voitureapp.dao;

import com.voitureapp.model.Voiture;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class VoitureDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("locationPU");

    // ➤ Ajouter une voiture
    public void create(Voiture voiture) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(voiture);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // ➤ Trouver une voiture par immatriculation
    public Voiture findById(String immatriculation) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Voiture.class, immatriculation);
        } finally {
            em.close();
        }
    }
    
    // ➤ Compter le nombre total de voitures
    public int countAll() {
        EntityManager em = emf.createEntityManager();
        try {
            Long count = em.createQuery("SELECT COUNT(v) FROM Voiture v", Long.class)
                           .getSingleResult();
            return count.intValue();
        } finally {
            em.close();
        }
    }

    // ➤ Lister toutes les voitures
    public List<Voiture> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Voiture> query = em.createQuery("SELECT v FROM Voiture v", Voiture.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // ➤ Mettre à jour une voiture
    public void update(Voiture voiture) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(voiture);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // ➤ Supprimer une voiture
    public void delete(String immatriculation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Voiture voiture = em.find(Voiture.class, immatriculation);
            if (voiture != null) {
                em.remove(voiture);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
    
    
    public List<Voiture> getVoituresDisponibles() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Voiture> query = em.createQuery(
                "SELECT v FROM Voiture v WHERE v NOT IN " +
                "(SELECT l.voiture FROM Location l WHERE l.dateFinReelle IS NULL)",
                Voiture.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }


    // ➤ Rechercher voitures par mot-clé et marque
    public List<Voiture> rechercherVoitures(String marque, String carburant, String categorie, Integer annee, Integer kilometrageMax) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT v FROM Voiture v WHERE 1=1";

            if (marque != null && !marque.isEmpty()) {
                jpql += " AND LOWER(v.marque) LIKE LOWER(:marque)";
            }
            if (carburant != null && !carburant.isEmpty()) {
                jpql += " AND v.carburant = :carburant";
            }
            if (categorie != null && !categorie.isEmpty()) {
                jpql += " AND v.categorie = :categorie";
            }
            if (annee != null) {
                jpql += " AND FUNCTION('YEAR', v.dateMiseCirculation) = :annee";
            }
            if (kilometrageMax != null) {
                jpql += " AND v.kilometrage <= :kilometrageMax";
            }

            TypedQuery<Voiture> query = em.createQuery(jpql, Voiture.class);

            if (marque != null && !marque.isEmpty()) {
                query.setParameter("marque", "%" + marque + "%");
            }
            if (carburant != null && !carburant.isEmpty()) {
                try {
                    query.setParameter("carburant", Voiture.Carburant.valueOf(carburant));
                } catch (IllegalArgumentException e) {
                    // Si la valeur du carburant est invalide, ignorer le filtre
                }
            }
            if (categorie != null && !categorie.isEmpty()) {
                try {
                    query.setParameter("categorie", Voiture.Categorie.valueOf(categorie));
                } catch (IllegalArgumentException e) {
                    // Si la valeur de la catégorie est invalide, ignorer le filtre
                }
            }
            if (annee != null) {
                query.setParameter("annee", annee);
            }
            if (kilometrageMax != null) {
                query.setParameter("kilometrageMax", kilometrageMax);
            }

            return query.getResultList();
        } finally {
            em.close();
        }
    }


    // ➤ Lister toutes les marques distinctes
    public List<String> findDistinctMarques() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<String> query = em.createQuery(
                    "SELECT DISTINCT v.marque FROM Voiture v ORDER BY v.marque", String.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    // ➤ Fermer l'EntityManagerFactory
    public void close() {
        emf.close();
    }
}
