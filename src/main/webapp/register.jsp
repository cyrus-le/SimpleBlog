<%-- 
    Document   : signup
    Created on : Sep 16, 2021, 4:41:27 PM
    Author     : Cyrus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
        <link rel="stylesheet" href="./css/signup.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Sofia">
        <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Overpass+Mono" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
              integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    </head>
    <body class="bg-light">
        <div class="container">
            <h1>Sign Up</h1>
            <br>
            <form action="register" method="POST">
                <div class="form-group">
                    <label class="font" >Email: </label> <br/>
                    <font color="red">${requestScope.ERROR.emailError}</font>
                    <input name="txtEmail" value="${param.txtEmail}" class="form-control"  placeholder="Enter your Email" >
                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small> 
                </div>
                <br/>
                <div class="form-group">
                    <label class="font">Password: </label> <br/>
                    <font color="red">${requestScope.ERROR.passwordError}</font>
                    <input name="txtPassword" type="password" class="form-control" placeholder="Enter Password" >
                </div>
                <br/>
                <div class="form-group">
                    <label class="font">Confirm Password: </label> <br/>
                    <font color="red">${requestScope.ERROR.confirmError}</font>
                    <input type="password" class="form-control"  placeholder="Enter Password once again" name="txtConfirmPassword" >
                </div>
                <br/>
                <div class="form-group">
                    <label class="font">Name: </label> <br/>
                    <font color="red">${requestScope.ERROR.nameError}</font>
                    <input type="text" class="form-control"  placeholder="Enter your Name" name="txtName" value="${param.txtName}">
                </div>
                <br/>
                <input type="submit" class="btn btn-outline-success" />

            </form>
        </div>
    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
    crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
    crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
            integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
    crossorigin="anonymous"></script>
</html>
