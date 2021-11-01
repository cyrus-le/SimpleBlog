/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import com.cyrus.constants.PageConstant;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import com.cyrus.dtos.CommentDTO;
import com.cyrus.utils.DBHelper;

/**
 *
 * @author Cyrus
 */
public class CommentDAO implements ICRUDRepository<CommentDTO, String> {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static CommentDAO instance;

    public static CommentDAO getInstance() {
        if (instance == null) {
            instance = new CommentDAO();
        }
        return instance;
    }

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    @Override
    public boolean insert(CommentDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO Comment(ArticleID, Content, Email, Date) VALUES (?,?,?,?)";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, dto.getArticleID());
                preStm.setString(2, dto.getContent());
                preStm.setString(3, dto.getEmail());
                preStm.setDate(4, new java.sql.Date(new Date().getTime()));
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<CommentDTO> getAllCommentsByArticleID(int articleID, int pageNum) throws SQLException, ParseException, NamingException {
        String email, content;
        Date date;
        int commentID;
        CommentDTO dto;
        List<CommentDTO> result = null;
        try {
            String sql = "SELECT CommentID, ArticleID, Content, Email, Date FROM Comment WHERE ArticleID = ? "
                    + "ORDER BY Date DESC "
                    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, articleID);
                preStm.setInt(2, pageNum * PageConstant.COMMENT_PER_PAGE);
                preStm.setInt(3, PageConstant.COMMENT_PER_PAGE);
                rs = preStm.executeQuery();
                result = new ArrayList();
                while (rs.next()) {
                    commentID = rs.getInt("CommentID");
                    email = rs.getString("Email");
                    content = rs.getString("Content");
                    date = rs.getDate("Date");
                    dto = new CommentDTO(commentID, articleID, email, content, date);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public int getAllRecords(int articleID) throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM Comment WHERE ArticleID = ?";
        try {
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, articleID);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    numberRecord = rs.getInt(1);
                }
            }
        } finally {
            closeConnection();
        }

        return numberRecord;
    }

    @Override
    public boolean update(CommentDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public CommentDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean delete(CommentDTO k) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
