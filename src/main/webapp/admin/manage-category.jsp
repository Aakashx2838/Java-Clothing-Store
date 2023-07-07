<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mephx.DAO.interfaces.CategoryDAO" %>
<%@ page import="com.mephx.DAO.implementations.CategoryDAOImpl" %>
<%@ page import="com.mephx.model.Category" %>
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
  <title>Admin | Manage Category </title>
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
          Category Management
        </div>
        <div class="bg-white flex flex-row justify-between p-2 rounded">
          <div class="my-auto !text-black">
            Below listed are the categories that are live and can be assigned to products.
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
            <th class="table-left-cell">ID</th>
            <th>Name</th>
            <th>Description</th>
            <th class="table-right-cell">Actions</th>
          </tr>
          <!-- Category list - Data of the table -->
          <%
            CategoryDAO categoryDAO = new CategoryDAOImpl();
            ArrayList<Category> categories = null;
            try {
              categories = categoryDAO.getAllCategories(true);
            }catch (SQLException | ClassNotFoundException e) {
          %>
          <tr>
            <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold">
              Got an error while fetching categories
            </td>
          </tr>
          <%
            }
            if (categories != null) {
              for (Category category : categories) {
          %>
            <tr id="product_tr">
            <td class="table-left-cell"><%=category.getId()%></td>
            <td><%=category.getName()%></td>
            <td class="flex items-center justify-center" style="height: 70px">
              <%=category.getDescription()%>
            </td>
            <td class="table-right-cell text-white w-max px-5 ">
              <form action="<%=request.getContextPath()%>/edit-category-visibility" method="post" class="w-full flex items-center justify-center gap-3" style="margin-bottom: 0">
                <input type="hidden" name="categoryId" value="<%=category.getId()%>">
                <input type="hidden" name="currentVisibility" value="<%=category.getVisibility()%>">
                <a href="edit-category.jsp?categoryId=<%=category.getId()%>" class="text-green-500 p-3 rounded-lg block">
                  <i class="fas fa-edit"></i>
                </a>
                <button class="text-red-500 p-3 rounded-lg">
                  <%
                    if (category.getVisibility()) {
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
              No categories found
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
