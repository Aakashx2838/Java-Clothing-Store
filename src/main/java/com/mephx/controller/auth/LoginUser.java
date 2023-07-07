package com.mephx.controller.auth;
import com.mephx.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "login-user", value = "/login-user")
public class LoginUser extends HttpServlet {
    User user;
    ValidateCredentials vc = new ValidateCredentials();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetching data from login form
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            user = vc.login(email, password, false); //Checking if user exists or not
            if (user == null) {
                response.sendRedirect("client/register.jsp"); //Redirect to register.jsp if user does not exist
                return;
            }
            Cookie authCookie = vc.createCookie(user.getEmail(), user.getPassword()); //Creating cookie of the user using email and password
            response.addCookie(authCookie); //Adding cookie to the browser
            if (user.getRole().equals("admin")) {
                response.sendRedirect("admin/index.jsp"); //If the user is admin, redirecting it to admin's index.jsp
                return;
            }
            response.sendRedirect("client/home.jsp"); //Redirecting user to customer's home.jsp
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
