package com.mephx.controller.cart;

import com.mephx.DAO.implementations.CartDAOImpl;
import com.mephx.DAO.implementations.CartItemDAOImpl;
import com.mephx.DAO.implementations.ProductDAOImpl;
import com.mephx.DAO.implementations.UserDAOImpl;
import com.mephx.DAO.interfaces.CartDAO;
import com.mephx.DAO.interfaces.CartItemDAO;
import com.mephx.DAO.interfaces.ProductDAO;
import com.mephx.DAO.interfaces.UserDAO;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.Cart;
import com.mephx.model.CartItem;
import com.mephx.model.Product;
import com.mephx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "add-to-cart", value = "/add-to-cart")
public class AddProductToCart extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        ValidateCredentials vc = new ValidateCredentials();
        ProductDAO productDAO = new ProductDAOImpl();
        CartDAO cartDAO = new CartDAOImpl();
        CartItemDAO cartItemDAO = new CartItemDAOImpl();
        Integer productId = Integer.parseInt(request.getParameter("productId"));
        Product product = null;

        String color = request.getParameter("color");
        String size = request.getParameter("size");

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            if (cartDAO.getCartByUserId(user.getUserId()) == null) {
                cartDAO.createCart(new Cart(
                    null,
                    user.getUserId(),
                    null,
                    null,
                    null
                ));
            }
            if (product.getQuantity() > 0) {
                CartItem cartItem = new CartItem(
                        null,
                        (cartDAO.getCartByUserId(user.getUserId())).getCartId(),
                        product.getId(),
                        1,
                        product.getPrice(),
                        color,
                        size
                );
                cartItemDAO.addItemToCart(cartItem);
                productDAO.updateProduct(new Product(
                        product.getId(),
                        product.getName(),
                        product.getPrice(),
                        product.getRating(),
                        product.getColor(),
                        product.getSize(),
                        product.getQuantity() - 1,
                        product.getImages(),
                        product.getDescription(),
                        product.getReviews(),
                        product.getBrand(),
                        product.getCategory(),
                        product.getVisibility()
                ));
            }
            response.sendRedirect(request.getContextPath() + "/client/product.jsp?productId=" + productId);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
