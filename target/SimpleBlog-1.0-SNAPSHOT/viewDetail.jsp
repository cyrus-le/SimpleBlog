<%-- 
    Document   : viewDetail
    Created on : Sep 28, 2021, 9:20:02 PM
    Author     : Cyrus
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">   
        <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
        <title>View Detail</title>
        <link rel="stylesheet" href="./css/index.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    </head>
    <style>
        textarea{
            resize: none;
            white-space: pre-wrap;
            width: 440px;
        }
    </style>

    <body class="bg-light">


        <c:if test="${requestScope.LIST.status == 'Deleted'}">
            <c:redirect url="searchArticle"/>
        </c:if>
        <c:set var="name" value="${sessionScope.NAME}" />
        <c:set var="dto" value="${requestScope.ARTICLE_DTO}" />
        <c:set var="comment" value="${requestScope.LIST_COMMENTS}"/>


        <nav style="background-color: #e3f2fd; position: fixed" class="navbar navbar-expand-lg navbar-light active w-100">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand" href="<c:if test="${sessionScope.USER.role eq 'ADMIN'}" >searchArticleByAdmin</c:if><c:if test="${sessionScope.USER.role != 'ADMIN'}" >searchArticle</c:if>">Simple<span class="text-primary" > Blog</span></a>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">

                    <form method="POST" class="form-inline my-2 my-lg-0" action="searchArticle">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item active">
                                <a class="nav-link" href="searchArticle">Home <span class="sr-only">(current)</span></a>
                            </li>

                        </ul>
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

            <br/>
            <c:if test="${not empty dto}">

                <h2 class="d-flex justify-content-center mx-3"
                    style="font-family:'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif">${dto.title}</h2>
                <input type="hidden" name="txtArticleID" value="${dto.articleID}" />
                <blockquote style="font-size: small; float: right" class="blockquote-footer text-right my-2">From
                    ${dto.email}</blockquote> <br />
                <p class="font-italic">" ${dto.shortDescription} "</p> 

                <p>${dto.content}</p>



                <div class="d-flex justify-content-end">
                    <c:if test="${sessionScope.USER.role eq 'ADMIN'}" >
                        <p><i class="fas fa-calendar-times"></i> Creating Date: ${dto.creatingDate}</p> 
                        <br/>
                    </c:if>
                    <div><i class="fas fa-calendar-times"></i> Posting Date: ${dto.postingDate}</div> 

                </div>
                <div class="d-flex justify-content-start">
                    <strong style="margin-right: 5px">Status: </strong> 
                    <font color="<c:if test="${dto.status eq 'Active'}">green</c:if>
                          <c:if test="${dto.status eq 'Deleted'}">red</c:if>
                          <c:if test="${dto.status eq 'New'}">orange</c:if>
                              ">
                    ${dto.status}
                    </font>
                </div>

                <br /> 
                <hr />




                <div class="form-group">
                    <!--comment nè-->
                    <c:if test="${sessionScope.USER != null && sessionScope.USER.role eq 'MEMBER'}">
                        <form action="postComment" accept-charset="utf-8" method="POST">
                            <input type="hidden" name="txtArticleID" value="${dto.articleID}" />
                            <input type="hidden" value="${dto.email}" name="txtAuthorPost" />
                            <c:if test="${sessionScope.USER.role != 'ADMIN'}">
                                <label for="comment">Comment:</label>
                                <textarea  required class="form-control col-md-8" rows="5"  name="txtComment" id="comment"></textarea> <br/>
                                <input class="btn btn-success" type="submit"/>
                            </c:if>
                        </form>
                    </c:if>
                </c:if>
                <br/>
                <c:if test="${not empty requestScope.LIST_COMMENTS}">                       
                    <c:forEach var="comment" items="${requestScope.LIST_COMMENTS}">                        

                        <h3>${comment.email}</h3>  <span class="blockquote-footer"> ${comment.date}</span> <br/>
                        <p class="text-monospace jumbotron">" ${comment.content} "</p> 
                        <hr/> 
                    </c:forEach>
                    <ul class="pagination d-flex justify-content-center">
                        <li class="page-item <c:if test="${requestScope.CURPAGE eq 0 }">disabled</c:if>">
                            <a  class="page-link" href="viewDetail?page=${requestScope.CURPAGE - 1}&txtArticleID=${dto.articleID}">Previous</a>
                        </li>
                        <c:forEach var="i" begin="1" end="${requestScope.PAGE}" step="1">
                            <li class="page-item <c:if test="${requestScope.CURPAGE + 1 eq i}">active</c:if>">
                                <a class="page-link" href="viewDetail?page=${i - 1}&txtArticleID=${dto.articleID}">${i}</a>
                            </li> 
                        </c:forEach>

                        <li class="page-item <c:if test="${requestScope.CURPAGE eq requestScope.PAGE - 1}">disabled</c:if>">
                            <a class="page-link" href="viewDetail?page=${requestScope.CURPAGE + 1}&txtArticleID=${dto.articleID}">Next</a>
                        </li>
                    </ul>
                </c:if>

                <c:if test="${sessionScope.USER != null && sessionScope.USER.role eq 'MEMBER'}">
                    <c:if test="${empty requestScope.LIST_COMMENTS}">
                        <div class ="alert alert-success">
                            <strong>Be the first one</strong> to comment this article
                        </div>
                    </c:if>   
                </c:if>
            </div>


        </div>


        <script type="text/javascript">
            function divide() {
                var txt;
                txt = document.getElementById('comment').value;
                var text = txt.split(".");
                var str = text.join('.</br>');
                document.write(str);
            }
        </script> 

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
    </body>

</html>
