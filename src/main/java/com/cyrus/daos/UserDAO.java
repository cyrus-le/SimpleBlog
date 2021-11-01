/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import com.cyrus.dtos.UserDTO;
import com.cyrus.utils.DBHelper;

/**
 *
 * @author Cyrus
 */
public class UserDAO implements ICRUDRepository<UserDTO, String> {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static UserDAO instance;

    public static UserDAO getInstance() {
        if (instance == null) {
            instance = new UserDAO();
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

    public boolean checkActivateCode(String code, String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "SELECT Email FROM [User] WHERE Email = ? AND Code = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, code);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updateStatusActivate(String email) throws SQLException, NamingException {
        boolean check = false;
        try {
            String sql = "UPDATE [User] SET [Status] = ? WHERE Email = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, "ACTIVE_ACCOUNT");
                preStm.setString(2, email);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public UserDTO checkLogin(String email, String password) throws Exception {
        String role = "failed", name;
        UserDTO dto = null;
        try {
            String sql = "SELECT Name, [Role] FROM [User] WHERE Email = ? AND [Password] = ? AND [Status] = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                preStm.setString(2, password);
                preStm.setString(3, "ACTIVE_ACCOUNT");
                rs = preStm.executeQuery();
                if (rs.next()) {
                    name = rs.getString("Name");
                    role = rs.getString("Role");
                    dto = new UserDTO(email, name, password, role, "ACTIVE_ACCOUNT");
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

//AuthenticateAvailableEmailController
    @Override
    public boolean insert(UserDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {

            String sql = "INSERT INTO [User](Email, [Name], [Password], [Role], [Status], Code) VALUES (?,?,?,?,?,?)";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, dto.getEmail());
                preStm.setString(2, dto.getName());
                preStm.setString(3, dto.getPassword());
                preStm.setString(4, "MEMBER");
                preStm.setString(5, "NEW_ACCOUNT");
                preStm.setString(6, dto.getCode());

                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    @Override
    public boolean delete(UserDTO k) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean update(UserDTO k, String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public UserDTO checkExistedEmailGoogle(String email) throws SQLException, NamingException {
        UserDTO dto = null;
        try {
            String sql = "SELECT Email, [Name], [Password], [Role], [Status] FROM [User] WHERE Email = ?";
            conn = DBHelper.getConnection();
            if (conn != null) {
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, email);
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("Name");
                    String password = rs.getString("Password");
                    String role = rs.getString("Role");
                    String status = rs.getString("Status");
                    dto = new UserDTO(email, name, password, role, status, null);
                }
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    @Override
    public UserDTO get(String v) throws SQLException, NamingException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
