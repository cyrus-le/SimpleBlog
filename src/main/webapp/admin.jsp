<%-- 
    Document   : admin
    Created on : Oct 19, 2021, 9:52:56 AM
    Author     : Cyrus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">      
        <link rel="stylesheet" href="./css/index.css">
    </head>
    <body>
        <c:set var="name" value="${sessionScope.NAME}" />
        <c:set var="id" value="${sessionScope.USER.email}"/>

        <nav class="navbar navbar-expand-lg navbar-dark bg-dark active w-100 t-0">
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <a class="navbar-brand" href="searchArticleByAdmin">Simple<span class="text-primary" > Blog</span></a>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">


                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="searchArticleByAdmin">Admin Home <span class="sr-only">(current)</span></a>
                    </li>

                </ul>

                <ul class="navbar-nav mx-auto px-5 t-50">
                    <form action="searchArticleByAdmin">
                        <div class="input-group">
                            <input type="text" name="txtSearch" class="form-control w-50" placeholder="Search this blog">
                            <input type="hidden" name="txtStatus" value="${param.txtStatus}" />
                            <div class="dropdown show">
                                <a class="btn btn-info dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Status
                                </a>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                    <c:set var="page" value="${requestScope.CUR_PAGE}" />
                                    <c:forEach var="status" items="${requestScope.STATUS_LIST}" >
                                        <a class="dropdown-item
                                           <c:if test="${status.statusID eq 'NEW_ARTICLE'}" > text-warning</c:if>
                                           <c:if test="${status.statusID eq 'ACTIVE_ARTICLE'}" > text-success</c:if>
                                           <c:if test="${status.statusID eq 'DELETED_ARTICLE'}" > text-danger</c:if>
                                               " 
                                               href="searchArticleByAdmin?txtSearch=${param.txtSearch}&txtStatus=${status.statusID}&page=0">${status.statusName}</a>
                                    </c:forEach>
                                    <div class="dropdown-divider"></div>
                                    <a class="dropdown-item text-primary" href="searchArticleByAdmin?txtSearch=${param.txtSearch}&txtStatus=&page=0">All</a>
                                </div>
                            </div>
                            <div class="input-group-append">
                                <button class="btn btn-secondary" type="submit">
                                    <i class="fa fa-search"></i>
                                </button>
                            </div>
                        </div> 
                    </form>
                </ul>

                </form>
            </div>
            <c:if test="${not empty sessionScope.USER}">
                <ul class="nav justify-content-end">
                    <li style="list-style: none" class="nav-item active">
                        <i class="fa fa-user text-white"></i> <span class="text-primary">Welcome back</span> <span class="text-white">${name}</span>
                    </li>
                </ul>
            </c:if>

            <c:if test="${empty sessionScope.USER }">
                <div class="float-right">          
                    <a class="btn btn-info ml-3" style="text-decoration: none; right:30px" href="loginPage">
                        <i class="fas fa-sign-in-alt"></i> Login
                    </a>
                </div>
            </c:if>
            <c:if test="${not empty sessionScope.USER}">
                <div class="float-right">

                    <a class="btn btn-secondary ml-3" style="text-decoration: none; right:30px" href="logout">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </c:if>
        </nav>
        <!--Search Article for Admin-->
        <table class="table table-bordered table-hover position-relative" style="height: 30%"  border="1">
            <thead class="thead-dark text-center" >
                <tr>
                    <th class="align-middle" >#NO</th>
                    <th class="align-middle">Article ID</th>
                    <th class="align-middle">Title</th>
                    <th class="align-middle">Short Description</th>
                    <th class="align-middle">Content</th>
                    <th class="align-middle">Author</th>
                    <th class="align-middle">Creating Date</th>
                    <th class="align-middle">Posting Date</th>
                    <th class="align-middle">Status</th>
                    <th class="align-middle">Action</th>

                </tr>
            </thead>
            <tbody>
                <c:forEach var="dto" items="${requestScope.LIST}" varStatus="counter">
                <form action="approveArticle">
                    <tr>
                        <td class="align-middle">${counter.count}</td>
                        <td class="align-middle">
                            ${dto.articleID} </td>
                        <td class="align-middle">
                            <a href="viewDetail?txtArticleID=${dto.articleID}">${dto.title}</a>
                        </td>
                        <td class="align-middle" >${dto.shortDescription}</td>
                        <td class="align-middle" >${dto.content}</td>
                        <td class="align-middle" >${dto.email}</td>
                        <td class="align-middle">${dto.creatingDate}</td>
                        <td class="align-middle">${dto.postingDate}</td>
                        <td class="align-middle" >
                            <p class="<c:if test="${dto.status eq 'New'}" >text-warning</c:if>
                               <c:if test="${dto.status eq 'Active'}" >text-success</c:if>
                               <c:if test="${dto.status eq 'Deleted'}" >text-danger</c:if>
                                   ">                           
                               ${dto.status}</p>
                        </td>
                        <td class="align-middle" colspan="2">                        
                            <input type="hidden" name="txtArticleID" value="${dto.articleID}"/>
                            <input type="hidden" name="txtPostingDate" value="${dto.postingDate}"/>
                            <input type="hidden" name="txtStatus" value="${dto.status}"/>

                            <c:url var="activate" value="approveArticle">
                                <c:param name="txtArticleID" value="${dto.articleID}"></c:param>
                                <c:param name="txtSearch" value="${param.txtSearch}"></c:param>
                                <c:param name="page" value="${param.page}"></c:param>
                                <c:param name="txtStatus" value="${param.txtStatus}"></c:param>
                            </c:url>

                            <c:if test="${dto.status eq 'New' || dto.status eq 'Deleted'}">
                                <a onclick="event.preventDefault();
                                        Swal.fire(
                                                'Approve the article succesffuly!',
                                                'Activate the article ID: ${dto.articleID}',
                                                'success'
                                                ).then((result) => {
                                            if (result.isConfirmed) {
                                                window.location.href = '${activate}';
                                            }
                                        })" class="btn btn-outline-primary" href="${activate}" ><i class="fas fa-check-circle"></i> 
                                    <c:if test="${dto.status eq 'New'}"> Approve</c:if>
                                    <c:if test="${dto.status eq 'Deleted'}"> Activate</c:if>
                                    </a>
                            </c:if>

                            <c:url var="delete" value="deleteArticle">
                                <c:param name="txtArticleID" value="${dto.articleID}"></c:param>
                                <c:param name="txtSearch" value="${param.txtSearch}"></c:param>
                                <c:param name="page" value="${param.page}"></c:param>
                                <c:param name="txtStatus" value="${param.txtStatus}"></c:param>
                            </c:url>

                            <c:if test="${dto.status eq 'New' || dto.status eq 'Active'}">
                                <a class="btn btn-outline-danger" href="${delete}" onclick="
                                        event.preventDefault();
                                        Swal.fire({
                                            title: 'Do you want to delete this post?',
                                            icon: 'question',
                                            showCancelButton: true,
                                            confirmButtonColor: '#d33',
                                            cancelButtonColor: '#707881',
                                            confirmButtonText: 'Yes'
                                        }).then((result) => {
                                            if (result.isConfirmed) {
                                                event.preventDefault();
                                                Swal.fire(
                                                        'Deleted',
                                                        'ArticleID ${dto.articleID} was deleted',
                                                        'success'
                                                        ).then(result => {
                                                    if (result.isConfirmed) {
                                                        window.location.href = '${delete}';
                                                    }
                                                })
                                            }
                                        }
                                        )
                                   " >
                                    <i class="fa fa-times-circle"></i> Delete
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </form>
            </c:forEach>
        </tbody>
    </table>

    <c:if test="${not empty requestScope.LIST}">
        <ul class="pagination d-flex justify-content-center">
            <li class="page-item <c:if test="${requestScope.CUR_PAGE eq 0 }">disabled</c:if>">
                <a  class="page-link" href="searchArticleByAdmin?page=${requestScope.CUR_PAGE - 1}&txtSearch=${param.txtSearch}&txtStatus=${param.txtStatus}">Previous</a>
            </li>
            <c:forEach var="i" begin="1" end="${requestScope.PAGE}" step="1">
                <li class="page-item <c:if test="${requestScope.CUR_PAGE + 1 eq i}">active</c:if>">
                    <a class="page-link" href="searchArticleByAdmin?page=${i - 1}&txtSearch=${param.txtSearch}&txtStatus=${param.txtStatus}">${i}</a>
                </li> 
            </c:forEach>

            <li class="page-item <c:if test="${requestScope.CUR_PAGE eq requestScope.PAGE - 1}">disabled</c:if>">
                <a class="page-link" href="searchArticleByAdmin?page=${requestScope.CUR_PAGE + 1}&txtSearch=${param.txtSearch}&txtStatus=${param.txtStatus}">Next</a>
            </li>
        </ul>
    </c:if>


    <c:if test="${empty requestScope.LIST}">
        <div class="container">
            <div class="alert alert-dark my-5 d-flex justify-content-center position-static">
                <p class="text-left font-weight-bold">  <i class="fas fa-search"></i>  NOT FOUND </p> <span> OOPS We cannot found any articles...! </span>  
            </div>
        </div>
    </c:if>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
</body>
</html>
