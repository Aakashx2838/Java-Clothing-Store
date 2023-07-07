<%@ page import="com.mephx.model.User" %>
<%@ page import="com.mephx.controller.auth.ValidateCredentials" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="com.mephx.DAO.interfaces.CartItemDAO" %>
<%@ page import="com.mephx.DAO.implementations.CartItemDAOImpl" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.mephx.model.CartItem" %>
<%@ page import="com.mephx.DAO.interfaces.ProductDAO" %>
<%@ page import="com.mephx.DAO.implementations.ProductDAOImpl" %>
<%@ page import="com.mephx.model.Product" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MEPHX | <%=user.getFirst_name()%> | Cart</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/globals.css" />
    <script
            src="https://kit.fontawesome.com/86f6b8ce70.js"
            crossorigin="anonymous"
    ></script>
</head>
<body class="bg-bg font-urbanist text-neutral-200">
<!-- Navbar -->
<%@ include file="./components/layout/navbar.jsp" %>
<!--Container-->
<%!
    ArrayList<CartItem> cartItems = null;
    Double total = 0.0;
%>
<%
    CartItemDAO cartItemDAO = new CartItemDAOImpl();
    ProductDAO productDAO = new ProductDAOImpl();
    try {
        total = 0.0;
        cartItems = cartItemDAO.getCartItemsByUserId(user.getUserId());
    } catch (ClassNotFoundException | SQLException e) {
    throw new RuntimeException(e);
    }
%>
<div class="py-[72px] flex">
    <!-- Sidebar -->
    <%@ include file="./components/layout/sidebar.jsp" %>
    <!-- Main Content -->
    <div class="max-w-[1440px] w-full py-[40px] mx-auto ">
        <div class="w-full flex space-x-8 px-8">
            <!-- Card Section -->
            <div class="max-w-[1072px] w-full min-h-[50vh] space-y-4">
                <div class="flex justify-between w-full items-center">
                    <h1 class="font-semibold text-[24px] text-brand">My Bag
                        <span
                            class="text-neutral-400 font-medium text-[20px]"
                        >
                            (<%= cartItems == null ? 0 : cartItems.size() %> items)
                        </span>
                    </h1>
                    <a href="./home.jsp" class=" underline underline-offset-4 text-neutral-400 font-medium text-[18px]"> Continue
                        Shopping
                    </a>
                </div>
                <div class="w-full gap-4 space-y-4">
                    <!-- card -->
                    <%
                        try{
                            if (cartItems != null) {
                                for (CartItem cartItem : cartItems) {
                                    Product product = productDAO.getProductById(cartItem.getProduct_id());
                                    total += cartItem.getItemTotal();
                    %>
                                    <jsp:include page="components/cart/cart-product-card.jsp">
                                        <jsp:param name="product_id" value="<%=product.getId()%>"/>
                                        <jsp:param name="image" value="<%=product.getImagesArray()[0]%>"/>
                                        <jsp:param name="name" value="<%=product.getName()%>"/>
                                        <jsp:param name="quantity" value="<%=cartItem.getQuantity()%>"/>
                                        <jsp:param name="item_total" value="<%=cartItem.getItemTotal()%>"/>
                                        <jsp:param name="cart_item_id" value="<%=cartItem.getId()%>"/>
                                        <jsp:param name="size" value="<%=cartItem.getSize()%>"/>
                                        <jsp:param name="color" value="<%=cartItem.getColor()%>"/>
                                    </jsp:include>
                    <%
                                }
                            }
                        } catch (ClassNotFoundException | SQLException e) {
                            throw new RuntimeException(e);
                        }
                    %>
                    <%
                        if (cartItems == null) {
                    %>
                        <div class="p-[40px]">
                            <p
                                class="mx-auto w-fit text-[22px]"
                            >
                                Your cart is empty, add products to purchase
                            </p>
                            <img
                                src="<%=request.getContextPath()%>/assets/images/empty-cart.png"
                                height="400px"
                                width="400px"
                                class="mx-auto"
                                alt="Your cart is empty, add products to purchase"
                                loading="lazy"
                            />
                        </div>
                    <%
                        }
                    %>
                </div>
            </div>
            <!-- Summary Section -->
            <div
                class="max-w-[336px] w-full text-white bg-neutral-800 h-fit p-8 rounded-md space-y-4 font-semibold mt-[52px]"
            >
                <h1 class="text-[24px] ">Order Summary</h1>
                <div class="flex items-center  justify-between text-[18px] ">
                    <p>Total:</p>
                    <p>NPR. <%=String.format(Locale.getDefault(), "%.2f", total)%></p>
                </div>
                <form action="<%=request.getContextPath()%>/checkout-cart" method="post">
                    <input type="hidden" name="cart_id" value="<%=cartItems != null ? cartItems.get(0).getCart_id() : null%>">
                    <button class="btn-primary !rounded-md !w-full"
                        <%= cartItems == null ? "disabled" : "" %>
                    >
                    Proceed to checkout
                    </button>
                </form>
            </div>
        </div>
        <!-- Recommendation Section -->
        <jsp:include page="components/recommendation-section.jsp">
            <jsp:param name="title" value="Similar products that you may like"/>
            <jsp:param name="section-filter" value="random"/>
        </jsp:include>
    </div>
</div>
<%--Footer--%>
<%@include file="components/layout/footer.jsp" %>
</body>
</html>

