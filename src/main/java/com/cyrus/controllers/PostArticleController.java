/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.daos.ArticleDAO;
import com.cyrus.dtos.ArticleDTO;
import com.cyrus.dtos.ArticleErrorObj;
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
@WebServlet(name = "PostArticleController", urlPatterns = {"/PostArticleController"})
public class PostArticleController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(PostArticleController.class);
    private final static ArticleDAO dao = ArticleDAO.getInstance();
    private static final ArticleErrorObj errorObj = new ArticleErrorObj();
    private String email;

    private boolean validateTitle(final HttpServletRequest req) {
        boolean check = false;
        String title = req.getParameter("txtTitle");
        if (title == null || title.isBlank()) {
            errorObj.setTitleError("Title cannot be blank");
            req.setAttribute("ARTICLE_ERROR", errorObj.getTitleError());

        } else {
            check = true;
        }
        return check;
    }

    private boolean validateShortDescription(final HttpServletRequest req) {
        boolean check = false;
        String description = req.getParameter("txtShortDescription");
        if (description == null || description.isBlank()) {
            errorObj.setShortDescriptionError("Short Description cannot be blank");
            req.setAttribute("ARTICLE_ERROR", errorObj.getShortDescriptionError());
        } else {
            check = true;
        }
        return check;
    }

    private boolean validateContent(final HttpServletRequest req) {
        boolean check = false;
        String content = req.getParameter("txtContent");
        if (content == null || content.isBlank()) {
            errorObj.setContentError("Don't let the content blank");
            req.setAttribute("ARTICLE_ERROR", errorObj.getContentError());
        } else {
            check = true;
        }
        return check;
    }

    private boolean checkValidate(final HttpServletRequest req) throws IOException, ServletException {
        return validateTitle(req) && validateShortDescription(req) && validateContent(req);
    }

    private void callInsert(final HttpServletRequest req) throws SQLException, NamingException {
        ArticleDTO dto = new ArticleDTO();
        dto.setTitle(req.getParameter("txtTitle"));
        dto.setShortDescription(req.getParameter("txtShortDescription"));
        dto.setContent(req.getParameter("txtContent"));
        dto.setEmail(email);
        dao.insert(dto);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        UserDTO dto = ((UserDTO) request.getSession().getAttribute("USER"));
        email = dto.getEmail();
        try {
            if (checkValidate(request)) {
                callInsert(request);
            } else {
                request.setAttribute("ARTICLE_ERROR", errorObj);
            }
        } catch (IOException | SQLException | NamingException | ServletException e) {
            logger.error("Error PostArticleController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("searchArticle").forward(request, response);
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
