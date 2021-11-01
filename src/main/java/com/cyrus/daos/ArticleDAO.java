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

import com.cyrus.utils.DBHelper;
import com.cyrus.dtos.ArticleDTO;

/**
 *
 * @author Cyrus
 */
public class ArticleDAO implements ICRUDRepository<ArticleDTO, String> {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static ArticleDAO instance;

    public static ArticleDAO getInstance() {
        if (instance == null) {
            instance = new ArticleDAO();
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

    //guest + member
    public List<ArticleDTO> findByLikeContent(String search, int pageNum) throws NamingException, SQLException, ParseException, NumberFormatException {
        List<ArticleDTO> result = null;
        int articleID, countComment;
        String title, shortDescription, content, email, status;
        Date postingDate;
        ArticleDTO dto;
        try {
            String sql = "SELECT Article.ArticleID, Article.Title, Article.ShortDescription, Article.Content, "
                    + "Article.Email, Article.PostingDate, StatusArticle.StatusName AS Status, "
                    + "COUNT(Comment.ArticleID) AS CommentCount "
                    + "FROM Article FULL OUTER JOIN Comment ON Article.ArticleID = Comment.ArticleID "
                    + "FULL OUTER JOIN StatusArticle ON Article.Status = StatusArticle.StatusID "
                    + "WHERE Article.Content LIKE ? AND Article.Status = ? "
                    + "GROUP BY Article.ArticleID, Article.Title, Article.ShortDescription, Article.Content, "
                    + "Article.Email, Article.PostingDate, StatusArticle.StatusName "
                    + "ORDER BY Article.PostingDate DESC "
                    + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
                preStm.setString(2, "ACTIVE_ARTICLE");
                preStm.setInt(3, pageNum * PageConstant.ARTICLE_PER_PAGE);
                preStm.setInt(4, PageConstant.ARTICLE_PER_PAGE);
                rs = preStm.executeQuery();
                result = new ArrayList();
                while (rs.next()) {
                    articleID = rs.getInt("ArticleID");
                    title = rs.getString("Title");
                    shortDescription = rs.getString("ShortDescription");
                    content = rs.getString("Content");
                    email = rs.getString("Email");
                    postingDate = rs.getDate("PostingDate");
                    status = rs.getString("Status");
                    countComment = rs.getInt("CommentCount");
                    dto = new ArticleDTO(articleID, title, shortDescription, content, email, null, postingDate, status, countComment);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    //admin + ko status
    public List<ArticleDTO> searchArticleWithoutStatusByAdmin(String search, int pageNum) throws NamingException, SQLException, ParseException, NumberFormatException {
        List<ArticleDTO> result = null;
        int articleID;
        String title, shortDescription, content, email, status;
        Date postingDate, creatingDate;
        ArticleDTO dto;
        try {
            conn = DBHelper.getConnection();
            if (conn != null) {
                String sql = "SELECT Article.ArticleID, Article.Title, "
                        + "Article.ShortDescription, Article.Content, "
                        + "Article.Email, Article.CreatingDate, Article.PostingDate, StatusArticle.StatusName AS Status "
                        + "FROM Article "
                        + "FULL OUTER JOIN StatusArticle ON Article.Status = StatusArticle.StatusID "
                        + "WHERE Article.Content LIKE ? OR Article.Title LIKE ? "
                        + "GROUP BY Article.ArticleID, Article.Title, Article.ShortDescription, Article.Content, "
                        + "Article.Email,  Article.CreatingDate, Article.PostingDate, StatusArticle.StatusName "
                        + "ORDER BY Article.CreatingDate DESC "
                        + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
                preStm.setString(2, "%" + search + "%");
                preStm.setInt(3, pageNum * PageConstant.ARTICLE_PER_PAGE);
                preStm.setInt(4, PageConstant.ARTICLE_PER_PAGE);
                rs = preStm.executeQuery();
                result = new ArrayList();
                while (rs.next()) {
                    articleID = rs.getInt("ArticleID");
                    title = rs.getString("Title");
                    shortDescription = rs.getString("ShortDescription");
                    content = rs.getString("Content");
                    email = rs.getString("Email");
                    creatingDate = rs.getDate("CreatingDate");
                    postingDate = rs.getDate("PostingDate");
                    status = rs.getString("Status");
                    dto = new ArticleDTO(articleID, title, shortDescription, content, email, creatingDate, postingDate, status);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    //admin + kèm status
    public List<ArticleDTO> searchArticleWithStatusByAdmin(String search, String status, int pageNum) throws SQLException, NamingException {
        List<ArticleDTO> result = null;
        int articleID;
        String title, shortDescription, content, email;
        Date postingDate, creatingDate;
        ArticleDTO dto;
        conn = DBHelper.getConnection();
        try {
            if (conn != null) {
                String sql = "SELECT Article.ArticleID, Article.Title, "
                        + "Article.ShortDescription, Article.Content, "
                        + "Article.Email, Article.CreatingDate, Article.PostingDate, StatusArticle.StatusName AS Status "
                        + "FROM Article "
                        + "FULL OUTER JOIN StatusArticle ON Article.Status = StatusArticle.StatusID "
                        + "WHERE (Article.Content LIKE ? OR Article.Title LIKE ?) AND Article.Status = ? "
                        + "GROUP BY Article.ArticleID, Article.Title, Article.ShortDescription, Article.Content, "
                        + "Article.Email, Article.CreatingDate, Article.PostingDate, StatusArticle.StatusName "
                        + "ORDER BY Article.CreatingDate DESC "
                        + "OFFSET ? ROWS FETCH FIRST ? ROWS ONLY";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
                preStm.setString(2, "%" + search + "%");
                preStm.setString(3, status);
                preStm.setInt(4, pageNum * PageConstant.ARTICLE_PER_PAGE);
                preStm.setInt(5, PageConstant.ARTICLE_PER_PAGE);
                rs = preStm.executeQuery();
                result = new ArrayList();
                while (rs.next()) {
                    articleID = rs.getInt("ArticleID");
                    title = rs.getString("Title");
                    shortDescription = rs.getString("ShortDescription");
                    content = rs.getString("Content");
                    email = rs.getString("Email");
                    creatingDate = rs.getDate("CreatingDate");
                    postingDate = rs.getDate("PostingDate");
                    status = rs.getString("Status");
                    dto = new ArticleDTO(articleID, title, shortDescription, content, email, creatingDate, postingDate, status);
                    result.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    //guest + member
    public int getAllRecordsBySearching(String search) throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM Article "
                + "WHERE [Content] LIKE ? "
                + "AND [Status] = ?";
        try {
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
                preStm.setString(2, "ACTIVE_ARTICLE");
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

    //admin không kèm status
    public int getAllRecordsWithoutStatuByAdminSearching(String search) throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM Article "
                + "WHERE Content LIKE ?";
        try {
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
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

    //admin kèm status
    public int getAllRecordsWithStatusByAdminSearching(String search, String status) throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM Article "
                + "WHERE Content LIKE ? "
                + "AND Status = ?";
        try {
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "%" + search + "%");
                preStm.setString(2, status);
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

    public ArticleDTO get(int id) throws SQLException, NamingException, ParseException {
        String title, content, shortDescription, date, email, status;
        Date creatingDate, postingDate;
        ArticleDTO dto = null;
        try {
            String sql = "SELECT ArticleID, Title, ShortDescription, Content, Email, CreatingDate, PostingDate, StatusArticle.StatusName AS Status "
                    + "FROM Article FULL OUTER JOIN StatusArticle "
                    + "ON Article.Status = StatusArticle.StatusID "
                    + "WHERE ArticleID = ? AND Status = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                preStm.setString(2, "ACTIVE_ARTICLE");
                rs = preStm.executeQuery();
                if (rs.next()) {
                    title = rs.getString("Title");
                    shortDescription = rs.getString("ShortDescription");
                    content = rs.getString("Content");
                    email = rs.getString("Email");
                    creatingDate = rs.getDate("CreatingDate");
                    postingDate = rs.getDate("PostingDate");
                    status = rs.getString("Status");
                    dto = new ArticleDTO(id, title, shortDescription, content, email, creatingDate, postingDate, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public ArticleDTO getByAdmin(int id) throws SQLException, NamingException, ParseException {
        String title, content, shortDescription, date, email, status;
        Date creatingDate, postingDate;
        ArticleDTO dto = null;
        try {
            String sql = "SELECT ArticleID, Title, ShortDescription, Content, Email, CreatingDate, PostingDate, StatusArticle.StatusName AS Status "
                    + "FROM Article FULL OUTER JOIN StatusArticle "
                    + "ON Article.Status = StatusArticle.StatusID "
                    + "WHERE ArticleID = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setInt(1, id);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    title = rs.getString("Title");
                    shortDescription = rs.getString("ShortDescription");
                    content = rs.getString("Content");
                    email = rs.getString("Email");
                    creatingDate = rs.getDate("CreatingDate");
                    postingDate = rs.getDate("PostingDate");
                    status = rs.getString("Status");
                    dto = new ArticleDTO(id, title, shortDescription, content, email, creatingDate, postingDate, status);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public boolean approveArticle(int articleID) throws NamingException, SQLException {
        boolean check = Boolean.FALSE;
        try {
            String sql = "UPDATE Article SET Status = ?, PostingDate = ? WHERE ArticleID = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "ACTIVE_ARTICLE");
                preStm.setDate(2, new java.sql.Date(new Date().getTime()));
                preStm.setInt(3, articleID);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }

        return check;
    }

    @Override
    public boolean insert(ArticleDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "INSERT INTO Article(Title, ShortDescription, Content, Email, CreatingDate, Status) VALUES (?,?,?,?,?,?)";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getTitle());
                preStm.setString(2, dto.getShortDescription());
                preStm.setString(3, dto.getContent());
                preStm.setString(4, dto.getEmail());
                preStm.setDate(5, new java.sql.Date(new Date().getTime()));
                preStm.setString(6, "NEW_ARTICLE");
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public void delete(String articleID) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE Article SET Status = ? WHERE ArticleID = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "DELETED_ARTICLE");
                preStm.setString(2, articleID);
                preStm.executeUpdate();
            }

        } catch (SQLException | NamingException e) {
            System.out.println(e);
        } finally {
            closeConnection();
        }
    }

    @Override
    public boolean update(ArticleDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean delete(ArticleDTO k) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public ArticleDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
