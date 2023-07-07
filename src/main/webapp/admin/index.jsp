
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.DAO.implementations.WebStatistics" %>
<%@ page import="com.mephx.model.AdminStatisticsView" %>
<%@ page import="com.mephx.DAO.interfaces.UserDAO" %>
<%@ page import="com.mephx.DAO.implementations.UserDAOImpl" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>Admin | Dashboard </title>
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
    <%
        WebStatistics ws = new WebStatistics();
        AdminStatisticsView asv =null;
        try{
            asv = ws.getAdminStatistics();
        }catch (SQLException | ClassNotFoundException e){
            e.printStackTrace();
        }
    %>
    <%--Sidebar--%>
    <%@ include file="../admin/components/layout/sidebar.jsp" %>
    <!-- main body -->
    <div class="max-w-[1440px] mt-[20px] border-orange-600 max-h-full w-full h-full mx-auto text-white">
        <%-- Content here --%>
        <h1 class="text-3xl font-semibold">Store Statistics</h1>
        <div class="flex py-[40px] space-x-[16px]">
            <div class="w-[280px] h-[175px] rounded-md bg-neutral-800 px-5 py-[40px] space-y-[32px]" style="background-image: url('../assets/images/wave.svg'); background-repeat: no-repeat; background-size: cover">
                <div class="text-2xl flex items-center space-x-[16px]">
                    <div class="bg-neutral-700 p-3 rounded-full">
                        <i class="fa-solid fa-users text-xl"></i>
                    </div>
                    <span class="font-semibold">
                        Total Users
                    </span>
                </div>
                <h3 class="text-2xl font-semibold">
                    <%= asv != null ? asv.getTotalUsers() : 0%>
                </h3>
            </div>
            <div class="w-[280px] h-[175px] rounded-md bg-neutral-800 px-5 py-[40px] space-y-[32px]" style="background-image: url('../assets/images/wave.svg'); background-repeat: no-repeat; background-size: cover">
                <div class="text-2xl flex items-center space-x-[16px]">
                    <div class="bg-neutral-700 p-3 rounded-full">
                        <i class="fa-solid fa-users text-xl"></i>
                    </div>
                    <span class="font-semibold">
                        Total Sales
                    </span>
                </div>
                <h3 class="text-2xl font-semibold">
                    NPR. <%= asv != null ? asv.getTotalSales() : 0%>
                </h3>
            </div>
            <div class="w-[280px] h-[175px] rounded-md bg-neutral-800 px-5 py-[40px] space-y-[32px]" style="background-image: url('../assets/images/wave.svg'); background-repeat: no-repeat; background-size: cover">
                <div class="text-2xl flex items-center space-x-[16px]">
                    <div class="bg-neutral-700 p-3 rounded-full">
                        <i class="fa-solid fa-users text-xl"></i>
                    </div>
                    <span class="font-semibold">
                        Products
                    </span>
                </div>
                <h3 class="text-2xl font-semibold">
                    <%= asv != null ? asv.getTotalProducts() : 0%>
                </h3>
            </div>
            <div class="w-[280px] h-[175px] rounded-md bg-neutral-800 px-5 py-[40px] space-y-[32px]" style="background-image: url('../assets/images/wave.svg'); background-repeat: no-repeat; background-size: cover">
                <div class="text-2xl flex items-center space-x-[16px]">
                    <div class="bg-neutral-700 p-3 rounded-full">
                        <i class="fa-solid fa-users text-xl"></i>
                    </div>
                    <span class="font-semibold">
                        Categories
                    </span>
                </div>
                <h3 class="text-2xl font-semibold">
                    <%= asv != null ? asv.getTotalCategories() : 0%>
                </h3>
            </div>
            <div class="w-[280px] h-[175px] rounded-md bg-neutral-800 px-5 py-[40px] space-y-[32px]" style="background-image: url('../assets/images/wave.svg'); background-repeat: no-repeat; background-size: cover">
                <div class="text-2xl flex items-center space-x-[16px]">
                    <div class="bg-neutral-700 p-3 rounded-full">
                        <i class="fa-solid fa-users text-xl"></i>
                    </div>
                    <span class="font-semibold">
                        Brands
                    </span>
                </div>
                <h3 class="text-2xl font-semibold">
                    <%= asv != null ? asv.getTotalBrands() : 0%>
                </h3>
            </div>
        </div>
        <%-- Users table --%>
        <div class="bg-white w-full p-4 rounded" id="product-table">
                <!-- Creating table to display products -->
                <table class="w-full border-separate border border-white">
                    <!-- Header of the table -->
                    <tr id="tr_header">
                        <th class="table-left-cell">ID</th>
                        <th>Name</th>
                        <th>Date Of Birth</th>
                        <th>Sex</th>
                        <th>Email</th>
                        <th>Address</th>
                        <th class="table-right-cell">Phone</th>
                    </tr>
                    <!-- Product list - Data of the table -->
                    <%
                        UserDAO userDAO = new UserDAOImpl();
                        ArrayList<User> users = null;
                        try {
                            users = userDAO.getAllUsers();
                        }catch (SQLException | ClassNotFoundException e) {
                    %>
                    <tr>
                        <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold">
                            Got an error while fetching users
                        </td>
                    </tr>
                    <%
                        }
                        if (users != null) {
                            for (User userEach : users) {
                    %>
                    <tr id="product_tr">
                        <td class="table-left-cell"><%=userEach.getUserId()%></td>
                        <td><%=userEach.getFirst_name() + userEach.getLast_name()%></td>
                        <td><%=userEach.getDateOfBirth()%></td>
                        <td><%=userEach.getSex()%></td>
                        <td><%=userEach.getEmail()%></td>
                        <td><%=userEach.getAddress()%></td>
                        <td><%=userEach.getPhone()%></td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="10" class="table-left-cell table-right-cell text-center text-red-500 font-semibold py-[40px]">
                            No users found
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>
    </div>
</div>
</body>
</html>
