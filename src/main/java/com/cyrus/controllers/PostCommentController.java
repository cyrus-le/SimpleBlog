/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.daos.CommentDAO;
import com.cyrus.dtos.CommentDTO;
import com.cyrus.dtos.UserDTO;
import java.io.IOException;
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
@WebServlet(name = "PostCommentController", urlPatterns = {"/PostCommentController"})
public class PostCommentController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(PostCommentController.class);
    private final static CommentDAO dao = CommentDAO.getInstance();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String txtArticleID = request.getParameter("txtArticleID");
            int articleID = Integer.parseInt(txtArticleID);
            CommentDTO dto = new CommentDTO();
            UserDTO user = ((UserDTO) request.getSession().getAttribute("USER"));
            String content = request.getParameter("txtComment");
            String email = user.getEmail();
            dto.setArticleID(articleID);
            dto.setContent(content);
            dto.setEmail(email);
            dao.insert(dto);

        } catch (SQLException | NamingException e) {
            logger.error("Error CommentController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("ViewDetailController").forward(request, response);
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
