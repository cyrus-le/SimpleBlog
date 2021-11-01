/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.cyrus.controllers;

import com.cyrus.daos.UserDAO;
import com.cyrus.dtos.UserDTO;
import com.cyrus.dtos.UserErrorObj;
import com.cyrus.utils.EncryptUtil;
import com.cyrus.utils.SendingEmail;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Random;
import javax.mail.MessagingException;
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
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    private final static Logger logger = Logger.getLogger(RegisterController.class);
    private static final String SUCCESS = "verifyPage";
    private static final String ERROR = "registerPage";
    private static final UserErrorObj errorObj = new UserErrorObj();
    private static final UserDAO dao = UserDAO.getInstance();

    private boolean validateEmail(final HttpServletRequest req) {
        boolean check = false;
        String email = req.getParameter("txtEmail");
        if (email != null) {
            if (!email.isBlank()) {
                if (!email.trim().matches("^([0-9a-z]{3,30}@[0-9a-z]{3,30}([.][a-z]{2,5}){1,2}){1,30}")) {
                    errorObj.setEmailError("Please input right format email with max length 30");
                } else {

                    check = true;
                }
            } else {
                errorObj.setEmailError("Email can't be blank");
            }
        } else {
            errorObj.setEmailError("Email must not be null");
        }

        return check;
    }

    private boolean validatePassword(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String pwd = req.getParameter("txtPassword");
        if (pwd != null) {
            if (!pwd.trim().isBlank()) {
                if (pwd.trim().matches("\\w{6,}")) {
                    check = true;
                    req.setAttribute("PWD", pwd);
                } else {
                    errorObj.setPasswordError("Password is at least 6 characters and doesn't have special characters");
                }
            } else {
                errorObj.setPasswordError("Password cannot be blank");
            }
        } else {
            errorObj.setPasswordError("Passowrd cannot be null.");
        }
        return check;
    }

    private boolean validateConfirmPassword(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String confirm = req.getParameter("txtConfirmPassword");
        if (confirm != null) {
            if (!confirm.trim().isBlank()) {
                if (confirm.equals(String.valueOf(req.getAttribute("PWD")))) {
                    check = true;
                    req.setAttribute("PWD", null);
                } else {
                    errorObj.setConfirmError("The confirm password is not equal to the origin password.");
                }
            } else {
                errorObj.setConfirmError("Password cannot be blank");
            }

        } else {
            errorObj.setConfirmError("The confirm password cannot be null.");
        }
        return check;
    }

    private boolean validateName(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String fullname = req.getParameter("txtName");
        if (fullname != null) {
            if (!fullname.trim().isBlank()) {
                if (fullname.matches("^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạ"
                        + "ảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]{1,25}$")) {
                    check = true;
                } else {
                    errorObj.setNameError("Name must be alphabet");
                }
            } else {
                errorObj.setNameError("Name cannot be blank");
            }

        } else {
            errorObj.setNameError("Name must not be null.");
        }
        return check;
    }

    private boolean checkValidate(final HttpServletRequest req) {
        return validateEmail(req) && validatePassword(req) && validateConfirmPassword(req) && validateName(req);
    }

    private void callInsert(final HttpServletRequest request) throws SQLException, NamingException, NoSuchAlgorithmException, MessagingException {
        String url = ERROR;
        String email = request.getParameter("txtEmail");

        String password = EncryptUtil.encryptPassword(request.getParameter("txtPassword"));
        String name = request.getParameter("txtName");

        //Generate Code:
        Random random = new Random();
        int num = random.nextInt(999999);
        String code = String.format("%06d", num);

        UserDTO dto = new UserDTO();
        dto.setEmail(email);
        dto.setName(name);
        dto.setPassword(password);
        dto.setCode(code);

        if (dao.insert(dto)) {
            HttpSession session = request.getSession();
            session.setAttribute("EMAIL_REGISTERED", email);
            SendingEmail sendingEmail = new SendingEmail(email, code);
            sendingEmail.sendEmail();
            url = SUCCESS;

        } else {
            request.setAttribute("ERROR", "Insert Failed");
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            final boolean check = checkValidate(request);
            if (check) {
                callInsert(request);
                url = SUCCESS;
            } else {
                request.setAttribute("ERROR", errorObj);
            }
        } catch (NoSuchAlgorithmException | SQLException | NamingException | MessagingException e) {
            logger.error("Error at RegisterController: " + e.getMessage());
            if (e.getMessage().contains("duplicate")) {
                errorObj.setEmailError("There is an existed account. Please use another email");
                request.setAttribute("ERROR", errorObj);
                url = ERROR;
            }
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
