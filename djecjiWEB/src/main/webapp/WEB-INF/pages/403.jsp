<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<h1>HTTP Status 403 - Nemate pravo pristupa</h1>

<c:choose>
    <c:when test="${empty username}">
        <h2>Nemate pravo pristupa ovoj stranici!</h2>
    </c:when>
    <c:otherwise>
        <h2>Korisničko ime : ${username} <br/>Nemate pravo pristupa ovoj stranici!</h2>
    </c:otherwise>
</c:choose>
</body>
</html>