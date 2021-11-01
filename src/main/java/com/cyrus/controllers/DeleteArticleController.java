/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.daos.ArticleDAO;
import com.cyrus.dtos.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "DeleteArticleController", urlPatterns = {"/DeleteArticleController"})
public class DeleteArticleController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(DeleteArticleController.class);
    private final static ArticleDAO dao = ArticleDAO.getInstance();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try {
            int page = 0;
            UserDTO user = ((UserDTO) request.getSession().getAttribute("USER"));
            String txtArticleID = request.getParameter("txtArticleID");
            if (user != null && user.getRole().equals("ADMIN")) {
                dao.delete(txtArticleID);
            }
            String search = request.getParameter("txtSearch");
            String txtPage = request.getParameter("page");
            if (!txtPage.isBlank() && txtPage != null) {
                page = Integer.parseInt(txtPage);
            }
        } catch (NumberFormatException | SQLException | NamingException e) {
            logger.error("Error DeleteArticleController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("searchArticleByAdmin").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
