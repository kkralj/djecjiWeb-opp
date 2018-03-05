<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Admin | Lista korisnika</title>
</head>

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<div class="container-wrapper">
    <div class="container">
        <div class="page-header">
            <h1>Korisnici</h1>
            <p class="lead">Lista korisnika prikazana je ovdje!</p>
            <table class="table table-striped table-hover">
                <thead>
                <tr class="bg-success">
                    <th>Korisničko ime</th>
                    <th>Ime</th>
                    <th>Prezime</th>
                    <th>Email adresa</th>
                    <th>Zatražio resetiranje stranice</th>
                    <th></th>
                </tr>
                </thead>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.username}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.email}</td>
                        <td>${user.resetRequested == true? "Da" : "Ne"}</td>
                        <td>
                            <a href="<spring:url value="/admin/editUser/${user.username}"/>">
                                <span class="glyphicon glyphicon-pencil"/>
                            </a>
                            <a href="<spring:url value="/admin/removeUser/${user.username}"/>">
                                <span class="glyphicon glyphicon-remove"/>
                            </a>
                            <a href="<spring:url value="/admin/resetPage/${user.username}"/>">
                                <span class="glyphicon glyphicon-refresh"/>
                            </a>
                            <a target="_blank" href="<spring:url value="/view/${user.username}"/>">
                                <span class="glyphicon glyphicon-list-alt"/>
                            </a>
                            <a href="<spring:url value="/admin/userInfo/${user.username}"/>">
                                <span class="glyphicon glyphicon-info-sign"/>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>

            <a href="<spring:url value="/admin/addUser"/>" class="btn btn-primary">Dodaj novog korisnika</a>

<%@include file="/WEB-INF/pages/admin/includes/footer.jsp" %>