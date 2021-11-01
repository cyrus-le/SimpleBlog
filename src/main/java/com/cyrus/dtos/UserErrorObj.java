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
public class UserErrorObj {
    private String emailError;
    private String passwordError;
    private String roleError;
    private String statusError;
    private String confirmError;
    private String nameError;
    private String notExistedError;

    public String getNotExistedError() {
        return notExistedError;
    }

    public void setNotExistedError(String notExistedError) {
        this.notExistedError = notExistedError;
    }
    
    public String getNameError() {
        return nameError;
    }

    public void setNameError(String nameError) {
        this.nameError = nameError;
    }
    
    

    public String getConfirmError() {
        return confirmError;
    }

    public void setConfirmError(String confirmError) {
        this.confirmError = confirmError;
    }
    
    public String getEmailError() {
        return emailError;
    }

    public void setEmailError(String emailError) {
        this.emailError = emailError;
    }

    public String getPasswordError() {
        return passwordError;
    }

    public void setPasswordError(String passwordError) {
        this.passwordError = passwordError;
    }

    public String getRoleError() {
        return roleError;
    }

    public void setRoleError(String roleError) {
        this.roleError = roleError;
    }

    public String getStatusError() {
        return statusError;
    }

    public void setStatusError(String statusError) {
        this.statusError = statusError;
    }
    
    public UserErrorObj() {
    }
    
}
