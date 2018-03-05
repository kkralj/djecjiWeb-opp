<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<head>
    <title>Admin | Uredi korisnički račun</title>
</head>

<%@ include file="/WEB-INF/pages/admin/includes/header.jsp" %>

<div class="container-wrapper">
    <div class="container">
        <div class="page-header">
            <h1>Uređivanje korisničkog računa</h1>
            <p class="lead">Unesite nove informacije o korisničkom računu</p>

            <form:form method="POST" modelAttribute="user" class="form-signin">

            <input type="hidden" name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>

            <div class="form-group">
                <label for="firstName" class="cols-sm-2 control-label">Tvoje ime</label>
                <spring:bind path="firstName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <form:errors path="firstName"/>
                        <form:input type="text" path="firstName" class="form-control"
                                    placeholder="Upiši svoje ime" autofocus="true"
                                    value="${user.firstName}"
                        />
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <label for="lastName" class="cols-sm-2 control-label">Tvoje prezime</label>
                <spring:bind path="lastName">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <form:errors path="lastName"/>
                        <form:input type="text" path="lastName" class="form-control"
                                    placeholder="Upiši svoje prezime" autofocus="true"
                                    value="${user.lastName}"
                        />
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <label for="email" class="cols-sm-2 control-label">Tvoj email</label>
                <spring:bind path="email">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <form:errors path="email"/>
                        <form:input type="text" path="email" class="form-control"
                                    placeholder="Upiši svoju email adresu" autofocus="true"
                                    value="${user.email}"
                        />
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <label for="password" class="cols-sm-2 control-label">Lozinka</label>
                <spring:bind path="password">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <form:errors path="password"/>
                        <form:input type="password" path="password" class="form-control"
                                    placeholder="Upiši svoju lozinku" autofocus="true"
                        />
                    </div>
                </spring:bind>
            </div>

            <div class="form-group">
                <label for="passwordConfirm" class="cols-sm-2 control-label">Potvrdi lozinku</label>
                <spring:bind path="passwordConfirm">
                    <div class="form-group ${status.error ? 'has-error' : ''}">
                        <form:errors path="passwordConfirm"/>
                        <form:input type="password" path="passwordConfirm" class="form-control"
                                    placeholder="Ponovno upiši svoju lozinku" autofocus="true"/>
                    </div>
                </spring:bind>
            </div>

                <form:input type="hidden" path="updatingInformation" value="true" class="form-control"/>

            <div class="form-group ">
                <div class="cols-sm-4" style="width: 25%">
                    <input type="submit" id="button" class="btn btn-primary btn-lg btn-block login-button"
                           value="Ažuriraj podatke"/>
                </div>
            </div>

            <a href="<c:url value="/admin/userList"/>" class="btn btn-default">Odustani</a>

            </form:form>

<%@include file="/WEB-INF/pages/admin/includes/footer.jsp" %>