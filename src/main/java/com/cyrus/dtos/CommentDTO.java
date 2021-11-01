/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.util.Date;

/**
 *
 * @author Cyrus
 */
public class CommentDTO {

    private int commentID;
    private int articleID;
    private String email;
    private String content;
    private Date date;

    public CommentDTO() {
    }

    public CommentDTO(int commentID, int articleID, String email, String content, Date date) {
        this.commentID = commentID;
        this.articleID = articleID;
        this.email = email;
        this.content = content;
        this.date = date;
    }

    public int getCommentID() {
        return commentID;
    }

    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

}
