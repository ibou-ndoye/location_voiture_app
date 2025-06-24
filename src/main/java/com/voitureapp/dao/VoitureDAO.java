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

    // ➤ Rechercher voitures par mot-clé et marque
    public List<Voiture> rechercherParMotCleEtMarque(String query, String marque) {
        EntityManager em = emf.createEntityManager();
        try {
            String jpql = "SELECT v FROM Voiture v WHERE 1=1";

            if (query != null && !query.trim().isEmpty()) {
                jpql += " AND (LOWER(v.modele) LIKE :query OR LOWER(v.immatriculation) LIKE :query OR LOWER(v.marque) LIKE :query)";
            }

            if (marque != null && !marque.equalsIgnoreCase("ALL") && !marque.trim().isEmpty()) {
                jpql += " AND LOWER(v.marque) = :marque";
            }

            TypedQuery<Voiture> q = em.createQuery(jpql, Voiture.class);

            if (query != null && !query.trim().isEmpty()) {
                q.setParameter("query", "%" + query.toLowerCase() + "%");
            }

            if (marque != null && !marque.equalsIgnoreCase("ALL") && !marque.trim().isEmpty()) {
                q.setParameter("marque", marque.toLowerCase());
            }

            return q.getResultList();
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
