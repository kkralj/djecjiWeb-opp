<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

<spring:htmlEscape defaultHtmlEscape="true"/>
<head>

    <sec:csrfMetaTags/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <link type="text/css" rel="stylesheet" href="demo.css">
    <link type="text/css" rel="stylesheet" href="<c:out value="/resources/jqte/jquery-te-1.4.0.css"/>">

    <script type="text/javascript" src="http://code.jquery.com/jquery.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="/resources/jqte/jquery-te-1.4.0.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="<c:out value="/resources/js/jscolor.js"/>" charset="utf-8"></script>
    <sec:csrfMetaTags/>

    <style>
        .custom-jqte1 .jqte {
            margin-left: 10px;
            margin-right: 10px;
        }

        .custom-jqte2 .jqte_editor * {
            /*font-family: "Courier New", Courier, monospace;*/
        }

        .custom-jqte1 .jqte_editor, .jqte_source {
            background-color: orange;
        }

        .custom-jqte1 .jqte_editor * {
            font-family: "Times New Roman", Times, serif;
        }

        img {
            width: 100%;
            height: 100%
        }

        .col-3 {
            width: 25%;
            height: 250px;
            display: inline-block;
        }

        .col-6 {
            width: 50%;
            height: 250px;
            display: inline-block;
        }

        body {
            background: #e7e7e7;
        }

        #box1, #box2 {
            width: 300px;
            height: 200px;
            box-shadow: inset 1px 1px 40px 0 rgba(0, 0, 0, .45);
            margin: 5% auto 0 auto;
            background: url(http://ianfarb.com/wp-content/uploads/2013/10/nicholas-hodag.jpg);
            background-size: cover;
            border-radius: 5px;
            overflow: hidden;
        }

        #overlay1, #overlay2 {
            background: rgba(0, 0, 0, .75);
            text-align: center;
            padding: 45px 0 66px 0;
            opacity: 0;
            -webkit-transition: opacity .25s ease;
            -moz-transition: opacity .25s ease;
        }

        #box1:hover #overlay1, #box2:hover #overlay2 {
            opacity: 1;
        }

        #plus1, #plus2 {
            font-weight: 900;
            color: rgba(255, 255, 255, .85);
            font-size: 96px;
        }

    </style>
</head>
<body>

<style>

</style>

<div class="container">
    <div class="row">
        <div class="col-3" style="float:left">
            <label for="image1">
                <input type="file" name="image" form="dataForm" id="image1" style="display:none;"/>
                <div id="box1">
                    <div id="overlay1">
                        <span id="plus1">+</span>
                    </div>
                </div>
            </label>
        </div>
        <div class="col-6">
            <div class="custom-jqte1" id="lol">
                <textarea name="textarea" class="starea1">${textarea1}</textarea>
            </div>
        </div>
        <div class="col-3" style="float:right">
            <label for="image2">
                <input type="file" name="image" form="dataForm" id="image2" style="display:none;"/>
                <div id="box2">
                    <div id="overlay2">
                        <span id="plus2">+</span>
                    </div>
                </div>
            </label>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        updateStr("#ababab", 1);
        <%--updateStr(${txt1background}, 2);--%>
    })

    function updateStr(jscolor, name) {
        $('.custom-jqte' + name + ' .jqte_editor, .jqte_source').css('background-color', jscolor);

        if (name == 1) {
            color1 = jscolor;
        } else {
            color2 = jscolor;
        }
    }
</script>

<input class="jscolor {onFineChange:'update(this)'}" value="aaaaaa" id="color1">
<%--<p id="rect" style="border:1px solid gray; width:161px; height:100px;">--%>

<script>
    function update(jscolor) {
        $('.custom-jqte1 .jqte_editor, .jqte_source').css('background-color', '#' + jscolor);
    }
</script>

<div id="output-text">
    hello folks
</div>

<select id="input-font" class="input" onchange="changeFont (this);">
    <option value="Times New Roman" selected="selected">Times New Roman</option>
    <option value="Arial">Arial</option>
    <option value="Courier New, Courier, monospace">new century schoolbook</option>
</select>
<br>

<script>
    function changeFont(font) {
        document.getElementById("output-text").style.fontFamily = font.value;

        $('.custom-jqte1 .jqte_editor *').css('font-family', font.value);
//        $('.custom-jqte1 .jqte_editor, .jqte_source').css('background', 'blue');
    }
</script>

<div class="custom-jqte2">
    <textarea name="textarea" class="starea2">${textarea2}</textarea>
</div>

<div id="tarea-1"></div>
<div id="tarea-2"></div>

<script type="text/javascript">
    $('.starea1').jqte();
    $('.starea2').jqte();

    function getTextAreaContent() {
        var content1 = $('.starea1').val();
        var content2 = $('.starea2').val();

        document.getElementById("tarea1").value = content1;
        document.getElementById("tarea2").value = content2;
    }
</script>

<form:form id="dataForm" htmlEscape="true" method="post" enctype="multipart/form-data">

    <%--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>

    <input type="hidden" name="templateId" value="1">
    <input type="hidden" name="tarea" id="tarea1">
    <input type="hidden" name="tarea" id="tarea2">

    <input type="submit" name="action" value="Preview"
           formaction="${pageContext.request.contextPath}/preview"
           formtarget="_blank"
           onClick="getTextAreaContent()"/>

    <input type="submit" name="action" value="Save preview"
           formaction="${pageContext.request.contextPath}/preview/save"
           onClick="getTextAreaContent()"/>

    <a href="${pageContext.request.contextPath}/">Cancel</a>

    <input type="submit" name="action" value="Publish"
           formaction="${pageContext.request.contextPath}/preview/publish"
           onClick="getTextAreaContent()"/>
</form:form>

<a target="_blank" href="${pageContext.request.contextPath}/view/${username}">View public</a>

</body>
</html>