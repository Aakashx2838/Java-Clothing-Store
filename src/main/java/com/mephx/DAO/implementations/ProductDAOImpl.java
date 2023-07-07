package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.ProductDAO;
import com.mephx.database.DatabaseConnection;
import com.mephx.model.Brand;
import com.mephx.model.Category;
import com.mephx.model.Product;

import java.sql.*;
import java.util.ArrayList;

public class ProductDAOImpl extends DatabaseConnection implements ProductDAO {
    @Override
    public void addProduct(Product product) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        StringBuilder query = new StringBuilder();
        int j = 4;

        String iniQuery = "INSERT INTO product(name, price, rating, color, size, images, quantity, description, brand_id, category_id, reviews) VALUES (?,?,?,JSON_ARRAY(";
        query.append(iniQuery);
        // Appending Colors
        for (int i = 0; i < product.getColorArray().length; i++) {
            query.append("?");
            if (i < product.getColorArray().length - 1) {
                query.append(",");
            }
        }
        query.append("), JSON_ARRAY(");
        // Appending Sizes
        for (int i = 0; i < product.getSizeArray().length; i++) {
            query.append("?");
            if (i < product.getSizeArray().length - 1) {
                query.append(",");
            }
        }
        query.append("), JSON_ARRAY(");
        // Appending Images
        for (int i = 0; i < product.getImagesArray().length; i++) {
            query.append("?");
            if (i < product.getImagesArray().length - 1) {
                query.append(",");
            }
        }
        query.append("),");
        query.append("?, ?, ?, ?, ?)");
        PreparedStatement ps = con.prepareStatement(query.toString());
        ps.setString(1, product.getName());
        ps.setDouble(2, product.getPrice());
        ps.setInt(3, product.getRating());
        for (int i = 0; i < product.getColorArray().length; i++, j++) { //7
            ps.setString(i + 4, product.getColorArray()[i]);
        }
        for (int i = 0; i < product.getSizeArray().length; i++, j++) { //10
            ps.setString(i + 4 + product.getColorArray().length, product.getSizeArray()[i]);
        }
        for (int i = 0; i < product.getImagesArray().length; i++, j++) { //11
            ps.setString(i + 4 + product.getColorArray().length + product.getSizeArray().length, product.getImagesArray()[i]);
        }
        ps.setInt(j, product.getQuantity());
        ps.setString(j + 1, product.getDescription());
        ps.setInt(j + 2, product.getBrand().getId());
        ps.setInt(j + 3, product.getCategory().getId());
        ps.setInt(j + 4, product.getReviews());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void updateProduct(Product product) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        StringBuilder query = new StringBuilder();
        String iniQuery = "UPDATE product SET name = ?, price = ?, rating = ?, quantity = ?, description = ?, reviews = ?, brand_id = ?, category_id = ? , color = JSON_ARRAY(";
        query.append(iniQuery);
        // Appending Colors
        for (int i = 0; i < product.getColorArray().length; i++) {
            query.append("?");
            if (i < product.getColorArray().length - 1) {
                query.append(",");
            }
        }
        query.append("), size = JSON_ARRAY(");
        // Appending Sizes
        for (int i = 0; i < product.getSizeArray().length; i++) {
            query.append("?");
            if (i < product.getSizeArray().length - 1) {
                query.append(",");
            }
        }
        query.append(")");
        if (!product.getImagesArray()[0].isBlank()) {
            query.append(", images = JSON_ARRAY(");
            // Appending Images
            for (int i = 0; i < product.getImagesArray().length; i++) {
                query.append("?");
                if (i < product.getImagesArray().length - 1) {
                    query.append(",");
                }
            }
            query.append(")");
        }

        query.append(" WHERE product.id = ?");
        PreparedStatement ps = con.prepareStatement(query.toString());
        ps.setString(1, product.getName());
        ps.setDouble(2, product.getPrice());
        ps.setDouble(3, product.getRating());
        ps.setInt(4, product.getQuantity());
        ps.setString(5, product.getDescription());
        ps.setInt(6, product.getReviews());
        ps.setInt(7, product.getBrand().getId());
        ps.setInt(8, product.getCategory().getId());
        int j = 9;
        for (int i = 0; i < product.getColorArray().length; i++, j++) { //7
            ps.setString(i + 9, product.getColorArray()[i].strip());
        }
        for (int i = 0; i < product.getSizeArray().length; i++, j++) { //10
            ps.setString(i + 9 + product.getColorArray().length, product.getSizeArray()[i].strip());
        }
        if (!product.getImagesArray()[0].isBlank()) {
            for (int i = 0; i < product.getImagesArray().length; i++, j++) { //11
                ps.setString(i + 9 + product.getColorArray().length + product.getSizeArray().length, product.getImagesArray()[i]);
            }
        }
        ps.setInt(j, product.getId());
        ps.execute();
        con.close();
        ps.close();

    }

    @Override
    public void editProductVisibility(Integer productId, Boolean currentVisibility) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE product SET visibility = ? WHERE product.id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setBoolean(1, !currentVisibility);
        ps.setInt(2, productId);
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public Product getProductById(Integer id) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT p.*, b.image, b.name AS brand_name, c.name AS category_name, c.description AS category_description  FROM product p JOIN brand b ON p.brand_id = b.id JOIN category c ON p.category_id = c.id  WHERE p.id = ?";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        Product product = new Product(
            rs.getInt("id"),
            rs.getString("name"),
            rs.getDouble("price"),
            rs.getInt("rating"),
            rs.getString("color"),
            rs.getString("size"),
            rs.getInt("quantity"),
            rs.getString("images"),
            rs.getString("description"),
            rs.getInt("reviews"),
            new Brand(
                rs.getInt("brand_id"),
                rs.getString("brand_name"),
                rs.getString("image"),
                rs.getBoolean("visibility")
            ),
            new Category(
                rs.getInt("category_id"),
                rs.getString("category_name"),
                rs.getString("category_description"),
                rs.getBoolean("visibility")
            ),
            rs.getBoolean("visibility")
        );
        con.close();
        ps.close();
        return product;
    }

    @Override
    public ArrayList<Product> getAllProducts(String sort, String search, String limit, String listBy, String filterId, Boolean getInvisible) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        ArrayList<Product> products = new ArrayList<>();
        Connection con = getConnection();

        StringBuilder filter = new StringBuilder();
        if (!search.equals("")) {
            filter.append("WHERE p.name LIKE '%").append(search).append("%'");
        }
        if (!sort.equals("")) {
            filter.append(" ORDER BY ").append(sort);
        }
        if (!listBy.equals("")) {
            switch (listBy){
                case "brand":
                    filter.append(" WHERE p.brand_id = ").append(filterId);
                    break;
            }
            switch (listBy){
                case "category":
                    filter.append(" WHERE p.category_id = ").append(filterId);
                    break;
            }
            switch (listBy) {
                case "new":
                    filter.append(" ORDER BY p.id DESC");
                    break;
                case "popular":
                    filter.append(" ORDER BY p.rating DESC");
                    break;
                case "priceHL":
                    filter.append(" ORDER BY p.price DESC");
                    break;
                case "priceLH":
                    filter.append(" ORDER BY p.price");
                    break;
                case "random":
                    filter.append(" ORDER BY RAND()");
                    break;
            }
        }
        if (!limit.equals("")) {
            filter.append(" LIMIT ").append(limit);
        }

        String query = "SELECT p.*, b.image, b.name AS brand_name, c.name AS category_name, c.description AS category_description FROM product p JOIN brand b ON p.brand_id = b.id JOIN category c ON p.category_id = c.id " + filter + " ;";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        do {
            if (rs.getBoolean("visibility") || getInvisible) {
                products.add(
                    new Product(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("rating"),
                        rs.getString("color"),
                        rs.getString("size"),
                        rs.getInt("quantity"),
                        rs.getString("images"),
                        rs.getString("description"),
                        rs.getInt("reviews"),
                        new Brand(
                            rs.getInt("brand_id"),
                            rs.getString("brand_name"),
                            rs.getString("image"),
                            rs.getBoolean("visibility")
                        ),
                        new Category(
                            rs.getInt("category_id"),
                            rs.getString("category_name"),
                            rs.getString("category_description"),
                            rs.getBoolean("visibility")
                        ),
                        rs.getBoolean("visibility")
                    )
                );
            }
        }while (rs.next());
        con.close();
        ps.close();
        return products;
    }
}
