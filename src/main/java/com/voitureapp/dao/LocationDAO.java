package com.voitureapp.dao;

import com.voitureapp.model.Location;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class LocationDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("locationPU");

    public void create(Location location) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(location);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Location findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Location.class, id);
        } finally {
            em.close();
        }
    }

    public List<Location> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Location> query = em.createQuery(
                "SELECT l FROM Location l " +
                "JOIN FETCH l.client " +
                "JOIN FETCH l.voiture " +
                "JOIN FETCH l.gestionnaire",
                Location.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }


    public void update(Location location) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            // Mise à jour de la location
            em.merge(location);

            // Mise à jour explicite de la voiture liée (pour que la modif du champ 'disponible' soit prise en compte)
            if (location.getVoiture() != null) {
                em.merge(location.getVoiture());
            }

            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    
    public Location findByIdAvecDetails(int idLocation) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery(
                "SELECT l FROM Location l " +
                "JOIN FETCH l.client " +
                "JOIN FETCH l.voiture " +
                "JOIN FETCH l.gestionnaire " +
                "WHERE l.idLocation = :id", Location.class)
                .setParameter("id", idLocation)
                .getSingleResult();
        } finally {
            em.close();
        }
    }

    public List<Location> getVoituresEnLocation() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Location> query = em.createQuery(
                "SELECT l FROM Location l " +
                "JOIN FETCH l.voiture v " +
                "JOIN FETCH l.client c " +
                "WHERE l.dateFinReelle IS NULL",
                Location.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }



    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Location location = em.find(Location.class, id);
            if (location != null) {
                em.remove(location);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void close() {
        emf.close();
    }
}
