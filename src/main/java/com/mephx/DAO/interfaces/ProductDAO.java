package com.mephx.DAO.interfaces;

import com.mephx.model.Product;

import java.sql.SQLException;
import java.util.ArrayList;

public interface ProductDAO {
    void addProduct(Product product) throws SQLException, ClassNotFoundException;

    void updateProduct(Product product) throws ClassNotFoundException, SQLException;

    void editProductVisibility(Integer productId, Boolean currentVisibility) throws ClassNotFoundException, SQLException;

    Product getProductById(Integer id) throws ClassNotFoundException, SQLException;

    ArrayList<Product> getAllProducts(String sort, String search, String limit, String listBy, String filterId, Boolean getInvisible) throws SQLException, ClassNotFoundException;
}
