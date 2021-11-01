/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cyrus.daos;

import com.cyrus.dtos.StatusArticleDTO;
import com.cyrus.utils.DBHelper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/**
 *
 * @author Cyrus
 */
public class StatusArticleDAO {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static StatusArticleDAO instance;

    public static StatusArticleDAO getInstance() {
        if (instance == null) {
            instance = new StatusArticleDAO();
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

    public List<StatusArticleDTO> getAllArticleStatusList() throws SQLException, NamingException {
        List<StatusArticleDTO> list = null;
        StatusArticleDTO dto;
        try {
            String sql = "SELECT StatusID, StatusName FROM StatusArticle";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                rs = preStm.executeQuery();
                list = new ArrayList();
                while (rs.next()) {
                    String statusID = rs.getString("StatusID");
                    String statusName = rs.getString("StatusName");
                    dto = new StatusArticleDTO(statusID, statusName);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

}
