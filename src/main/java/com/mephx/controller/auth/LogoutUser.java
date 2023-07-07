package com.mephx.controller.auth;

import com.mephx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "logout-user", value = "/logout-user")
public class LogoutUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cookie[] existingCookies = request.getCookies();
        for (Cookie cookie : existingCookies) {
            String name = cookie.getName();
            if (name.equals("MEPHXud")) {
                cookie.setValue("");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                response.sendRedirect(request.getContextPath()+"/client/home.jsp");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
