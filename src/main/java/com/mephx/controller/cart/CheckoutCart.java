package com.mephx.controller.cart;

import com.mephx.DAO.implementations.*;
import com.mephx.DAO.interfaces.*;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;

@WebServlet(name = "checkout-cart", value = "/checkout-cart")
public class CheckoutCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        ValidateCredentials vc = new ValidateCredentials();
        ArrayList<CartItem> cartItems = new ArrayList<>();
        CartDAO cartDAO = new CartDAOImpl();
        CartItemDAO cartItemDAO = new CartItemDAOImpl();
        OrderDAO orderDAO = new OrderDAOImpl();
        Double orderTotal = 0.0;
        Integer cartId = Integer.parseInt(request.getParameter("cart_id"));

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.Fjsp");
                return;
            }
            cartItems = cartItemDAO.getCartItemsByUserId(user.getUserId());
            for (CartItem cartItem : cartItems) {
                orderTotal += cartItem.getItemTotal();
            }
            orderDAO.addOrder(new Order(
                null,
                cartId,
                orderTotal,
                false
            ));
            cartDAO.updateCart(new Cart(
                cartId,
                user.getUserId(),
                true,
                null,
                null
            ));

            response.sendRedirect("index.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
