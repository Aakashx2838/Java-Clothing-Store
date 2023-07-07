package com.mephx.controller.product;

import com.google.gson.Gson;
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
import java.util.ArrayList;

@WebServlet(name = "nav-search-product", value = "/nav-search-product")
public class NavSearch extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        ProductDAO productDAO = new ProductDAOImpl();
        ArrayList<Product> products = null;
        try {
            products = productDAO.getAllProducts("", searchQuery,"", "", "", false);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        Gson gson = new Gson();
        String json = gson.toJson(products);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
