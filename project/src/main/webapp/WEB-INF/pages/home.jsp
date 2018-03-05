<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<html lang="en">
<!DOCTYPE html>
<meta charset="UTF-8">

<head>
    <title>Početna</title>

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
        }
    </style>

    <style>

        .button {
            -webkit-box-flex: 1;
            -webkit-flex: 1 1 auto;
            -ms-flex: 1 1 auto;
            flex: 1 1 auto;
            margin: 10px;
            padding: 20px;
            border: 2px solid #f7f7f7;
            text-align: center;
            text-transform: uppercase;
            position: relative;
            overflow: hidden;
            -webkit-transition: .3s;
            transition: .3s;
        }

        .button:after {
            position: absolute;
            -webkit-transition: .3s;
            transition: .3s;
            content: '';
            width: 0;
            left: 50%;
            bottom: 0;
            height: 3px;
            background: #f7f7f7;
        }

        .button:nth-of-type(2):after {
            left: 0;
        }

        .button:nth-of-type(3):after {
            right: 0;
            left: auto;
        }

        .button:nth-of-type(4):after {
            left: 0;
            bottom: auto;
            top: -3px;
            width: 100%;
        }

        .button:nth-of-type(5):after {
            height: 120%;
            left: -10%;
            -webkit-transform: skewX(15deg);
            -ms-transform: skewX(15deg);
            transform: skewX(15deg);
            z-index: -1;
        }

        .button:hover {
            cursor: pointer;
        }

        .button:hover:after {
            width: 100%;
            left: 0;
        }

        .button:hover:nth-of-type(4):after {
            top: calc(100% - 3px);
        }

        .button:hover:nth-of-type(5) {
            color: #5bcaff;
        }

        .button:hover:nth-of-type(5):after {
            left: -10%;
            width: 120%;
        }

        .button:hover:nth-of-type(6) {
            -webkit-box-flex: 3;
            -webkit-flex-grow: 3;
            -ms-flex-positive: 3;
            flex-grow: 3;
        }

        .button:hover:nth-of-type(6):after {
            width: 0%;
        }

        .button:hover:nth-of-type(7) {
            border-radius: 30px;
        }

        .button:hover:nth-of-type(7):after {
            width: 0%;
        }

        .button:hover:nth-of-type(8) {
            -webkit-transform: scale(1.2);
            -ms-transform: scale(1.2);
            transform: scale(1.2);
        }

        .button:hover:nth-of-type(8):after {
            width: 0%;
        }

        .button:hover:nth-of-type(9) {
            box-shadow: inset 0px 0px 0px 3px #f7f7f7;
        }

        .button:hover:nth-of-type(9):after {
            width: 0%;
        }

        .button:hover:nth-of-type(10) {
            box-shadow: 0px 0px 0px 3px #f7f7f7;
        }

        .button:hover:nth-of-type(10):after {
            width: 0%;
        }

        #outerrr {
            width: 100%;
            text-align: center;
        }

        .innerrr {
            display: inline-block;
        }
    </style>



    <title>DjecjiWEB</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/home2/bootstrap.css"/>" rel="stylesheet">

    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="<c:url value="/resources/home2/ie10-viewport-bug-workaround.css"/>" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<c:url value="/resources/home2/cover.css"/>" rel="stylesheet">

    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]>
    <script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="<c:url value="/resources/home2/ie-emulation-modes-warning.js"/>"></script>

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<script>
    function formSubmit() {
        document.getElementById("logoutForm").submit();
    }
</script>


<div class="site-wrapper">
    <div class="site-wrapper-inner">
        <div class="cover-container">
            <div class="masthead clearfix">
                <div class="inner">
                    <h3 class="masthead-brand">Dječji Web</h3>
                    <nav>
                        <ul class="nav masthead-nav">
                            <li class="active"><a href="#">Početna</a></li>
                            <li><a href="<c:url value="/about"/>">Upute za korištenje</a></li>
                            <sec:authorize access="hasRole('ROLE_ADMIN')">
                                <li><a href="<c:url value="/admin"/>"> Admin panel</a></li>
                            </sec:authorize>
                            <sec:authorize access="hasRole('ROLE_USER')">
                                <li><a href="javascript:formSubmit()">Odjava</a></li>
                                <c:url value="/logout" var="logoutUrl"/>
                                <form action="${logoutUrl}" method="post" id="logoutForm">
                                    <input type="hidden" name="${_csrf.parameterName}"
                                           value="${_csrf.token}"/>
                                </form>
                            </sec:authorize>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="inner cover">
                <sec:authorize access="!hasRole('ROLE_USER')">
                    <h1 class="cover-heading">Dobrodošli</h1>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_USER')">
                    <h1 class="cover-heading">Dobrodošli, ${pageContext.request.userPrincipal.name}</h1>
                </sec:authorize>

                <p class="lead">Ovo je početna stranica sustava za izradu web stranica za djecu.</p>

                <p class="lead">
                    <security:authorize access="!hasRole('ROLE_USER')">
                        <a href="<c:url value="/login"/>"
                           class="btn btn-lg btn-default">Prijava</a>
                        <a href="<c:url value="/register"/>"
                           class="btn btn-lg btn-default">Registracija</a>
                    </security:authorize>
                </p>
                <sec:authorize access="hasRole('ROLE_USER')">
                    <!-- For logged user -->
                    <c:if test="${pageContext.request.userPrincipal.name != null}">
                        <div class="inner cover">
                            <div id="outerrr">
                                <div class="innerrr">
                                    <div class="button" onclick="window.open('<c:url value="/view/${user}"/>')">
                                        Pregledaj svoju web-stranicu
                                    </div>
                                </div>
                                <div class="innerrr">
                                    <div class="button" onclick="location.href='<c:url value="/edit"/>'">
                                        Uredi svoju web-stranicu
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </sec:authorize>
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
