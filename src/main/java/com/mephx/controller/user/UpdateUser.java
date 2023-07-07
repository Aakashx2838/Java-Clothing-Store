package com.mephx.controller.user;

import com.mephx.DAO.implementations.UserDAOImpl;
import com.mephx.DAO.interfaces.UserDAO;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.User;
import com.mephx.utils.ImageUploadHandler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

@WebServlet(name = "update-user", value = "/update-user")
@MultipartConfig
public class UpdateUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HashMap<String, String> userUpdateDetails = new HashMap<>();

        ValidateCredentials vc = new ValidateCredentials();
        ImageUploadHandler img = new ImageUploadHandler();
        UserDAO userDAO = new UserDAOImpl();
        Cookie[] cookies = request.getCookies();

        Part filePart = request.getPart("profile_picture");

        userUpdateDetails.put("first_name", request.getParameter("first_name"));
        userUpdateDetails.put("last_name", request.getParameter("last_name"));
        userUpdateDetails.put("email", request.getParameter("email"));
        userUpdateDetails.put("phone", request.getParameter("phoneNumber"));
        userUpdateDetails.put("date_of_birth", request.getParameter("dateOfBirth"));
        userUpdateDetails.put("sex", request.getParameter("sex"));
        if (request.getParameter("newPassword") != null){
            userUpdateDetails.put("password", vc.encryptPassword(request.getParameter("newPassword")));
        }
        if (filePart != null) {
            String fileSavePath = img.saveUploadedImage(filePart, "/assets/uploads/", getServletContext().getRealPath("/") + "assets/uploads/");
            userUpdateDetails.put("profile_picture", fileSavePath);
        }
        userUpdateDetails.put("address", request.getParameter("address"));

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            } else {
                userDAO.updateUser(user, userUpdateDetails);
            }
            response.sendRedirect(request.getContextPath() + "/client/profile.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

    }
}
