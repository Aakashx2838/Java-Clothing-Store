<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.DAO.interfaces.OrderDAO" %>
<%@ page import="com.mephx.DAO.implementations.OrderDAOImpl" %>
<%@ page import="com.mephx.model.UserOrderProductView" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
  Cookie[] authCookie = request.getCookies();
  User user;
  ValidateCredentials vc = new ValidateCredentials();

  try {
    user = vc.checkCookie(authCookie);
    if (user == null) {
      response.sendRedirect(request.getContextPath()+"/index.jsp");
      return;
    }
    request.setAttribute("user", user);
  } catch (SQLException | ClassNotFoundException e) {
    throw new RuntimeException(e);
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>MEPHX | Order History</title>
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

<%--   Order history  Table--%>

  <div class="w-full overflow-hidden h-max flex flex-col items-start p-10 gap-4 min-h-screen" >
    <!-- Top Page section -->
    <div class="w-full">
      <div class="text-5xl p-3 pb-10 text-white">
        Order History
      </div>
      <div class="bg-white flex flex-row justify-between p-2 rounded">
        <div class="my-auto !text-black">
          Below listed products are your previous orders.
        </div>
      </div>
    </div>
    <!-- Orders showing using Table section-->
    <div class="bg-white w-full p-4 rounded" id="product-table">
      <!-- Creating table to display orders -->
      <table class="w-full border-separate border border-white">
        <!-- Header of the table -->
        <tr id="tr_header">
          <th class="table-left-cell">Order ID</th>
          <th>Customer Name</th>
          <th>Product(s)</th>
          <th>Color(s)</th>
          <th>Size(s)</th>
          <th>Quantity(s)</th>
          <th>Price Each</th>
          <th>Total Quantity</th>
          <th>Order Total</th>
          <th class="table-right-cell">Shipping Status</th>
        </tr>
        <!-- Product list - Data of the table -->
        <%
          OrderDAO orderDAO = new OrderDAOImpl();
          ArrayList<UserOrderProductView> orders = null;

          try {
            orders = orderDAO.getAllOrders(user.getUserId());
          }catch (SQLException | ClassNotFoundException e) {
        %>
        <tr>
          <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold">
            Got an error while fetching orders
          </td>
        </tr>
        <%
          }
          if (orders != null) {
            for (UserOrderProductView order : orders) {
        %>
        <tr id="product_tr">
          <td class="table-left-cell"><%=order.getOrderId()%></td>
          <td><%=order.getFirstName() + " " + order.getLastName()%></td>
          <td style="vertical-align: middle">
            <%
              String[] products = order.getProducts().split(";");
              for (String product : products) {
            %>
            <div class="h-full py-3"><%=product%></div>
            <%
              }
            %>
          </td>
          <td style="vertical-align: middle">
            <%
              String[] colors = order.getColors().split(";");
              for (String color : colors) {
            %>
            <div class="h-full py-3"><%=color%></div>
            <%
              }
            %>
          </td>
          <td style="vertical-align: middle">
            <%
              String[] sizes = order.getSizes().split(";");
              for (String size : sizes) {
            %>
            <div class="h-full py-3"><%=size%></div>
            <%
              }
            %>
          </td>
          <td style="vertical-align: middle">
            <%
              String[] quantities = order.getQuantities().split(";");
              for (String quantity : quantities) {
            %>
            <div class="h-full py-3"><%=quantity%></div>
            <%
              }
            %>
          </td>
          <td style="vertical-align: middle">
            <%
              String[] prices = order.getPrices().split(";");
              for (String price : prices) {
            %>
            <div class="h-full py-3"><%=price%></div>
            <%
              }
            %>
          </td>
          <td><%=order.getTotalItems()%></td>
          <td><%=order.getTotalPrice()%></td>
          <td class="table-right-cell text-white w-max px-5 py-2 !text-black">
            <%=order.getIsDelivered() ? "Delivered" : "Pending"%>
          </td>
        </tr>
        <%
          }
        } else {
        %>
        <tr>
          <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold py-[40px]">
            No orders found
          </td>
        </tr>
        <%
          }
        %>
      </table>
    </div>
  </div>
</div>
  </div>
</div>
<%--Footer--%>
<%@include file="components/layout/footer.jsp" %>
</body>
</html>