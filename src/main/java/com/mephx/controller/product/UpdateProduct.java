package com.mephx.controller.product;

import com.mephx.DAO.implementations.BrandDAOImpl;
import com.mephx.DAO.implementations.CategoryDAOImpl;
import com.mephx.DAO.implementations.ProductDAOImpl;
import com.mephx.DAO.interfaces.ProductDAO;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.Product;
import com.mephx.model.User;
import com.mephx.utils.ImageUploadHandler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.List;
import java.util.Random;


@WebServlet(name = "update-product", value = "/update-product")
@MultipartConfig
public class UpdateProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Cookie[] cookies = request.getCookies();
        ValidateCredentials vc = new ValidateCredentials();
        ImageUploadHandler img = new ImageUploadHandler();
        ProductDAO productDAO = new ProductDAOImpl();

        Integer id = Integer.parseInt(request.getParameter("productId"));
        Product product;
        String images;
        Collection<Part> fileParts = request.getParts();

        try{
            images = img.saveUploadedImageArray((List<Part>) fileParts, "/assets/uploads/products/", getServletContext().getRealPath("/") + "assets/uploads/products/").toString();
        } catch (FileNotFoundException e){
            images = null;
        }

        try{
            product = new Product(
                id,
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

            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            request.getSession().setAttribute("productEditMessage", "Product Edited Successfully");
            productDAO.updateProduct(product);
            response.sendRedirect(request.getContextPath() + "/admin/edit-product.jsp?productId=" + id);
        } catch (SQLException | ClassNotFoundException ex) {
            request.getSession().setAttribute("productEditErrorMessage", "Something Went Wrong, Please Try Again!");
            response.sendRedirect(request.getContextPath() + "/admin/edit-product.jsp?productId=" + id);
            ex.printStackTrace();
        }
    }

}
