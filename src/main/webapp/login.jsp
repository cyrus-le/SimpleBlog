<%-- 
    Document   : login
    Created on : Sep 16, 2021, 10:41:15 AM
    Author     : Cyrus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link rel="stylesheet" href="./css/login.css">
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto+Mono&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Indie+Flower|Overpass+Mono" rel="stylesheet">
        <link rel="SHORTCUT ICON" href="./img/logo.jpg">    
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">

    </head>
    <body>
        <form class="form-group" action="login" method="POST">
            <div class="login__content">
                <div class="login__left">
                    <img src="./img/blog.jpg" alt="">
                </div>
                <div class="login__right">               

                    <div class="container-login100">
                        <div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">

                            <span class="login100-form-title p-b-32">
                                Account Login
                            </span>
                            <font color="red">${requestScope.ERROR.notExistedError}</font> <br/>
                            <span class="txt1 p-b-11">
                                Email
                            </span>
                            <div class="wrap-input100 validate-input m-b-36">
                                <input class="input100" type="text" name="txtEmail" placeholder="Input your email">

                                <span class="focus-input100"></span>
                            </div>
                            <br/>
                            <span class="txt1 p-b-11">
                                Password
                            </span>
                            <div class="wrap-input100 validate-input m-b-12">
                                <span class="btn-show-pass">
                                    <i class="fa fa-eye"></i>
                                </span>
                                <input class="input100" type="password" name="txtPassword" placeholder="Input your password" >
                                <span class="focus-input100"></span>
                            </div>
                            <br/>

                            <input type="submit" class=" btn btn-success my-1" value="Login" name="action"/>                                                                           

                            <br/>

                            <a class="btn btn-outline-info my-3" href="registerPage">
                                Don't have an account? Sign up here
                                <i class="fas fa-user-plus"></i>
                            </a> <br/>


                        </div>
                    </div>
                </div>

            </div>
        </form>
    </body>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="js/main.js"></script>
</html>
