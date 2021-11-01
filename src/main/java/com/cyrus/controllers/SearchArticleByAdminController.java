/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.constants.PageConstant;
import com.cyrus.daos.ArticleDAO;
import com.cyrus.daos.StatusArticleDAO;
import com.cyrus.dtos.ArticleDTO;
import com.cyrus.dtos.StatusArticleDTO;
import com.cyrus.utils.CalculatingPagingUtil;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;
import java.util.Objects;
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
@WebServlet(name = "SearchArticleByAdminController", urlPatterns = {"/SearchArticleByAdminController"})
public class SearchArticleByAdminController extends HttpServlet {

    private final static ArticleDAO dao = ArticleDAO.getInstance();
    private final static StatusArticleDAO statusDAO = StatusArticleDAO.getInstance();
    private final static Logger logger = Logger.getLogger(SearchArticleByAdminController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String txtPageNum;
            int pageNum = 0, numberRecords = 0;
            List<ArticleDTO> list = null;
            String search = request.getParameter("txtSearch");
            String status = request.getParameter("txtStatus");

            if (request.getParameter("page") != null) {
                pageNum = Integer.parseInt(request.getParameter("page"));
            }
            if (search == null) {
                search = "";
            }
            if (status == null || status.isBlank() || status.equals("")) { //không status || status == ""
                list = dao.searchArticleWithoutStatusByAdmin(search, pageNum);
                numberRecords = dao.getAllRecordsWithoutStatuByAdminSearching(search);
            } else { //có status
                list = dao.searchArticleWithStatusByAdmin(search, status, pageNum);
                numberRecords = dao.getAllRecordsWithStatusByAdminSearching(search, status);
            }
            int totalPageNum = CalculatingPagingUtil.totalPageNum(numberRecords, PageConstant.ARTICLE_PER_PAGE);
            List<StatusArticleDTO> statusList = statusDAO.getAllArticleStatusList();
            request.setAttribute("STATUS_LIST", statusList);
            if (list != null) {
                request.setAttribute("LIST", list);
                request.setAttribute("PAGE", totalPageNum);
                request.setAttribute("CUR_PAGE", pageNum);
            } else {
                request.setAttribute("ERROR", "Cannot find the article");
            }

        } catch (ClassNotFoundException | NumberFormatException | SQLException | ParseException | NamingException e) {
            e.printStackTrace();
            logger.error("Error SearchArticleByAdminController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("adminPage").forward(request, response);
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
