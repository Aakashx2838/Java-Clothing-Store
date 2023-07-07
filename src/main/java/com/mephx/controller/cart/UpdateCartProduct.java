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
import com.mephx.model.CartItem;
import com.mephx.model.Product;
import com.mephx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

@WebServlet(name = "update-product-quantity", value = "/update-product-quantity")
public class UpdateCartProduct extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        ValidateCredentials vc = new ValidateCredentials();
        CartItemDAO cartItemDAO = new CartItemDAOImpl();
        ProductDAO productDAO = new ProductDAOImpl();
        String action = request.getParameter("action");
        int cart_item_id = Integer.parseInt(request.getParameter("cart_item_id"));

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            ArrayList<CartItem> cartItems = cartItemDAO.getCartItemsByUserId(user.getUserId());
            if (cartItems == null) {
                response.sendRedirect("index.jsp");
                return;
            }
            for (CartItem cartItem : cartItems) {
                if (cartItem.getId() == cart_item_id) {
                    if (action.equals("increment") && productDAO.getProductById(cartItem.getProduct_id()).getQuantity() > 0) {
                        cartItem.setQuantity(cartItem.getQuantity() + 1);
                        Product product = productDAO.getProductById(cartItem.getProduct_id());
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
                    if (action.equals("decrement") && cartItem.getQuantity() > 1) {
                        cartItem.setQuantity(cartItem.getQuantity() - 1);
                        Product product = productDAO.getProductById(cartItem.getProduct_id());
                        productDAO.updateProduct(new Product(
                                product.getId(),
                                product.getName(),
                                product.getPrice(),
                                product.getRating(),
                                product.getColor(),
                                product.getSize(),
                                product.getQuantity() + 1,
                                product.getImages(),
                                product.getDescription(),
                                product.getReviews(),
                                product.getBrand(),
                                product.getCategory(),
                                product.getVisibility()
                        ));
                    }
                    cartItem.setItemTotal(
                        (productDAO.getProductById(cartItem.getProduct_id())).getPrice() * cartItem.getQuantity()
                    );
                    cartItemDAO.updateCartItem(cartItem);

                    response.sendRedirect(request.getContextPath() + "/client/cart.jsp");
                    return;
                }
            }
            response.sendRedirect("index.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
    }
