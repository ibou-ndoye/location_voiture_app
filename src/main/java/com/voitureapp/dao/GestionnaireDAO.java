package com.voitureapp.dao;

import com.voitureapp.model.Gestionnaire;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class GestionnaireDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("locationPU");

    public void create(Gestionnaire gestionnaire) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(gestionnaire);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Gestionnaire findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Gestionnaire.class, id);
        } finally {
            em.close();
        }
    }

    public List<Gestionnaire> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Gestionnaire> query = em.createQuery("SELECT g FROM Gestionnaire g", Gestionnaire.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Gestionnaire gestionnaire) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(gestionnaire);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Gestionnaire gestionnaire = em.find(Gestionnaire.class, id);
            if (gestionnaire != null) {
                em.remove(gestionnaire);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // 💡 Méthode d'authentification (email + mot de passe)
    public Gestionnaire trouverParEmailEtMotDePasse(String email, String motDePasse) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Gestionnaire> query = em.createQuery(
                "SELECT g FROM Gestionnaire g WHERE g.email = :email AND g.motDePasse = :motDePasse",
                Gestionnaire.class
            );
            query.setParameter("email", email);
            query.setParameter("motDePasse", motDePasse);

            List<Gestionnaire> resultats = query.getResultList();
            return resultats.isEmpty() ? null : resultats.get(0);
        } finally {
            em.close();
        }
    }

    public void close() {
        emf.close();
    }
}
