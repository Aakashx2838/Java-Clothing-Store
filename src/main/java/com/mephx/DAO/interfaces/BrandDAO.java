package com.mephx.DAO.interfaces;

import com.mephx.model.Brand;

import java.sql.SQLException;
import java.util.ArrayList;

public interface BrandDAO {
    ArrayList<Brand> getAllBrands(Boolean getInvisible) throws SQLException, ClassNotFoundException;
    void createBrand(Brand brand) throws SQLException, ClassNotFoundException;
    void updateBrand(Brand brand) throws ClassNotFoundException, SQLException;
    void editBrandVisibility(Integer id, Boolean currentVisibility) throws SQLException, ClassNotFoundException;
    Brand getBrandByName(String name) throws ClassNotFoundException, SQLException;
    Brand getBrandById(Integer id) throws ClassNotFoundException, SQLException;
}
