<%-- 
    Document   : verify
    Created on : Oct 15, 2021, 9:58:28 PM
    Author     : Cyrus
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
              integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    </head>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verify Page</title>
        <style>
            body{
                margin: 0;
                font-family: Arial, Helvetica, sans-serif;
            }
            .image{
                background-image: url("./img/photo-1490100667990-4fced8021649.png");
                background-color: #cccccc;
                height: 800px;
                background-repeat: no-repeat;
                background-size: cover;
                background-position: center;
                position: relative;
            }

            .text{
                text-align: center;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                color: white;

            }

        </style>
    </head>

    <body  class="bg-light">

        <div class="image">
            <div class="container">
                <div class="text">
                    <h1 style="font-size:80px">Check your email</h1>
                    <br/>
                    <form action="authenticateAvailableEmail" method="POST">
                        <font color='red'>${requestScope.ERROR}</font>
                        <div class="form-group">
                            <h4>Input your code: </h4>
                            <input class="form-control" type="text" name="txtCode" value="" /> <br/>
                            <input type="hidden" value="${sessionScope.EMAIL_REGISTERED}" name="txtEmail" /> <br/>
                            <input class="btn btn-primary" type="submit" value="Verify" name="action" />
                        </div>

                    </form>

                </div>
            </div>

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
