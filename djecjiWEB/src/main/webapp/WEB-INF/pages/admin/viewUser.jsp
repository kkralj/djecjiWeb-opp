<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<div class="container-wrapper">
    <div class="container">
        <div class="page-header">
            <h1>Korisnički detalji</h1>
            <p class="lead">Ovdje možete vidjeti detalje korisničkog računa</p>
            <div class="container">
                <div class="row">
                    <div class="col-md-5">
                        <p><strong>Korisničko ime</strong> : ${user.username}</p>
                        <p><strong>Ime korisnika</strong> : ${user.firstName}</p>
                        <p><strong>Prezime korisnika</strong> : ${user.lastName}</p>
                        <p><strong>Email adresa</strong> : ${user.email}</p>
                        <a target="_blank " href="<spring:url value="/view/${user.username}"/>">Javna stranica</a>
                    </div>
                </div>
            </div>

<%@include file="/WEB-INF/pages/admin/includes/footer.jsp" %>