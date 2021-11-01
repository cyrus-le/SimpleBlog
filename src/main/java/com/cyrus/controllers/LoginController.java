/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.daos.UserDAO;
import com.cyrus.dtos.UserDTO;
import com.cyrus.dtos.UserErrorObj;
import com.cyrus.utils.EncryptUtil;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(LoginController.class);
    private static final UserDAO dao = UserDAO.getInstance();
    private static final String ERROR = "loginPage";
    private static final String MEMBER = "searchArticle";
    private final static String ADMIN = "searchArticleByAdmin";

    private static final UserErrorObj errorObj = new UserErrorObj();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String encryptedPassword = EncryptUtil.encryptPassword(password);
            UserDTO dto = dao.checkLogin(email, encryptedPassword);
            if (dto == null) {
                errorObj.setNotExistedError("Couldn't find your account or your account is not authentiacated");
                request.setAttribute("ERROR", errorObj);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("USER", dto);
                session.setAttribute("NAME", dto.getName());
                String role = dto.getRole();
                if (role.equals("MEMBER")) {
                    url = MEMBER;
                } else if (role.equals("ADMIN")) {
                    url = ADMIN;
                }
            }
            request.setAttribute("ERROR", errorObj);
        } catch (Exception e) {
            logger.error("Error LoginController at: " + e.getMessage());
            e.printStackTrace();
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
