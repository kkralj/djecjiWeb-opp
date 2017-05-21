<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
    <title>Admin</title>
</head>

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<div class="container-wrapper">
    <div class="container">
        <div class="page-header">
            <h1>Administratorska stranica</h1>

            <p class="lead">Dobrodošli na administratorsku stranicu!</p>

            <h3>
                <a href="<c:url value="/admin/userList"/> ">Popis članova</a>
            </h3>

            <p>Ovdje možete upravljati trenutnim popisom članova!</p>

            <%@include file="/WEB-INF/pages/admin/includes/footer.jsp" %>
