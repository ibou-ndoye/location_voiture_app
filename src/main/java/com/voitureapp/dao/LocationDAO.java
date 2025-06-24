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
            TypedQuery<Location> query = em.createQuery("SELECT l FROM Location l", Location.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Location location) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(location);
            em.getTransaction().commit();
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
