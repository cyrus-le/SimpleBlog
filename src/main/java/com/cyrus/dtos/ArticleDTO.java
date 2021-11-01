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
public class ArticleDTO {

    private int articleID;
    private String title;
    private String shortDescription;
    private String content;
    private String email;
    private Date creatingDate;
    private Date postingDate;
    private String status;

    private int countComment;

    public ArticleDTO(int articleID, String title, String shortDescription, String content, String email, Date creatingDate, Date postingDate, String status) {
        this.articleID = articleID;
        this.title = title;
        this.shortDescription = shortDescription;
        this.content = content;
        this.email = email;
        this.creatingDate = creatingDate;
        this.postingDate = postingDate;
        this.status = status;
    }

    public ArticleDTO(int articleID, String title, String shortDescription, String content, String email, Date creatingDate, Date postingDate, String status, int countComment) {
        this.articleID = articleID;
        this.title = title;
        this.shortDescription = shortDescription;
        this.content = content;
        this.email = email;
        this.creatingDate = creatingDate;
        this.postingDate = postingDate;
        this.status = status;
        this.countComment = countComment;
    }

    public ArticleDTO() {
    }

    public int getArticleID() {
        return articleID;
    }

    public void setArticleID(int articleID) {
        this.articleID = articleID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreatingDate() {
        return creatingDate;
    }

    public void setCreatingDate(Date creatingDate) {
        this.creatingDate = creatingDate;
    }

    public Date getPostingDate() {
        return postingDate;
    }

    public void setPostingDate(Date postingDate) {
        this.postingDate = postingDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCountComment() {
        return countComment;
    }

    public void setCountComment(int countComment) {
        this.countComment = countComment;
    }

    @Override
    public String toString() {
        return "ArticleDTO{" + "articleID=" + articleID + ", title=" + title + ", shortDescription=" + shortDescription + ", content=" + content + ", email=" + email + ", creatingDate=" + creatingDate + ", postingDate=" + postingDate + ", status=" + status + '}';
    }

}
