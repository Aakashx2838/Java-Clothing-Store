package com.mephx.DAO.interfaces;

import com.mephx.model.Category;

import java.sql.SQLException;
import java.util.ArrayList;

public interface CategoryDAO {

    void addCategory(Category category) throws SQLException, ClassNotFoundException;

    void updateCategory(Category category) throws ClassNotFoundException, SQLException;

    void editCategoryVisibility(Integer id, Boolean currentVisibility) throws SQLException, ClassNotFoundException;

    Category getCategoryByName(String name) throws ClassNotFoundException, SQLException;

    Category getCategoryById(Integer id) throws ClassNotFoundException, SQLException;

    ArrayList<Category> getAllCategories(Boolean getInvisible) throws SQLException, ClassNotFoundException;

}
