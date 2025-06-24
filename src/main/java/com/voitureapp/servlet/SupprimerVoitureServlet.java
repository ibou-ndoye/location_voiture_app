package com.voitureapp.servlet;
import com.voitureapp.service.VoitureService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/supprimerVoiture")
public class SupprimerVoitureServlet extends HttpServlet {

    private VoitureService voitureService;

    @Override
    public void init() {
        voitureService = new VoitureService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String immat = req.getParameter("immatriculation");

        if (immat != null && !immat.trim().isEmpty()) {
            try {
                voitureService.supprimerVoiture(immat);
                req.getSession().setAttribute("message", "Voiture supprimée avec succès !");
            } catch (Exception e) {
                req.getSession().setAttribute("error", "Erreur lors de la suppression : " + e.getMessage());
            }
        } else {
            req.getSession().setAttribute("error", "Immatriculation manquante pour la suppression.");
        }

        resp.sendRedirect(req.getContextPath() + "/gestionvoiture");
    }

    @Override
    public void destroy() {
        voitureService.fermer();
    }
}
