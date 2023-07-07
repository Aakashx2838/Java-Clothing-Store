package com.mephx.controller.user;

import com.mephx.DAO.implementations.CartDAOImpl;
import com.mephx.DAO.implementations.CartItemDAOImpl;
import com.mephx.DAO.implementations.UserDAOImpl;
import com.mephx.DAO.interfaces.CartDAO;
import com.mephx.DAO.interfaces.CartItemDAO;
import com.mephx.DAO.interfaces.UserDAO;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;

@WebServlet(name = "delete-account", value = "/delete-account")
public class DeleteUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ValidateCredentials vc = new ValidateCredentials();
        UserDAO userDAO = new UserDAOImpl();
        CartItemDAO cartItemDAO = new CartItemDAOImpl();
        CartDAO cartDAO = new CartDAOImpl();

        Cookie[] cookies = request.getCookies();
        Integer id = Integer.parseInt(request.getParameter("id"));

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else if (Objects.equals(user.getUserId(), id)) {
                cartItemDAO.deleteAllCartItemsByUserId(user.getUserId());
                if (cartDAO.getCartByUserId(user.getUserId()) != null) {
                    cartDAO.deleteCart(cartDAO.getCartByUserId(user.getUserId()));
                }
                userDAO.deleteUser(user);
            }
            response.sendRedirect(request.getContextPath() + "/client/home.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
