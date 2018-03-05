<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html lang="en">
<!DOCTYPE html>
<meta charset="UTF-8">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="https://getbootstrap.com/favicon.ico">
    <style type="text/css">
        :root .container > .infoBoxList > .shareInfoBox,
        :root .carbonad,
        :root #carbonads-container,
        :root #content > #right > .dose > .dosesingle,
        :root #content > #center > .dose > .dosesingle,
        :root .back-to-top {
            display: none !important;
        }</style>

    <title>Registracija</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/home2/bootstrap.css"/>" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="<c:url value="/resources/home2/ie10-viewport-bug-workaround.css"/>" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<c:url value="/resources/home2/cover.css"/>" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="<c:url value="/resources/home2/ie-emulation-modes-warning.js"/>"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <style>

        #playground-container {
            height: 500px;
            overflow: hidden !important;
            -webkit-overflow-scrolling: touch;
        }

        body, html {
            height: 100%;
            background-repeat: no-repeat;
            background: url(https://i.ytimg.com/vi/4kfXjatgeEU/maxresdefault.jpg);
            font-family: 'Oxygen', sans-serif;
            background-size: cover;
        }

        .main {
            margin: 50px 15px;
        }

        h1.title {
            font-size: 50px;
            font-family: 'Passion One', cursive;
            font-weight: 400;
        }

        hr {
            width: 10%;
            color: #fff;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            margin-bottom: 15px;
        }

        input,
        input::-webkit-input-placeholder {
            font-size: 11px;
            padding-top: 3px;
        }

        .main-login {
            background-color: #fff;
            /* shadows and rounded borders */
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
            border-radius: 2px;
            -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);

        }

        .form-control {
            height: auto !important;
            padding: 8px 12px !important;
        }

        .input-group {
            -webkit-box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.21) !important;
            -moz-box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.21) !important;
            box-shadow: 0px 2px 5px 0px rgba(0, 0, 0, 0.21) !important;
        }

        #button {
            border: 1px solid #ccc;
            margin-top: 28px;
            padding: 6px 12px;
            color: #666;
            text-shadow: 0 1px #fff;
            cursor: pointer;
            -moz-border-radius: 3px 3px;
            -webkit-border-radius: 3px 3px;
            border-radius: 3px 3px;
            -moz-box-shadow: 0 1px #fff inset, 0 1px #ddd;
            -webkit-box-shadow: 0 1px #fff inset, 0 1px #ddd;
            box-shadow: 0 1px #fff inset, 0 1px #ddd;
            background: #f5f5f5;
            background: -moz-linear-gradient(top, #f5f5f5 0%, #eeeeee 100%);
            background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #f5f5f5), color-stop(100%, #eeeeee));
            background: -webkit-linear-gradient(top, #f5f5f5 0%, #eeeeee 100%);
            background: -o-linear-gradient(top, #f5f5f5 0%, #eeeeee 100%);
            background: -ms-linear-gradient(top, #f5f5f5 0%, #eeeeee 100%);
            background: linear-gradient(top, #f5f5f5 0%, #eeeeee 100%);
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#f5f5f5', endColorstr='#eeeeee', GradientType=0);
        }

        .main-center {
            margin-top: 30px;
            margin: 0 auto;
            max-width: 400px;
            padding: 10px 40px;
            background: #009edf;
            color: #FFF;
            text-shadow: none;
            -webkit-box-shadow: 0px 3px 5px 0px rgba(0, 0, 0, 0.31);
            -moz-box-shadow: 0px 3px 5px 0px rgba(0, 0, 0, 0.31);
            box-shadow: 0px 3px 5px 0px rgba(0, 0, 0, 0.31);

        }

        span.input-group-addon i {
            color: #009edf;
            font-size: 17px;
        }

        .login-button {
            margin-top: 5px;
        }

        .login-register {
            font-size: 11px;
            text-align: center;
        }

        .register-help {
            font-size: 12px;
        }
    </style>
</head>

<body>

<div class="site-wrapper">
    <div class="container">
        <div class="row main">
            <div class="main-login main-center">
                <h4>Prije izrade web stranice potrebno je obaviti proces registracije.</h4>

                <form:form method="POST" modelAttribute="user" class="form-signin">

                    <input type="hidden" name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>

                    <div class="form-group">
                        <label for="firstName" class="cols-sm-2 control-label">Tvoje ime</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                                <spring:bind path="firstName">
                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                        <form:errors path="firstName"/>
                                        <form:input type="text" path="firstName" class="form-control"
                                                    placeholder="Upiši svoje ime" autofocus="true"/>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lastName" class="cols-sm-2 control-label">Tvoje prezime</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user fa" aria-hidden="true"></i></span>
                                <spring:bind path="lastName">
                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                        <form:errors path="lastName"/>
                                        <form:input type="text" path="lastName" class="form-control"
                                                    placeholder="Upiši svoje prezime" autofocus="true"/>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email" class="cols-sm-2 control-label">Tvoj email</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-envelope fa"
                                                                   aria-hidden="true"></i></span>
                                <spring:bind path="email">
                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                        <form:errors path="email"/>
                                        <form:input type="text" path="email" class="form-control"
                                                    placeholder="Upiši svoju email adresu" autofocus="true"/>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="username" class="cols-sm-2 control-label">Korisničko ime</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-users fa" aria-hidden="true"></i></span>
                                <spring:bind path="username">
                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                        <form:errors path="username"/>
                                        <form:input type="text" path="username" class="form-control"
                                                    placeholder="Korisničko ime" autofocus="true"/>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password" class="cols-sm-2 control-label">Lozinka</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-lock fa-lg"
                                                                   aria-hidden="true"></i></span>
                                <spring:bind path="password">
                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                        <form:errors path="password"/>
                                        <form:input type="password" path="password" class="form-control"
                                                    placeholder="Upiši svoju lozinku" autofocus="true"/>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="passwordConfirm" class="cols-sm-2 control-label">Potvrdi lozinku</label>
                        <div class="cols-sm-10">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-lock fa-lg"
                                                                   aria-hidden="true"></i></span>
                                <spring:bind path="passwordConfirm">
                                    <div class="form-group ${status.error ? 'has-error' : ''}">
                                        <form:errors path="passwordConfirm"/>
                                        <form:input type="password" path="passwordConfirm" class="form-control"
                                                    placeholder="Ponovno upiši svoju lozinku" autofocus="true"/>
                                    </div>
                                </spring:bind>
                            </div>
                        </div>
                    </div>

                    <div class="form-group ">
                        <input type="submit" id="button" class="btn btn-primary btn-lg btn-block login-button"
                               value="Registriraj se"/>
                    </div>

                </form:form>

                <div class="register-help">
                    <a href="<c:url value="/"/>">Početna</a> -
                    <a href="<c:url value="/login"/>">Prijava</a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<c:url value="/resources/home2/jquery.js"/>"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="<c:url value="/resources/home2/bootstrap.js"/>"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="<c:url value="/resources/home2/ie10-viewport-bug-workaround.js"/>"></script>

</body>
</html>
