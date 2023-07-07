<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Cookie[] authCookie = request.getCookies();
    User user;
    ValidateCredentials vc = new ValidateCredentials();
    String brandId = request.getParameter("brandId") == null ? "" : request.getParameter("brandId");
    String categoryId = request.getParameter("categoryId") == null ? "" : request.getParameter("categoryId");
    String filterType = request.getParameter("filterType") == null ? "" : request.getParameter("filterType");
    String listBy = request.getParameter("listBy") == null ? "" : request.getParameter("listBy");

    try {
        user = vc.checkCookie(authCookie);
        if (user != null) {
            request.setAttribute("user", user);
        }
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>MEPHX | Catalog</title>
    <link rel="stylesheet" type="text/css" href="../css/globals.css"/>
    <script
            src="https://kit.fontawesome.com/86f6b8ce70.js"
            crossorigin="anonymous"
    ></script>
</head>
<body class="bg-bg font-urbanist">
<!--NavBar-->
<%@ include file="components/layout/navbar.jsp" %>
<%--Container--%>
<div class="flex w-full pt-[72px]">
    <!-- Page and Filter Info -->
    <div style="max-width: 275px" class=" w-full bg-bg h-screen px-4 flex-shrink-0 py-[40px]">
        <%@include file="components/catalog/product-filter-card.jsp"%>
    </div>
    <!-- container for product display-->
    <div class="pl-[15px] w-full flex justify-center overflow-hidden py-[40px]">
        <div class="w-[calc(100%-200px)] space-y-8">
            <!-- card -->
            <jsp:include page="components/catalog/product-card-catalog.jsp">
                <jsp:param name="brandId" value="<%=brandId%>"/>
                <jsp:param name="categoryId" value="<%=categoryId%>"/>
                <jsp:param name="filterType" value="<%=filterType%>"/>
                <jsp:param name="listBy" value="<%=listBy%>"/>
            </jsp:include>
        </div>
    </div>
</div>

<!-- Footer -->
<%@include file="components/layout/footer.jsp" %>
</body>

</html>
