package com.mephx.controller.category;

import com.mephx.DAO.implementations.CategoryDAOImpl;
import com.mephx.DAO.interfaces.CategoryDAO;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.Category;
import com.mephx.model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "update-category", value = "/update-category")
public class UpdateCategory extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Cookie[] cookies = request.getCookies();
        ValidateCredentials vc = new ValidateCredentials();
        CategoryDAO categoryDAO = new CategoryDAOImpl();

        Integer id = Integer.parseInt(request.getParameter("categoryId"));
        String name = request.getParameter("category_name");
        String description = request.getParameter("category_description");

        Category category = new Category(
                id,
                name,
                description,
                true
        );

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            categoryDAO.updateCategory(category);
            request.getSession().setAttribute("categoryEditMessage", "Category Edited Successfully");
            response.sendRedirect(request.getContextPath() + "/admin/edit-category.jsp?categoryId=" + id);
        } catch (SQLException | ClassNotFoundException ex) {
            request.getSession().setAttribute("categoryEditErrorMessage", "Something Went Wrong, Please Try Again!");
            response.sendRedirect(request.getContextPath() + "/admin/edit-category.jsp?categoryId=" + id);
        }
    }
}
