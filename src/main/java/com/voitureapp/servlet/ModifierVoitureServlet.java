package com.voitureapp.servlet;



import com.voitureapp.model.Voiture;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/modifierVoiture")
public class ModifierVoitureServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() {
        emf = Persistence.createEntityManagerFactory("locationPU");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String immatriculation = req.getParameter("immatriculation");
        EntityManager em = emf.createEntityManager();
        try {
            Voiture voiture = em.find(Voiture.class, immatriculation);
            if (voiture == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Voiture non trouvée");
                return;
            }
            req.setAttribute("voiture", voiture);
            req.getRequestDispatcher("/WEB-INF/views/modifier_voiture.jsp").forward(req, resp);
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }
}
