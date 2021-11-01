/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.utils;

import java.io.Serializable;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Cyrus
 */
public class SendingEmail implements Serializable {

    private String email;
    private String code;

    public SendingEmail(String email, String code) {
        this.email = email;
        this.code = code;
    }

    public void sendEmail() throws MessagingException, AddressException {
        final String gmail = "kazuocyrus@gmail.com";
        final String pword = "Cyrus3012";
        Properties properties = new Properties();

        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");

        Session session = Session.getDefaultInstance(properties, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(gmail, pword);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(gmail));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
        message.setSubject("Please verify your e-mail from Simple Blog");
        String msg = "Please copy this code and paste it into your form "
                + "to complete the e-mail verification process."
                + "Your verification code: <b>" + code + "</b> "
                + "<p>The code can be used only once.</p>";

        message.setContent(msg, "text/html; charset=utf-8");

        Transport.send(message);

    }
}
