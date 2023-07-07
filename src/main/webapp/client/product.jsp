<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.model.Product" %>
<%@ page import="com.mephx.DAO.interfaces.ProductDAO" %>
<%@ page import="com.mephx.DAO.implementations.ProductDAOImpl" %>
<!DOCTYPE html>
<html lang="en">
<%
  User user;
  Product product;
  Integer id = Integer.parseInt(request.getParameter("productId"));
  ProductDAO productDAO = new ProductDAOImpl();
  Cookie[] authCookie = request.getCookies();
  ValidateCredentials vc = new ValidateCredentials();

  try {
    user = vc.checkCookie(authCookie);
    if (user != null) {
      request.setAttribute("user", user);
    }
    product = productDAO.getProductById(id);
    if (product == null) {
      response.sendRedirect("/404");
      return;
    }
  } catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
    throw new RuntimeException(e);
  }
%>
<head>
  <meta charset="UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>MEPHX | Product</title>
  <link rel="stylesheet" type="text/css" href="../css/globals.css"/>
  <script
          src="https://kit.fontawesome.com/86f6b8ce70.js"
          crossorigin="anonymous"
  ></script>
</head>
<body class="bg-bg font-urbanist">
<!-- Navbar -->
<%@ include file="./components/layout/navbar.jsp" %>
<!-- Container -->
<div class="flex w-full pt-[72px]">
  <!-- Sidebar -->
  <%@include file="./components/layout/sidebar.jsp" %>
  <!-- Main -->
  <div class="pl-[15px] w-full overflow-hidden">
    <div class="w-[calc(100%-200px)]">
      <div class="w-full flex justify-between py-[20px] gap-x-8">
        <!-- Product Images -->
        <%@include file="./components/product/product-image-grid.jsp" %>
        <!-- Product Buy Card -->
        <%@include file="./components/product/product-buy-card.jsp" %>
      </div>
      <!-- Product Description -->
      <div>
        <h1 class="text-neutral-100 text-[28px] font-semibold">
          Product Description
        </h1>
        <p class="text-neutral-200 p-5 max-w-[700px] w-full">
          <%=product.getDescription()%>
        </p>
      </div>
      <!-- Product you may like section -->
      <%!
        String title = "More products from ";
      %>
      <jsp:include page="./components/recommendation-section.jsp">
        <jsp:param name="title" value="<%= title + product.getBrand().getName()%>" />
        <jsp:param name="section-filter" value="brand"/>
        <jsp:param name="filter-id" value="<%=product.getBrand().getId()%>"/>
      </jsp:include>
    </div>
  </div>
</div>
<%--Footer--%>
<%@include file="components/layout/footer.jsp" %>
</body>
</html>
