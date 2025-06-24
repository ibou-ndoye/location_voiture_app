package com.voitureapp.servlet;

import com.voitureapp.model.Gestionnaire;
import com.voitureapp.service.GestionnaireService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")      
public class LoginServlet extends HttpServlet {

    private final GestionnaireService gestionnaireService = new GestionnaireService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Gestionnaire user = gestionnaireService.authentifier(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("utilisateurConnecte", user);
            session.setAttribute("role", user.getRole());

            String role = user.getRole().name(); // Convert enum to String

            // Redirection basée sur le rôle
            if ("CHEF".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/gestionnaire/dashboard");
            } else if ("GESTIONNAIRE".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/gestionvoiture");
            } else {
                // Autre rôle inconnu — redirection par défaut
                response.sendRedirect(request.getContextPath() + "/");
            }

        } else {
            request.setAttribute("error", "Email ou mot de passe incorrect");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        gestionnaireService.fermer();
    }
}
