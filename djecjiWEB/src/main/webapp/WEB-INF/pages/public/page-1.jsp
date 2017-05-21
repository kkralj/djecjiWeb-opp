<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<body>

<style>
    img {
        width: 100%;
        height: 100%;
    }

    .col-3 {
        width: 25%;
        vertical-align: top;
        display: inline-block;
    }

    .col-6 {
        width: 50%;
        vertical-align: top;
        display: inline-block;
    }
</style>

<div class="container">
    <div class="row" style="border: solid;">

        <div class="col-3" style="float:left; ">
            <c:if test="${img0exists == true}">
                <img id="firstImage" src="<c:url value="/resources/images/public/${siteId}-0.png"/>" alt="image"/>
            </c:if>
        </div>
        <div class="col-6" id="pagetit" style="min-height: 150px; float: none; background-color: ${txt0background};">
            ${textarea0}
        </div>
        <div class="col-3" style="float:right; ">
            <c:if test="${img1exists == true}">
                <img id="secondImage" src="<c:url value="/resources/images/public/${siteId}-1.png"/>" alt="image"/>
            </c:if>
        </div>
    </div>
</div>
<div class="row" style="border: solid; background-color: ${txt1background};">
    ${textarea1}
</div>

<br>

<script>
    document.getElementById('firstImage').setAttribute("style",
            "height:" + document.getElementById('pagetit').offsetHeight + "px");

    document.getElementById('secondImage').setAttribute("style",
            "height:" + document.getElementById('pagetit').offsetHeight + "px");
</script>

</body>
</html>