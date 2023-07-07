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

@WebServlet(name = "create-product-category", value = "/create-product-category")

public class CreateCategory extends HttpServlet {

    public boolean checkIfCategoryAlreadyExists(String name) {
        CategoryDAO productCategoryDAO = new CategoryDAOImpl();
        try {
            Category productCategory = productCategoryDAO.getCategoryByName(name);
            return productCategory != null;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean validateCategoryInput(Category productCategory) {
        if (checkIfCategoryAlreadyExists(productCategory.getName())) {
            return false;
        }
        if (productCategory.getName() == null || productCategory.getName().trim().isEmpty()) {
            return false;
        }
        return productCategory.getDescription() != null && !productCategory.getDescription().trim().isEmpty();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryDAO productCategoryDAO = new CategoryDAOImpl();

        Category productCategory = new Category(
                null,
                request.getParameter("category_name"),
                request.getParameter("category_description"),
                true
        );

        boolean isCategoryValid = validateCategoryInput(productCategory);

        if (isCategoryValid) {
            try {
                if (productCategoryDAO.getCategoryByName(productCategory.getName()) == null) {
                    productCategoryDAO.addCategory(productCategory);
                    request.getSession().setAttribute("categorySuccessMessage", "Category Added Successfully");
                }
            } catch (SQLException | ClassNotFoundException e) {
                request.getSession().setAttribute("categoryErrorMessage", "An error occurred while adding category, please try again later!");
            }
        }else {
            request.getSession().setAttribute("categoryErrorMessage", "Category already exists or invalid input!");
        }
        response.sendRedirect(request.getContextPath() +"/admin/add-category-brand.jsp");
    }
}
