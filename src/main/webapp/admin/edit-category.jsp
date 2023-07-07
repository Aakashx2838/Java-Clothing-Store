<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.DAO.interfaces.CategoryDAO" %>
<%@ page import="com.mephx.DAO.implementations.CategoryDAOImpl" %>
<%@ page import="com.mephx.model.Category" %>
<%
  Cookie[] authCookie = request.getCookies();
  CategoryDAO categoryDAO = new CategoryDAOImpl();
  User user;
  Category category;
  int id;
  ValidateCredentials vc = new ValidateCredentials();
  id = Integer.parseInt(request.getParameter("categoryId"));

  try {
    user = vc.checkCookie(authCookie);

    if (user != null && user.getRole().equals("admin")) {
      request.setAttribute("user", user);
    }else {
      response.sendRedirect(request.getContextPath() + "/client/home.jsp");
      return;
    }
    category = categoryDAO.getCategoryById(id);
    if (category == null) {
      response.sendRedirect("/404");
      return;
    }
  } catch (SQLException | ClassNotFoundException e) {
    throw new RuntimeException(e);
  }
%>
<html>
<head>
  <title>Admin | Edit Category </title>
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
  <div class="max-w-[1440px] mt-[20px] p-[40px] border-orange-600 max-h-full w-full h-full mx-auto text-white">
    <div class="">
      <div>
        <h1 class="text-[30px] font-bold">Welcome Back, <%=user.getFirst_name()%>.</h1>
        <span class="text-neutral-500">You can edit Category here.</span>
      </div>
    </div>
    <div class="flex w-full space-x-8 h-fit">
      <!-- Add Category -->
      <div class="w-full h-full">
        <div class="mt-[35px] flex items-center space-x-8">
          <h1 class="text-[25px] font-semibold underline underline-offset-4">Edit Category</h1>
          <%
            if (session.getAttribute("categoryEditMessage") != null) {
          %>
          <div class="my-auto text-green-500 font-semibold">
            <%=(String) session.getAttribute("categoryEditMessage")%>
          </div>
          <%
              session.removeAttribute("categoryEditMessage");
            }
          %>
          <%
            if (session.getAttribute("categoryEditErrorMessage") != null) {
          %>
          <div class="my-auto text-red-500 font-semibold">
            <%=(String) session.getAttribute("categoryEditErrorMessage")%>
          </div>
          <%
              session.removeAttribute("categoryEditErrorMessage");
            }
          %>
        </div>
        <form action="<%=request.getContextPath()%>/update-category" method="post">
          <input name="categoryId" type="hidden" value="<%=category.getId()%>">
          <div class="flex max-w-[1440px] w-full">
            <div class="w-full">
              <div class="space-y-[8px] font-semibold text-xl mt-3">
                <label for="category_name">
                  Category Name:
                  <span class="text-red-500"> * </span>
                </label>
                <br />
                <input type="text" name="category_name" id="category_name" class="form-input !max-w-full" placeholder="Name" required value="<%=category.getName()%>"/>
              </div>
              <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
                <label for="description">
                  Description:
                  <span class="text-red-500"> * </span>
                </label>
                <br />
                <textarea name="category_description" id="description" class="form-input !max-w-full" rows="15" placeholder="Description" required ><%=category.getDescription()%></textarea>
              </div>
            </div>
          </div>
          <div class="!w-[225px] mt-3">
            <button
                    class="btn-tertiary !max-w-full !rounded-md"
            >
              Edit Category
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>
