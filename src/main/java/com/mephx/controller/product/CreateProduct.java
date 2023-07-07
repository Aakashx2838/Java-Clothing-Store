package com.mephx.controller.product;

import com.mephx.DAO.implementations.BrandDAOImpl;
import com.mephx.DAO.implementations.CategoryDAOImpl;
import com.mephx.DAO.implementations.ProductDAOImpl;
import com.mephx.DAO.interfaces.ProductDAO;
import com.mephx.model.Product;
import com.mephx.utils.ImageUploadHandler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import java.util.Random;

@WebServlet(name = "create-product", value = "/create-product")
@MultipartConfig
public class CreateProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ImageUploadHandler img = new ImageUploadHandler();
        ProductDAO productDAO = new ProductDAOImpl();
        String images;
        Product product = null;

        Collection<Part> fileParts = request.getParts();
        try {
            images = img.saveUploadedImageArray((List<Part>) fileParts, "/assets/uploads/products/", getServletContext().getRealPath("/") + "assets/uploads/products/").toString();
        }catch (FileNotFoundException e){
            request.getSession().setAttribute("errorMessage", "Could not add product, please try adding images maybe?");
            response.sendRedirect(request.getContextPath() + "/admin/add-product.jsp");
            return;
        }
        try {
           product = new Product(
                    null,
                    request.getParameter("product_name"),
                    Double.parseDouble(request.getParameter("price")),
                    new Random().nextInt(5),
                    request.getParameter("colors"),
                    request.getParameter("sizes"),
                    Integer.parseInt(request.getParameter("quantity")),
                    images,
                    request.getParameter("description"),
                    new Random().nextInt(1000),
                    new BrandDAOImpl().getBrandById(Integer.parseInt(request.getParameter("brand"))),
                    new CategoryDAOImpl().getCategoryById(Integer.parseInt(request.getParameter("category"))),
                   true
            );
        }catch (NumberFormatException | SQLException | ClassNotFoundException e){
            request.getSession().setAttribute("errorMessage", "Could not add product, please try again later! Maybe try inputting the correct data ?");
        }
        try {
            if (product != null){
                productDAO.addProduct(product);
                request.getSession().setAttribute("successMessage", "Product Added Successfully");
            }
        } catch (SQLException | ClassNotFoundException e) {
            request.getSession().setAttribute("errorMessage", "Could not add product, please try again later! Maybe the product with the name already exists");
        }
        response.sendRedirect(request.getContextPath() + "/admin/add-product.jsp");
    }
}
