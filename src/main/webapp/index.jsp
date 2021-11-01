<%-- 
    Document   : index
    Created on : Sep 14, 2021, 4:00:03 PM
    Author     : Cyrus
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Simple Blog</title>
        <link rel="stylesheet" href="./css/index.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    </head>

    <body class="bg-light">

        <c:set var="name" value="${sessionScope.NAME}" />
        <c:set var="id" value="${sessionScope.USER.email}"/>


        <nav style="background-color: #e3f2fd;position: fixed" class="navbar navbar-expand-lg navbar-light active w-100">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand" href="searchArticle">Simple<span class="text-primary" > Blog</span></a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">

                <form accept-charset="utf-8" method="POST" class="form-inline my-2 my-lg-0" action="searchArticle">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active">
                            <a class="nav-link" href="searchArticle">Home <span class="sr-only">(current)</span></a>
                        </li>

                    </ul>

                    <ul class="navbar-nav mx-auto">
                        <div class="input-group mx-5">
                            <div class="input-group-prepend">
                                <span class="input-group-text" id="basic-addon1">
                                    <i class="fas fa-search"></i>
                                </span>
                            </div>
                            <input class="form-control" type="text" placeholder="Search" value="${param.txtSearch}"
                                   name="txtSearch"/>
                            <input class="btn btn-success" type="submit" value="Search" name="action" />
                        </div>
                    </ul>
                    <c:if test="${sessionScope.USER != null && sessionScope.USER.role eq 'MEMBER'}">
                        <ul class="nav navbar-top-links navbar-left m-l-20 hidden-xs">
                            <li class="nav-item">

                                <input  type="button" value="Post your article" class="btn btn-primary my-2 my-sm-0" data-toggle="modal"
                                        data-target="#insertModal" />
                            </li>
                        </ul>
                    </c:if> 
                </form>


            </div>
            <c:if test="${not empty sessionScope.USER }">
                <ul class="nav justify-content-end">
                    <li style="list-style: none" class="nav-item active">
                        <i class="fa fa-user"></i> <span class="text-primary">Welcome back</span> ${name}
                    </li>
                </ul>

                <div class="float-right">
                    <a class="btn btn-secondary ml-3" style="text-decoration: none; right:30px" href="logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.USER }">
                <div class="float-right">          
                    <a class="btn btn-info ml-3" style="text-decoration: none; right:30px" href="loginPage">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </div>
            </c:if>                



        </nav>


        <div class="container pt-5">
            <c:if test="${not empty requestScope.LIST}">
                <c:if test="${not empty requestScope.LIST}" var="checkList">
                    <c:forEach items="${requestScope.LIST}" var="dto">
                        <input type="hidden" value="${dto.email}" name="txtEmail" />

                        <div class="well">
                            <div class="media">

                                <div class class="media-body">
                                    <input type="hidden" name="txtArticleID" value="${dto.articleID}" />
                                    <input type="hidden" name="txtArticleEmail" value="${dto.email}" />
                                    <h2 style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif" class="py-4" >${dto.title}</h2>

                                    <blockquote style="font-size: small" class="blockquote-footer">From
                                        ${dto.email}</blockquote> 
                                    <p class="font-italic">" ${dto.shortDescription} "</p>                                 
                                    <p>${dto.content}</p> <br />                                                                        
                                    <ul class="list-inline list-unstyled">
                                        <li class="list-inline-item"><span><i class="fas fa-calendar-times"></i></span> 
                                                    ${dto.postingDate}
                                        </li>
                                        <li class="list-inline-item">|</li>
                                        <span ><i class="fas fa-comments"></i> ${dto.countComment} comments</span> <br/>
                                    </ul>
                                    <a href="viewDetail?txtArticleID=${dto.articleID}" class="btn btn-warning">View Detail
                                    </a>


                                </div>

                            </div>
                        </div>
                        <hr>
                    </c:forEach>
                </c:if>
                <c:if test="${!checkList}">
                    <div class="alert alert-dark my-5">
                        <i class="fas fa-search"></i><strong> NOT FOUND </strong> OOPSS There is no result.
                    </div>
                </c:if>
            </c:if>




            <c:if test="${not empty requestScope.LIST}">
                <ul class="pagination d-flex justify-content-center">
                    <li class="page-item <c:if test="${requestScope.CURPAGE eq 0 }">disabled</c:if>">
                        <a  class="page-link" href="searchArticle?page=${requestScope.CURPAGE - 1}&txtSearch=${param.txtSearch}">Previous</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${requestScope.PAGE}" step="1">
                        <li class="page-item <c:if test="${requestScope.CURPAGE + 1 eq i}">active</c:if>">
                            <a class="page-link" href="searchArticle?page=${i - 1}&txtSearch=${param.txtSearch}">${i}</a>
                        </li> 
                    </c:forEach>

                    <li class="page-item <c:if test="${requestScope.CURPAGE eq requestScope.PAGE - 1}">disabled</c:if>">
                        <a class="page-link" href="searchArticle?page=${requestScope.CURPAGE + 1}&txtSearch=${param.txtSearch}">Next</a>
                    </li>
                </ul>
            </c:if>



            <c:if test="${empty requestScope.LIST}">
                <div class="alert alert-dark my-5">
                    <i class="fas fa-search"></i><strong> NOT FOUND </strong>  OOPS You haven't posted anything.......
                </div>
            </c:if>

        </div>

        <!--inssert article-->
        <div class="modal" id="insertModal">
            <form name="newArticle" accept-charset="utf-8" action="postArticle" method="POST">
                <div class="modal-dialog">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title d-flex justify-content-center">Post Article</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>

                        <!-- Modal body -->
                        <div class="modal-body form-group">
                            <label>Title:</label>
                            <input class="form-control" type="text" name="txtTitle" value=""}" />
                            <br />
                            <input type="hidden" name="txtArticleID" value="" />
                            <label>Short Description:</label>
                            <textarea name="txtShortDescription" class="form-control" rows="5" id="comment"
                                      placeholder="Describe something on this article, ${name}?"></textarea>
                            <label>Content:</label>
                            <textarea name="txtContent" class="form-control" rows="5" id="comment"
                                      placeholder="Input the content"></textarea>

                        </div>
                        <!-- Modal footer -->
                        <div class="modal-footer">
                            <button class="btn btn-outline-danger" type="submit"  <c:if test="${requestScope.ARTICLE_ERROR == null}" >onclick="
                                    var form = document.forms['newArticle'];
                                    event.preventDefault();
                                    Swal.fire(
                                            'Creating the article succesffuly!',
                                            'Please wait for the admin to accept this post',
                                            'success'
                                            ).then((result) => {
                                        if (result.isConfirmed) {
                                            form.submit();
                                        }
                                    })"</c:if> >Post the article</button>
                            </div>

                        </div>
                    </div>
                </form>
            </div>
        <c:if test="${not empty requestScope.ARTICLE_ERROR}">
            <c:set var="error" value="${requestScope.ARTICLE_ERROR}" />
            <div class="modal" id="errorModal">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">

                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title-danger d-flex justify-content-center">Error</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>                        
                        <!-- Modal body -->
                        <div class="modal-body form-group">
                            <c:if test="${not empty error.titleError}">
                                <p>${error.titleError}</p>
                            </c:if>
                            <c:if test="${not empty error.shortDescriptionError}">
                                <p>${error.shortDescriptionError}"</p>
                            </c:if>
                            <c:if test="${not empty error.contentError}">
                                <p>"${error.contentError}</p>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
            <script>window.addEventListener('load', () => {
                    $("#errorModal").modal();
                });</script>
            </c:if>



        <script>
            $(document).ready(function () {
                console.log('<c:out value="${sessionScope.USER.email}"/>');
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    </body>

</html>
