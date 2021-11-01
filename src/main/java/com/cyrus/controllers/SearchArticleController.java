/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.constants.PageConstant;
import com.cyrus.daos.ArticleDAO;
import com.cyrus.dtos.ArticleDTO;
import com.cyrus.utils.CalculatingPagingUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
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
@WebServlet(name = "SearchArticleController", urlPatterns = {"/SearchArticleController"})
public class SearchArticleController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(SearchArticleController.class);
    private final static ArticleDAO dao = ArticleDAO.getInstance();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String search = request.getParameter("txtSearch");
        List<ArticleDTO> list = null;
        try {
            int pageNum = 0, numberRecords = 0;
            if (request.getParameter("page") != null) {
                pageNum = Integer.parseInt(request.getParameter("page"));
            }

            if (search == null) {
                search = "";
            }
            list = dao.findByLikeContent(search, pageNum);
            numberRecords = dao.getAllRecordsBySearching(search);

            int totalPageNum = CalculatingPagingUtil.totalPageNum(numberRecords, PageConstant.ARTICLE_PER_PAGE);
            if (list != null) {
                request.setAttribute("LIST", list);
                request.setAttribute("PAGE", totalPageNum);
                request.setAttribute("CURPAGE", pageNum);
            } else {
                request.setAttribute("ERROR", "Cannot find the article");
            }
        } catch (SQLException | NamingException | ParseException | ClassNotFoundException e) {
            logger.error("Error SearchArticlesController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("homePage").forward(request, response);
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
