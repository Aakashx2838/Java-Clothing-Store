package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.CategoryDAO;
import com.mephx.model.Category;
import com.mephx.database.DatabaseConnection;


import java.sql.*;
import java.util.ArrayList;



public class CategoryDAOImpl extends DatabaseConnection implements CategoryDAO {

    public void addCategory(Category category) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "INSERT INTO category (name, description, visibility) VALUES (?,?, true)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, category.getName());
        ps.setString(2, category.getDescription());

        ps.execute();
        con.close();
        ps.close();
    }

    public void updateCategory(Category category) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE category SET name = ?, description = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, category.getName());
        ps.setString(2, category.getDescription());
        ps.setInt(3, category.getId());
        ps.execute();
        con.close();
        ps.close();
    }

    public void editCategoryVisibility(Integer id, Boolean currentVisibility) throws SQLException, ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE category SET visibility = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setBoolean(1, !currentVisibility);
        ps.setInt(2, id);
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public Category getCategoryByName(String name) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();

        String query = "SELECT * FROM category WHERE name = ?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);

        ResultSet rs = ps.executeQuery();
        Category productCategory = new Category();

        if (!rs.next()) {
            return null;
        }

        while (rs.next()) {
            rs.getString("category_id");
            rs.getString("name");
            rs.getString("description");
        }
        con.close();
        ps.close();
        return productCategory;
    }

    @Override
    public ArrayList<Category> getAllCategories(Boolean getInvisible) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();

        ArrayList<Category> productCategories = new ArrayList<>();

        String query = "SELECT * FROM category";

        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        do {
            if (rs.getBoolean("visibility") || getInvisible ) {
                productCategories.add(new Category(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getBoolean("visibility")
                ));
            }
        } while (rs.next());
        con.close();
        ps.close();
        return productCategories;
    }

    @Override
    public Category getCategoryById(Integer id) throws ClassNotFoundException, SQLException {
        Category category = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT * FROM category WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            category = new Category(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getBoolean("visibility")
            );
        }
        con.close();
        ps.close();
        return category;
    }
}
