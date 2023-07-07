<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.model.Brand" %>
<%@ page import="com.mephx.DAO.interfaces.BrandDAO" %>
<%@ page import="com.mephx.DAO.implementations.BrandDAOImpl" %>
<%
    Cookie[] authCookie = request.getCookies();
    BrandDAO brandDAO = new BrandDAOImpl();

    User user;
    Brand brand;
    int id;
    ValidateCredentials vc = new ValidateCredentials();
    id = Integer.parseInt(request.getParameter("brandId"));
    try {
        user = vc.checkCookie(authCookie);

        if (user != null && user.getRole().equals("admin")) {
            request.setAttribute("user", user);
        }else {
            response.sendRedirect(request.getContextPath() + "/client/home.jsp");
            return;
        }
        brand = brandDAO.getBrandById(id);
        if (brand == null) {
            response.sendRedirect("/404");
            return;
        }
    } catch (SQLException | ClassNotFoundException e) {
        throw new RuntimeException(e);
    }
%>
<html>
<head>
    <title>Admin | Edit Brand </title>
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
                <h1 class="text-[30px] font-bold">Welcome Back, <%= user.getFirst_name()%>.</h1>
                <span class="text-neutral-500">You can edit Brand here.</span>
            </div>
        </div>
        <div class="flex w-full space-x-8 h-fit">
            <!-- Edit Brand -->
            <div class="w-full h-full">
                <div class="max-w-[1300px] border-orange-600 max-h-full w-full mt-[20px] mb-[40px]">
                    <div class="mt-[35px] flex items-center space-x-8">
                        <h1 class="text-[25px] font-semibold underline underline-offset-4">Edit Brand</h1>
                        <%
                            if (session.getAttribute("brandEditSuccessMessage") != null) {
                        %>
                        <div class="my-auto text-green-500 font-semibold">
                            <%=(String) session.getAttribute("brandEditSuccessMessage")%>
                        </div>
                        <%
                                session.removeAttribute("brandEditSuccessMessage");
                            }
                        %>
                        <%
                            if (session.getAttribute("brandEditErrorMessage") != null) {
                        %>
                        <div class="my-auto text-red-500 font-semibold">
                            <%=(String) session.getAttribute("brandEditErrorMessage")%>
                        </div>
                        <%
                                session.removeAttribute("brandEditErrorMessage");
                            }
                        %>
                    </div>
                    <form action="<%= request.getContextPath()%>/update-brand" method="post" enctype="multipart/form-data">
                        <input name="brandId" type="hidden" value="<%=brand.getId()%>" />
                        <div class="max-w-[1270px] w-full space-y-4">
                            <div class=" !max-w-[1000px] w-full mx-auto">
                                <div class="space-y-[8px] text-white font-semibold text-xl mt-3">
                                    <label for="brand_name">
                                        Brand Name:
                                        <span class="text-red-500"> * </span>
                                    </label>
                                    <br />
                                    <input type="text" name="brand_name" class="form-input !max-w-full" placeholder="Name" id="brand_name" required value="<%=brand.getName()%>"/>
                                </div>
                            </div>
                            <div class="items-center justify-center w-full h-full">
                                <div class="items-center justify-center w-full space-y-2">
                                    <label class="space-y-[8px] text-white font-semibold text-xl">
                                        Image:
                                        <span class="text-red-500"> * </span>
                                    </label>
                                    <br />
                                    <label for="dropzone-file" class="flex flex-col items-center justify-center w-full h-[425px] border-2 border-dashed rounded-lg cursor-pointer hover:bg-bray-800  bg-gray-700  border-gray-500  :hover:bg-gray-600">
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
                                        <input id="dropzone-file" type="file" name="image" class="hidden" accept="image/*"  />
                                        <input type="hidden" value="<%=brand.getImage()%>" name="oldImage">
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="!w-[225px] mt-3">
                            <button
                                    class="btn-tertiary !max-w-full !rounded-md" type="submit"
                            >
                                Edit Brand
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
