package com.voitureapp.dao;

import com.voitureapp.model.Client;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ClientDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("locationPU");

    public void create(Client client) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(client);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Client findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Client.class, id);
        } finally {
            em.close();
        }
    }

    public List<Client> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Client> query = em.createQuery("SELECT c FROM Client c", Client.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Client client) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(client);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Client client = em.find(Client.class, id);
            if (client != null) {
                em.remove(client);
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
