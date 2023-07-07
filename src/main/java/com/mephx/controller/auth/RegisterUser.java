package com.mephx.controller.auth;

import com.mephx.DAO.implementations.CartDAOImpl;
import com.mephx.DAO.implementations.UserDAOImpl;
import com.mephx.DAO.interfaces.CartDAO;
import com.mephx.DAO.interfaces.UserDAO;
import com.mephx.model.Cart;
import com.mephx.model.User;
import com.mephx.utils.ImageUploadHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDateTime;

@WebServlet(name = "register-user", value = "/register-user")
@MultipartConfig
public class RegisterUser extends HttpServlet {
    private int passwordLength = 0;

    public boolean checkIfUserAlreadyExists(String email) {
        UserDAO userDAO = new UserDAOImpl();
        try {
            User user = userDAO.getUserByEmail(email);
            return user != null;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean validateRegistrationInput(User user) {
        if (checkIfUserAlreadyExists(user.getEmail())) {
            return false;
        }
        if (user.getFirst_name() == null || user.getFirst_name().trim().isEmpty()) {
            return false;
        }
        if (user.getLast_name() == null || user.getLast_name().trim().isEmpty()) {
            return false;
        }
        if (user.getDateOfBirth() == null || user.getDateOfBirth().trim().isEmpty()) {
            return false;
        }
        if (user.getSex() == null || user.getSex().trim().isEmpty()) {
            return false;
        }
        if (user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return false;
        }
        if (user.getAddress() == null || user.getAddress().trim().isEmpty()) {
            return false;
        }
        if (user.getImage() == null || user.getImage().trim().isEmpty()) {
            return false;
        }
        if (user.getPassword() == null || user.getPassword().isBlank()) {
            return false;
        } else return passwordLength >= 8;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ValidateCredentials vc = new ValidateCredentials();
        ImageUploadHandler img = new ImageUploadHandler();

        UserDAO userDAO = new UserDAOImpl();
        CartDAO cartDAO = new CartDAOImpl();

        Part filePart = request.getPart("profile_picture");
        String fileSavePath = img.saveUploadedImage(filePart, "/assets/uploads/", getServletContext().getRealPath("/") + "assets/uploads/");
        passwordLength = request.getParameter("password").length();

        User user = new User(
            null,
            request.getParameter("first_name"),
            request.getParameter("last_name"),
            Date.valueOf(request.getParameter("date_of_birth")).toString(),
            request.getParameter("sex"),
            request.getParameter("email"),
            vc.encryptPassword(request.getParameter("password")),
            request.getParameter("address"),
            fileSavePath,
            "user",
            Long.parseLong(request.getParameter("phone_number"))
        );

        boolean isDetailsValid = validateRegistrationInput(user);

        if (isDetailsValid) {
            try {
                userDAO.addUser(user);
                user.setUserId(userDAO.getUserByEmail(user.getEmail()).getUserId());
                Cart cart = new Cart(
                    null,
                    user.getUserId(),
                    null,
                    null,
                    null
                );
                cartDAO.createCart(cart);
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/client/register.jsp");
    }
}
