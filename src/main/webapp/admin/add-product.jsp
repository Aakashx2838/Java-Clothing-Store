<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.DAO.interfaces.CategoryDAO" %>
<%@ page import="com.mephx.DAO.implementations.CategoryDAOImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mephx.model.Category" %>
<%@ page import="com.mephx.model.Brand" %>
<%@ page import="com.mephx.DAO.interfaces.BrandDAO" %>
<%@ page import="com.mephx.DAO.implementations.BrandDAOImpl" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Cookie[] authCookie = request.getCookies();
  User user;
  ValidateCredentials vc = new ValidateCredentials();
  ArrayList<Category> categories = null;
  ArrayList<Brand> brands = null;
  boolean isDataLoaded = false;

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
  <title>Admin | Add Product </title>
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
<div class="flex w-full" style="padding-top: 71px;">
  <%--Sidebar--%>
  <%@ include file="../admin/components/layout/sidebar.jsp" %>
  <!-- main body -->
  <%
    CategoryDAO categoryDAO = new CategoryDAOImpl();
    BrandDAO brandDAO = new BrandDAOImpl();
    try{
      categories = categoryDAO.getAllCategories(false);
      brands = brandDAO.getAllBrands(false);
      if (categories != null && brands != null) {
        isDataLoaded = true;
      }
    } catch (SQLException | ClassNotFoundException e) {
      throw new RuntimeException(e);
    }
  %>
  <div class="max-w-[1440px] p-[40px] border-orange-600 w-full h-fit mt-[20px] mx-auto text-white">
    <div>
        <h1 class="text-[30px] font-bold">Welcome Back, <%=user.getFirst_name()%></h1>
        <span class="text-neutral-500">You can add product here.</span>
    </div>
    <div class="mt-[35px] flex items-center space-x-8">
      <h1 class="text-[25px] font-semibold underline underline-offset-4">Add Product</h1>
      <!-- No Category or Brand Error-->
      <%=isDataLoaded ? ""  : "<p class=\"text-red-500 font-medium\">(Please add a brand and category before adding a product)</p>"%>
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
    <form action="<%=request.getContextPath()%>/create-product" method="post" enctype="multipart/form-data">
      <!-- Category and Brand -->
      <div class="flex gap-8">
        <!-- Category -->
        <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
          <label for="category">
            Category:
            <span class="text-red-500"> * </span>
          </label>
          <br>
          <select name="category" id="category" class="form-input !w-[225px]" <%=isDataLoaded ? "" : "disabled" %>>
            <%
              if (isDataLoaded){
                for (Category category : categories) {
            %>
                  <option value="<%=category.getId()%>" class="!text-black capitalize"><%=category.getName()%></option>
            <%
                }
              }
            %>
          </select>
        </div>
        <!-- Brand -->
        <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
          <label for="brand" >
            Brand:
            <span class="text-red-500"> * </span>
          </label>
          <br>
          <select class="form-input !w-[225px]" name="brand" id="brand" <%=isDataLoaded ? "" : "disabled" %>>
            <%
              if (isDataLoaded){
                for (Brand brand : brands) {
            %>
                  <option value="<%=brand.getId()%>" class="!text-black capitalize"><%=brand.getName()%></option>
            <%
                }
              }
            %>
          </select>
        </div>
      </div>
        <!-- Product Name, Price, Quantity, Colors, Sizes, Description -->
      <div class="flex justify-between w-full">
        <div class=" !max-w-[1000px] w-full h-full mx-auto">
          <!-- Product Name -->
          <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
            <label for="product_name">
              Product Name:
              <span class="text-red-500"> * </span>
            </label>
            <br />
            <input type="text" name="product_name" id="product_name" class="form-input !max-w-full" placeholder="Name" <%=isDataLoaded ? "" : "disabled" %> required/>
          </div>
          <!-- Price -->
          <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
            <label for="price">
              Price(Rs.):
              <span class="text-red-500"> * </span>
            </label>
            <br />
            <input type="number" id="price" name="price" class="form-input !max-w-full" placeholder="Price" step=".01" <%=isDataLoaded ? "" : "disabled" %> required />
          </div>
          <!-- Quantity -->
          <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
            <label for="quantity">
              Quantity:
              <span class="text-red-500"> * </span>
            </label>
            <br />
            <input type="number" id="quantity" name="quantity" class="form-input !max-w-full" placeholder="Quantity" <%=isDataLoaded ? "" : "disabled" %> required />
          </div>
          <!-- Colors -->
          <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
            <label for="colors">
              Colors:
              <span class="text-red-500"> * </span>
            </label>
            <br />
            <input type="text" name="colors" id="colors" class="form-input !max-w-full" placeholder="Eg. red,blue,green" <%=isDataLoaded ? "" : "disabled" %> required />
          </div>
          <!-- Sizes -->
          <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
            <label for="sizes">
              Sizes:
              <span class="text-red-500"> * </span>
            </label>
            <br />
            <input type="text" id="sizes" name="sizes" class="form-input !max-w-full" placeholder="Eg. 10,12,16" <%=isDataLoaded ? "" : "disabled" %> required />
          </div>
          <!-- Description -->
          <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
            <label for="description">
              Description:
              <span class="text-red-500"> * </span>
            </label>
            <br />
            <textarea name="description" id="description" class="form-input !max-w-full" rows="3"
                      placeholder="Description" <%=isDataLoaded ? "" : "disabled" %>  required ></textarea>
          </div>
        </div>
        <!-- Image -->
        <div class="flex flex-col items-start w-full ml-[30px]">
          <label class="text-white font-semibold text-xl">
            Image:
            <span class="text-red-500"> * </span>
          </label>
          <br />
          <label for="dropzone-file"
                 class="flex flex-col items-center justify-center w-full h-[425px] border-2  border-dashed rounded-lg cursor-pointer  hover:bg-bray-800  bg-gray-700  border-gray-500  :hover:bg-gray-600">
            <div class="flex flex-col items-center justify-center pt-5 pb-6">
              <svg aria-hidden="true" class="w-10 h-10 mb-3 text-gray-400" fill="none"
                   stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12">
                </path>
              </svg>
              <p class="mb-2 text-sm  text-gray-400"><span class="font-semibold">Click
                                      to upload</span> or drag and drop</p>
              <p class="text-xs  text-gray-400">SVG, PNG, JPG or GIF (MAX. 800x400px)
              </p>
            </div>
            <input id="dropzone-file" name="image" accept="image/*" type="file" multiple class="hidden" <%=isDataLoaded ? "" : "disabled" %> required />
          </label>
          <div class="!w-[225px] mt-3">
            <button
                    class="btn-tertiary !max-w-full !rounded-md"
                    <%=isDataLoaded ? "" : "disabled" %>
            >
              Add Product
            </button>
          </div>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>
