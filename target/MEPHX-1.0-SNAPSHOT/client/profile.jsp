<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<%
  Cookie[] authCookie = request.getCookies();
  User user;
  ValidateCredentials vc = new ValidateCredentials();

  try {
    user = vc.checkCookie(authCookie);
    if (user == null) {
      response.sendRedirect(request.getContextPath() + "/index.jsp");
      return;
    }
    request.setAttribute("user", user);
  } catch (SQLException | ClassNotFoundException e) {
    throw new RuntimeException(e);
  }
%>
<html>
<head>
  <title>MEPHX Profile | <%=user.getFirst_name().toUpperCase()%>
  </title>
  <link rel="stylesheet" type="text/css" href="../css/globals.css"/>
  <script
          src="https://kit.fontawesome.com/86f6b8ce70.js"
          crossorigin="anonymous"
  ></script>
</head>
<body class="bg-bg font-urbanist">
<%--Navbar--%>
<%@ include file="./components/layout/navbar.jsp" %>
<%--Container--%>
<div class="w-full pt-[72px]">
  <!-- Main -->
  <div class="flex w-full overflow-hidden text-white">
    <div class="max-w-[1440px] w-full flex mx-auto">
      <div class="w-full flex p-[40px] gap-4">
        <!-- My-Profile Section -->
        <%@include file="./components/profile/my-profile.jsp" %>
        <!-- My-Account Section -->
        <%@include file="./components/profile/my-account.jsp" %>
      </div>
    </div>
  </div>
  <%--Footer--%>
  <%@include file="components/layout/footer.jsp" %>
</body>
</html>