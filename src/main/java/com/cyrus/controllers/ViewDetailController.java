/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.constants.PageConstant;
import com.cyrus.daos.ArticleDAO;
import com.cyrus.daos.CommentDAO;
import com.cyrus.dtos.ArticleDTO;
import com.cyrus.dtos.CommentDTO;
import com.cyrus.dtos.UserDTO;
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
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@WebServlet(name = "ViewDetailController", urlPatterns = {"/ViewDetailController"})
public class ViewDetailController extends HttpServlet {

    private final static ArticleDAO articleDAO = ArticleDAO.getInstance();
    private final static CommentDAO commentDAO = CommentDAO.getInstance();
    private final static Logger logger = Logger.getLogger(ViewDetailController.class);
    private int articleID;

    private void viewArticle(final HttpServletRequest req) throws SQLException, NamingException, ParseException {
        ArticleDTO dto = articleDAO.get(articleID);
        HttpSession session = req.getSession(false);
        UserDTO user = (UserDTO) session.getAttribute("USER");
        if (user != null && user.getRole().equals("ADMIN")) {
            dto = articleDAO.getByAdmin(articleID);
        }
        req.setAttribute("ARTICLE_DTO", dto);
    }

    private void viewComments(final HttpServletRequest req) throws SQLException, ParseException, NamingException, ClassNotFoundException {
        int pageNum = 0, numberRecords = 0;
        if (req.getParameter("page") != null) {
            pageNum = Integer.parseInt(req.getParameter("page"));
        }
        numberRecords = commentDAO.getAllRecords(articleID);
        int totalPageNum = CalculatingPagingUtil.totalPageNum(numberRecords, PageConstant.COMMENT_PER_PAGE);
        List<CommentDTO> listComment = commentDAO.getAllCommentsByArticleID(articleID, pageNum);
        req.setAttribute("LIST_COMMENTS", listComment);
        req.setAttribute("PAGE", totalPageNum);
        req.setAttribute("CURPAGE", pageNum);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int txtArticleID = Integer.parseInt(request.getParameter("txtArticleID"));
            articleID = txtArticleID;
            viewArticle(request);
            viewComments(request);

        } catch (SQLException | NamingException | ParseException | ClassNotFoundException ex) {
            logger.error("Error ViewDetailController at: " + ex.getMessage());
        } finally {
            request.getRequestDispatcher("viewDetailPage").forward(request, response);
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
