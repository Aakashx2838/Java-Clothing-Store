package com.mephx.controller.category;

import com.mephx.DAO.implementations.CategoryDAOImpl;
import com.mephx.DAO.interfaces.CategoryDAO;
import com.mephx.model.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "edit-category-visibility", value = "/edit-category-visibility")
public class EditCategoryVisibility extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("categoryId"));
        Boolean currentVisibility = Boolean.parseBoolean(request.getParameter("currentVisibility"));
        CategoryDAO categoryDAO = new CategoryDAOImpl();
        try {
            Category category = categoryDAO.getCategoryById(id);
            if (category != null) {
                categoryDAO.editCategoryVisibility(id, currentVisibility);
                request.getSession().setAttribute("successMessage", "Category Deleted Successfully");
            }else {
                request.getSession().setAttribute("errorMessage", "Category Not Found");
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.getSession().setAttribute("errorMessage", "Something Went Wrong, Please Try Again!");
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-category.jsp");
    }
}
