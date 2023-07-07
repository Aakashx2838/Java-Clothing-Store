package com.mephx.controller.brand;

import com.mephx.DAO.implementations.BrandDAOImpl;
import com.mephx.DAO.interfaces.BrandDAO;
import com.mephx.controller.auth.ValidateCredentials;
import com.mephx.model.Brand;
import com.mephx.model.User;
import com.mephx.utils.ImageUploadHandler;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "update-brand", value = "/update-brand")
@MultipartConfig
public class UpdateBrand extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Cookie[] cookies = request.getCookies();
        ValidateCredentials vc = new ValidateCredentials();
        ImageUploadHandler img = new ImageUploadHandler();
        BrandDAO brandDAO = new BrandDAOImpl();

        Integer id = Integer.parseInt(request.getParameter("brandId"));
        Part filePart = request.getPart("image");
        String fileSavePath = "";

        try{
            fileSavePath = img.saveUploadedImage(filePart, "/assets/uploads/brand/", getServletContext().getRealPath("/") + "assets/uploads/brand/");
        } catch (FileNotFoundException e){
            fileSavePath = request.getParameter("oldImage");
        }
        Brand brand = new Brand(
                id,
                request.getParameter("brand_name"),
                fileSavePath,
                true
        );

        try {
            User user = vc.checkCookie(cookies);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            request.getSession().setAttribute("brandEditMessage", "Brand Edited Successfully");
            brandDAO.updateBrand(brand);
            response.sendRedirect( request.getContextPath() + "/admin/edit-brand.jsp?brandId=" + id);
        } catch (SQLException | ClassNotFoundException ex) {
            request.getSession().setAttribute("brandEditErrorMessage", "Something Went Wrong, Please Try Again!");
            response.sendRedirect(request.getContextPath() + "/admin/edit-brand.jsp?brandId=" + id);
        }
    }
}
