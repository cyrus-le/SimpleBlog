/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

/**
 *
 * @author Cyrus
 */
public class UserDTO {

    private String email;
    private String name;
    private String password;
    private String role;
    private String status;
    private String code;

    public UserDTO() {
    }

    public UserDTO(String email, String name, String password, String role, String status) {
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = role;
        this.status = status;
    }

    public UserDTO(String email, String name, String password, String role, String status, String code) {
        this.email = email;
        this.name = name;
        this.password = password;
        this.role = role;
        this.status = status;
        this.code = code;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Override
    public String toString() {
        return "Account{" + "email=" + email + ", name=" + name + ", password=" + password + ", role=" + role + ", status=" + status + '}';
    }

}
