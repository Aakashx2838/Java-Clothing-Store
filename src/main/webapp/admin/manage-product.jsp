
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.DAO.interfaces.ProductDAO" %>
<%@ page import="com.mephx.DAO.implementations.ProductDAOImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mephx.model.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Cookie[] authCookie = request.getCookies();
  User user;
  ValidateCredentials vc = new ValidateCredentials();

  try {
    user = vc.checkCookie(authCookie);

    if (user != null && user.getRole().equals("admin")) {
      request.setAttribute("user", user);
    }else {
      response.sendRedirect(request.getContextPath() + "/client/home.jsp");
      return;
    }
    //need to refactor later
  } catch (SQLException | ClassNotFoundException e) {
    throw new RuntimeException(e);
  }
%>
<html>
<head>
  <title>Admin | Manage Product </title>
  <link rel="stylesheet" type="text/css" href="../css/globals.css"/>
  <script
          src="https://kit.fontawesome.com/86f6b8ce70.js"
          crossorigin="anonymous"
  ></script>
</head>
<body class="bg-bg font-urbanist">
<%--Navbar--%>
<%@ include file="../client/components/layout/navbar.jsp" %>
<%--Container--%>
<div class="flex w-full pt-[72px]">
  <%--Sidebar--%>
  <%@ include file="../admin/components/layout/sidebar.jsp" %>
  <!-- main body -->
  <div class="max-w-[1600px] border-orange-600 max-h-full w-full h-full mx-auto text-white">
    <%-- Content here --%>
    <div class="w-full overflow-hidden h-max flex flex-col items-start p-10 gap-4" >
      <!-- Top Page section -->
      <div class="w-full">
        <div class="text-5xl p-3 pb-10 text-white">
          Products Management
        </div>
        <div class="bg-white flex flex-row justify-between p-2 rounded">
          <div class="my-auto !text-black">
            Below listed are the product that are live and customer can buy the product.
          </div>
          <%
              if (session.getAttribute("successMessage") != null) {
          %>
            <div class="my-auto text-green-500 font-semibold">
                  <%=(String) session.getAttribute("successMessage")%>
            </div>
          <%
              session.removeAttribute("successMessage");
              }
          %>
          <%
            if (session.getAttribute("errorMessage") != null) {
          %>
            <div class="my-auto text-red-500 font-semibold">
              <%=(String) session.getAttribute("errorMessage")%>
            </div>
          <%
              session.removeAttribute("errorMessage");
            }
          %>
        </div>
      </div>
      <!-- Products showing using Table section-->
      <div class="bg-white w-full p-4 rounded" id="product-table">
        <!-- Creating table to display products -->
        <table class="w-full border-separate border border-white">
          <!-- Header of the table -->
          <tr id="tr_header">
            <th class="table-left-cell">Name</th>
            <th>Price</th>
            <th>Brand</th>
            <th>Category</th>
            <th>Reviews</th>
            <th>Rating</th>
            <th>Colors</th>
            <th>Sizes</th>
            <th>Quantity</th>
            <th class="table-right-cell">Actions</th>
          </tr>
          <!-- Product list - Data of the table -->
          <%
            ProductDAO productDAO = new ProductDAOImpl();
            ArrayList<Product> products = null;
            try {
              products = productDAO.getAllProducts("", "", "", "", "", true);
            }catch (SQLException | ClassNotFoundException e) {
          %>
            <tr>
              <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold">
                Got an error while fetching products
              </td>
            </tr>
          <%
            }
            if (products != null) {
              for (Product product : products) {
            %>
              <tr id="product_tr" class="<%=product.getQuantity() == 0 ? "!bg-red-500/30" : " " %>">
                <td class="table-left-cell"><%=product.getName()%></td>
                <td><%=product.getPrice()%></td>
                <td><%=product.getBrand().getName()%></td>
                <td><%=product.getCategory().getName()%></td>
                <td><%=product.getReviews()%></td>
                <td><%=product.getRating()%></td>
                <td class="px-5">
                  <div class="flex items-center gap-3">
                    <%
                      for (String color : product.getColorArray()) {
                    %>
                    <div class="w-5 h-5 rounded-full border border-black" style="background-color: <%=color%>"></div>
                    <%
                      }
                    %>
                  </div>
                </td>
                <td style="width: 80px">
                  <div class="flex items-center gap-3 overflow-x-scroll hide-scrollbar px-4" style="width: 80px;">
                    <%
                      for (String size : product.getSizeArray()) {
                    %>
                    <span><%=size%></span>
                    <%
                      }
                    %>
                  </div>
                </td>
                <td><%=product.getQuantity()%></td>
                <td class="table-right-cell text-white w-max px-5 py-2">
                  <form action="<%=request.getContextPath()%>/edit-product-visibility" method="post" class="w-full h-full flex items-center justify-center gap-3">
                    <input type="hidden" name="currentVisibility" value="<%=product.getVisibility()%>">
                    <input type="hidden" name="productId" value="<%=product.getId()%>">
                    <a href="edit-product.jsp?productId=<%=product.getId()%>" class="text-green-500 p-3 rounded-lg block">
                      <i class="fas fa-edit"></i>
                    </a>
                    <button class="text-red-500 p-3 rounded-lg">
                      <%
                        if (product.getVisibility()) {
                      %>
                      <i class="fa-sharp fa-solid fa-eye-slash"></i>
                      <%
                        } else {
                      %>
                      <i class="fa-solid fa-eye"></i>
                      <%
                        }
                      %>
                    </button>
                  </form>
                </td>
              </tr>
            <%
                }
              } else {
            %>
          <tr>
            <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold py-[40px]">
              No products found
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
</body>
</html>
