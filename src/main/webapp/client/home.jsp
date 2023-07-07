<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  Cookie[] authCookie = request.getCookies();
  User user;
  ValidateCredentials vc = new ValidateCredentials();

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
  <title>MEPHX | Home</title>
  <link rel="stylesheet" type="text/css" href="../css/globals.css"/>
  <script
          src="https://kit.fontawesome.com/86f6b8ce70.js"
          crossorigin="anonymous"
  ></script>
</head>
<body class="bg-bg font-urbanist">
<%--Navbar--%>
<%@ include file="components/layout/navbar.jsp" %>
<%--Container--%>
<div class="flex w-full pt-[72px]">
  <%--Sidebar--%>
  <%@include file="components/layout/sidebar.jsp" %>
  <!-- Main -->
  <div class="pl-[15px] w-full overflow-hidden">
    <div class="w-[calc(100%-200px)]">
      <!-- Hero -->
      <%@include file="components/home/hero.jsp" %>
      <!-- Brands -->
      <%@include file="components/home/brand-ribbon.jsp" %>
      <!-- New at MEPHX -->
      <jsp:include page="components/recommendation-section.jsp">
        <jsp:param name="title" value="New at MEPHX"/>
        <jsp:param name="section-filter" value="new"/>
        <jsp:param name="filter-id" value=""/>
        <jsp:param name="filter_slug" value="filterType=new"/>
      </jsp:include>
      <%
        int catCount = 0;
        if(categories != null) {
          for (Category category : categories) {
            catCount++;
            if (catCount > 3) break;
            String slug = "categoryId="+ category.getId();
      %>
      <!-- Men's Deals -->
      <jsp:include page="components/recommendation-section.jsp">
        <jsp:param name="title" value="<%=category.getName()%>"/>
        <jsp:param name="section-filter" value="category"/>
        <jsp:param name="filter-id" value="<%=category.getId()%>"/>
        <jsp:param name="filter_slug" value="<%=slug%>"/>
      </jsp:include>
      <%
          }
        }
      %>
      <!-- Brand Deals -->
      <%
        int brandCount = 0;
        if(categories != null) {
          for (Brand brand : brands) {
            brandCount++;
            if (brandCount > 3) break;
            String slug = "brandId="+ brand.getId();
      %>
      <jsp:include page="components/recommendation-section.jsp">
        <jsp:param name="title" value="<%=brand.getName()%>"/>
        <jsp:param name="section-filter" value="brand"/>
        <jsp:param name="filter-id" value="<%=brand.getId()%>"/>
        <jsp:param name="filter_slug" value="<%=slug%>"/>
      </jsp:include>
      <%
            }
          }
      %>
    </div>
  </div>
</div>
<%--Footer--%>
<%@include file="components/layout/footer.jsp" %>
</body>
</html>