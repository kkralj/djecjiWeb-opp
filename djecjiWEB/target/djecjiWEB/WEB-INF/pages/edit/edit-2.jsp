<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>

<spring:htmlEscape defaultHtmlEscape="true"/>

<head>
    <sec:csrfMetaTags/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

    <script class="jsbin" src="<c:url value="/resources/jqte/jquery.min.js"/>"></script>
    <link type="text/css" rel="stylesheet" href="<c:url value="/resources/jqte/jquery-te-1.4.0.css"/>">

    <%--<script type="text/javascript" src="http://code.jquery.com/jquery.min.js" charset="utf-8"></script>--%>

    <script type="text/javascript" src="<c:url value="/resources/js/jscolor.js"/>" charset="utf-8"></script>
    <script type="text/javascript" src="<c:url value="/resources/jqte/jquery-te-1.4.0.min.js"/>"
            charset="utf-8"></script>

    <sec:csrfMetaTags/>

    <style>
        .custom-jqte1 .jqte {
            margin-left: 10px;
            margin-right: 10px;
        }

        .custom-jqte2 .jqte {
        }

        .row {
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        img {
            width: 50%;
            height: 50%;
        }

        body {
            background: #e7e7e7;
        }

        #box1, #box2 {
            width: 300px;
            height: 200px;
            box-shadow: inset 1px 1px 40px 0 rgba(0, 0, 0, .45);
            margin: 5% auto 0 auto;
            /*background: url(http://ianfarb.com/wp-content/uploads/2013/10/nicholas-hodag.jpg);*/
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

    <style>

        .blackshadowtext {
            font-size: 40px;
            color: #fff;
            text-shadow: 1px 0 0 #000, 0 -1px 0 #000, 0 1px 0 #000, -1px 0 0 #000;
        }

        .divhover {
            height: 200px;
            line-height: 200px;
            text-align: center;
        }

        .spanhover {
            display: inline-block;
            vertical-align: middle;
            line-height: normal;
        }

        .hovereffect {
            width: 100%;
            height: 100%;
            float: left;
            overflow: hidden;
            position: relative;
            text-align: center;
            cursor: default;
        }

        .hovereffect .overlay {
            position: absolute;
            overflow: hidden;
            width: 80%;
            height: 80%;
            left: 10%;
            top: 10%;
            border-bottom: 1px solid #FFF;
            border-top: 1px solid #FFF;
            -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
            transition: opacity 0.35s, transform 0.35s;
            -webkit-transform: scale(0, 1);
            -ms-transform: scale(0, 1);
            transform: scale(0, 1);
        }

        .hovereffect:hover .overlay {
            opacity: 1;
            filter: alpha(opacity=100);
            -webkit-transform: scale(1);
            -ms-transform: scale(1);
            transform: scale(1);
        }

        .hovereffect img {
            display: block;
            position: relative;
            -webkit-transition: all 0.35s;
            transition: all 0.35s;
        }

        .hovereffect:hover img {
            filter: url('data:image/svg+xml;charset=utf-8,<svg xmlns="http://www.w3.org/2000/svg"><filter id="filter"><feComponentTransfer color-interpolation-filters="sRGB"><feFuncR type="linear" slope="0.6" /><feFuncG type="linear" slope="0.6" /><feFuncB type="linear" slope="0.6" /></feComponentTransfer></filter></svg>#filter');
            filter: brightness(0.6);
            -webkit-filter: brightness(0.6);
        }

        .hovereffect h2 {
            text-transform: uppercase;
            text-align: center;
            position: relative;
            font-size: 17px;
            background-color: transparent;
            color: #FFF;
            padding: 1em 0;
            opacity: 0;
            filter: alpha(opacity=0);
            -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
            transition: opacity 0.35s, transform 0.35s;
            -webkit-transform: translate3d(0, -100%, 0);
            transform: translate3d(0, -100%, 0);
        }

        .hovereffect a, .hovereffect p {
            color: #FFF;
            padding: 1em 0;
            opacity: 0;
            filter: alpha(opacity=0);
            -webkit-transition: opacity 0.35s, -webkit-transform 0.35s;
            transition: opacity 0.35s, transform 0.35s;
            -webkit-transform: translate3d(0, 100%, 0);
            transform: translate3d(0, 100%, 0);
        }

        .hovereffect:hover a, .hovereffect:hover p, .hovereffect:hover h2 {
            opacity: 1;
            filter: alpha(opacity=100);
            -webkit-transform: translate3d(0, 0, 0);
            transform: translate3d(0, 0, 0);
        }
    </style>
</head>
<body>

<script>
    var font1, font2;
    var color1, color2;

    function readURL(input, attr) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#' + attr)
                        .attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    function update(jscolor, name) {
        $('.custom-jqte' + name + ' .jqte_editor, .jqte_source').css('background-color', jscolor.toHEXString());

        if (name == 1) {
            color1 = jscolor.toHEXString();
        } else {
            color2 = jscolor.toHEXString();
        }
    }

    function changeFont(font, name) {
        $('.custom-jqte' + name + ' .jqte_editor *').css('font-family', font.value);
        if (name == 1) {
            font1 = font.value;
        } else {
            font2 = font.value;
        }
    }
</script>

Change template:
<a href="${pageContext.request.contextPath}/edit/1">Template 1</a>
<a href="${pageContext.request.contextPath}/edit/3">Template 3</a>

<div class="container">
    <div class="row">
        <div class="row" id="pagetit" style="border: solid;">
            <div class="custom-jqte1">
                <textarea name="textarea" class="starea1">${textarea0}</textarea>
            </div>
            <div style="margin-right: auto; margin-left: auto; width: 75%;">
                <label>Background color:</label>
                <input class="jscolor {onFineChange:'update(this, 1)'}" id="color1uqn"
                       value="${fn:substring(txt0background, 1, 7)}">
                <label>Font:</label>
                <select id="input-font1" class="input" onload="changeFont(this, 1)" onchange="changeFont(this, 1);">
                    <option value="Times New Roman">Times New Roman</option>
                    <option value="Arial" selected="selected">Arial</option>
                    <option value="Courier New, Courier, monospace">Courier New</option>
                </select>
            </div>
        </div>

        <div class="row">
            <label for="image1">
                <input type="file" name="image" form="dataForm" id="image1" style="display:none;"/>
                <div id="box1">
                    <div id="overlay1">
                        <span id="plus1">+</span>
                    </div>
                </div>
            </label>
        </div>

        <div class="row">
            <div>
                <div class="custom-jqte2">
                    <textarea name="textarea" class="starea2">${textarea1}</textarea>
                </div>
                <div style="margin-right: auto; margin-left: auto; width: 100%;">
                    <label>Background color:</label>
                    <input class="jscolor {onFineChange:'update(this, 2)'}" id="color2uqn"
                           value="${fn:substring(txt1background, 1, 7)}">
                    <label>Font:</label>
                    <select id="input-font2" class="input" onload="changeFont(this, 2)" onchange="changeFont(this, 2);">
                        <option value="Times New Roman">Times New Roman</option>
                        <option value="Arial" selected="selected">Arial</option>
                        <option value="Courier New, Courier, monospace">Courier New</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="row">
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

<script type="text/javascript">
    $('.starea1').jqte();
    $('.starea2').jqte();

    function getTextAreaContent() {
        content1 = $('.starea1').val();
        content2 = $('.starea2').val();

        document.getElementById("tarea1").value = content1;
        document.getElementById("tarea2").value = content2;

        document.getElementById("carea1").value = color1;
        document.getElementById("carea2").value = color2;

        document.getElementById("farea1").value = font1;
        document.getElementById("farea2").value = font2;
    }
</script>

<script>
    window.onload = function () {
        document.getElementById('color1uqn').jscolor.fromString('' + "${fn:substring(txt0background, 1, 7)}");
        update(document.getElementById('color1uqn').jscolor, 1);

        document.getElementById('color2uqn').jscolor.fromString('' + "${fn:substring(txt1background, 1, 7)}");
        update(document.getElementById('color2uqn').jscolor, 2);

        font1 = document.getElementById('input-font1').options[document.getElementById('input-font1').selectedIndex].text;
        font2 = document.getElementById('input-font2').options[document.getElementById('input-font2').selectedIndex].text;
    };
</script>

<br>
<form:form id="dataForm" htmlEscape="true" method="post" enctype="multipart/form-data">

    <%--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>

    <input type="hidden" name="templateId" value="2">
    <input type="hidden" name="tarea" id="tarea1">
    <input type="hidden" name="tarea" id="tarea2">

    <input type="hidden" name="carea" id="carea1">
    <input type="hidden" name="carea" id="carea2">

    <input type="hidden" name="farea" id="farea1">
    <input type="hidden" name="farea" id="farea2">

    <input type="hidden" name="siteId" id="siteId" value="${siteId}">

    <input type="submit" name="action" value="Pregled trenutne stranice"
           formaction="${pageContext.request.contextPath}/preview"
           formtarget="_blank"
           onClick="getTextAreaContent()"/>

    <input type="submit" name="action" value="Spremi trenutnu stranicu"
           formaction="${pageContext.request.contextPath}/preview/save"
           onClick="getTextAreaContent()"/>

    <a href="${pageContext.request.contextPath}/">Odustani</a>

    <input type="submit" name="action" value="Objavi trenutnu stranicu"
           formaction="${pageContext.request.contextPath}/preview/publish"
           onClick="getTextAreaContent()"/>

    <a href="${pageContext.request.contextPath}/edit/resetRequest">Zatraži resetiranje stranice</a>

    <a target="_blank" href="${pageContext.request.contextPath}/view/${username}">Pregled javne stranice</a>

    <a href="${pageContext.request.contextPath}/edit/setPublicAsPreview">Postavi javnu stranicu za predložak</a>

</form:form>

</body>
</html>