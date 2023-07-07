package com.mephx.controller.brand;

import com.mephx.DAO.implementations.BrandDAOImpl;
import com.mephx.model.Brand;
import com.mephx.utils.ImageUploadHandler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "add-brand", value = "/add-brand")
@MultipartConfig
public class CreateBrand extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    public boolean checkIfBrandAlreadyExists(Brand brand){
        BrandDAOImpl brandDAO = new BrandDAOImpl();
        try{
            if (brandDAO.getBrandByName(brand.getName())==null) return false;
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
        return true;
    }

    public boolean validateUserInput(Brand brand){
        if (checkIfBrandAlreadyExists(brand)) {
            return false;
        }
        if (brand.getName() == null || brand.getName().trim().isEmpty()) {
            return false;
        }else return brand.getImage() != null && !brand.getImage().isEmpty();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        ImageUploadHandler img = new ImageUploadHandler();
        BrandDAOImpl brandDAO = new BrandDAOImpl();

        String name = request.getParameter("brand_name");
        Part filePart = request.getPart("image");
        String fileSavePath = "";

        try{
            fileSavePath = img.saveUploadedImage(filePart, "/assets/uploads/brand/", getServletContext().getRealPath("/") + "assets/uploads/brand/");
        } catch (FileNotFoundException e){
            request.getSession().setAttribute("brandErrorMessage", "Something went wrong, Please try again! Maybe try adding images?");
            response.sendRedirect(request.getContextPath()+"/admin/add-category-brand.jsp");
            return;
        }

        Brand brand = new Brand(
                null,
                name,
                fileSavePath,
        true
        );

        if (validateUserInput(brand)){
            try {
                brandDAO.createBrand(brand);
                request.getSession().setAttribute("brandSuccessMessage", "Brand Added Successfully");
            } catch (SQLException | ClassNotFoundException e) {
                request.getSession().setAttribute("brandErrorMessage", "Something Went Wrong, Please Try Again!");
            }
        }else {
            request.getSession().setAttribute("brandErrorMessage", "Brand with the name Already Exists or Invalid Input");
        }
        response.sendRedirect(request.getContextPath()+"/admin/add-category-brand.jsp");
    }
}
