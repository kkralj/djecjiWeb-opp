<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Dječji WEB</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/resources/css/bootstrap.min.css"/>" rel="stylesheet">
</head>

<body>

<style>
    img {
        width: 50%;
        height: 50%;
    }
</style>

<div class="container">
    <div class="row-fluid">
        <div class="col-xs-6">
            <c:if test="${img0exists == true}">
                <img id="firstImage" src="<c:url value="/resources/images/public/${siteId}-0.png"/>" alt="image"/>
            </c:if>
        </div>
        <div class="col-xs-6" style="font-family: ${txt0font}; background-color: ${txt0background}">
            ${textarea0}
        </div>
    </div>
    <div class="row-fluid">
        <div class="col-xs-6" style="font-family: ${txt1font}; background-color: ${txt1background}">
            ${textarea1}
        </div>
        <div class="col-xs-6" style="font-family: ${txt2font}; background-color: ${txt2background}">
            ${textarea2}
        </div>
    </div>
</div>

</body>
</html>