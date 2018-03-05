<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<body>
<div style="border: dashed; background-color: #67B3FF">
    <h3 style="text-align: center">This is the preview of your website! You selected template 1!</h3>
</div>
<br>

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

        <div class="col-3 " style="float:left;">
            <c:if test="${img0exists == true}">
                <img id="firstImage" src="data:image/png;base64,${img0data}"/>
            </c:if>
        </div>
        <div class="col-6" id="pagetit" style="min-height: 150px; float: none;
                font-family: ${txt0font}; background-color: ${txt0background}">
            ${textarea0}
        </div>
        <div class="col-3" style="float:right; ">
            <div style="width: 100%; height: 100%">
                <c:if test="${img1exists == true}">
                    <img id="secondImage" src="data:image/png;base64,${img1data}"/>
                </c:if>
            </div>
        </div>
    </div>
    <div class="row" style="border: solid; font-family: ${txt1font}; background-color: ${txt1background}">
        ${textarea1}
    </div>
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