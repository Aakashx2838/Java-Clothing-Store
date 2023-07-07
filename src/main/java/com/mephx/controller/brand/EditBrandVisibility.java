package com.mephx.controller.brand;

import com.mephx.DAO.implementations.BrandDAOImpl;
import com.mephx.DAO.interfaces.BrandDAO;
import com.mephx.model.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "edit-brand-visibility", value = "/edit-brand-visibility")
public class EditBrandVisibility extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer id = Integer.parseInt(request.getParameter("brandId"));
        Boolean currentVisibility = Boolean.parseBoolean(request.getParameter("currentVisibility"));
        BrandDAO brandDAO = new BrandDAOImpl();
        try {
            Brand brand = brandDAO.getBrandById(id);
            if (brand != null) {
                brandDAO.editBrandVisibility(id, currentVisibility);
                request.getSession().setAttribute("successMessage", "Brand visibility changed");
            }else {
                request.getSession().setAttribute("errorMessage", "Brand Not Found");
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.getSession().setAttribute("errorMessage", "Something Went Wrong, Please Try Again!");
        }
        response.sendRedirect(request.getContextPath() + "/admin/manage-brand.jsp");
    }
}
