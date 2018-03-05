<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="false" %>

<html lang="en">
<!DOCTYPE html>
<meta charset="UTF-8">

<head>
    <title>Upute za korištenje</title>

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

<style>
    img {
        width: 50%;
        height: 50%;
    }
</style>

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
                            <li><a href="<c:url value="/"/>">Početna</a></li>
                            <li class="active"><a href="#">Upute za korištenje</a></li>
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
                <h2 class="cover-heading">Upute za korištenje sustava</h2>
                <br>
                <p align="justify" style="font-size: 130%">
                    Sustav Dječji WEB namijenjen je za izradu jednostavnih web stranica. Pri tome
                    su ciljni korisnici upravo djeca, ali nadamo se da će poslužiti i ostalima.
                    Korištenje je vrlo jednostavno. Prije izrade web stranice, potrebno je registrirati se u sustav.
                    <%--<img id="pocetna" src="<c:out value="/resources/images/about/pocetna.png"/>" alt="image"/> <br>--%>
                    Na početnoj stranici ponuđena su dva gumba. Kliknite <b>Registracija</b>.
                    <%--<img id="registracija" src="<c:out value="/resources/images/about/registracija.png"/>" alt="image"/> <br>--%>
                    Nakon toga, prikazat će se forma za registraciju. Potrebno je ispuniti sve podatke. Korisničko ime i
                    email moraju biti jedinstveni.
                    <%--<img id="login" src="<c:out value="/resources/images/about/login.png"/>" alt="image"/> <br>--%>
                    Nakon uspješne registracije, ponovo ćete doći na početnu stranicu na kojoj pritisnite gumb
                    <b>Prijava</b>.
                    Upišite korisničko ime i lozinku s kojima ste se registrirali.
                    <%--<img id="pocetna_korisnik" src="<c:out value="/resources/images/about/pocetna_korisnik.png"/>" alt="image"/>--%>
                    Sada se nalazite na početnoj stranici prijavljenog korisnika. Imate mogućnost pregleda stranice,
                    uređivanja ili odjave.
                    <%--<img id="uredjivanje" src="<c:out value="/resources/images/about/uredjivanje.png"/>" alt="image"/> <br>--%>
                    Na stranici za uređivanje imate mogućnost dodavanja slike ili uređivanja teksta. Kako biste dodali
                    sliku, kliknite na okvir slike nakon što se prikaže znak '+' te odaberite sliku s vašeg računala.
                    Tekst
                    uređujete u uređivaču tekstu s ponuđenim mogućnostima.</p>
            </div>


</body>

</html>
