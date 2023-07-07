package com.mephx.controller.product;

import com.mephx.DAO.implementations.ProductDAOImpl;
import com.mephx.DAO.interfaces.ProductDAO;
import com.mephx.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "edit-product-visibility", value = "/edit-product-visibility")
public class EditProductVisibility extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("productId"));
        Boolean currentVisibility = Boolean.parseBoolean(request.getParameter("currentVisibility"));
        ProductDAO productDAO = new ProductDAOImpl();
        try {
            Product product = productDAO.getProductById(id);
            if (product != null) {
                productDAO.editProductVisibility(id, currentVisibility);
                request.getSession().setAttribute("successMessage", "Product visibility changed");
            }else {
                request.getSession().setAttribute("errorMessage", "Product Not Found");
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.getSession().setAttribute("errorMessage", "Something Went Wrong, Please Try Again!");
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-product.jsp");
    }
}
