package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.BrandDAO;
import com.mephx.database.DatabaseConnection;
import com.mephx.model.Brand;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BrandDAOImpl extends DatabaseConnection implements BrandDAO {

    @Override
    public ArrayList<Brand> getAllBrands(Boolean getInvisible) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();

        ArrayList<Brand> brands = new ArrayList<>();

        String query = "SELECT * FROM brand";

        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        do {
            if(rs.getBoolean("visibility") || getInvisible) {
                brands.add(new Brand(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getBoolean("visibility")
                ));
            }
        } while (rs.next());
        con.close();
        ps.close();
        return brands;
    }

    @Override
    public void createBrand(Brand brand) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "INSERT INTO brand (name, image) VALUES (?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, brand.getName());
        ps.setString(2, brand.getImage());
        ps.execute();
        con.close();
        ps.close();
    }



    @Override
    public void updateBrand(Brand brand) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE brand SET name = ?, image = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, brand.getName());
        ps.setString(2, brand.getImage());
        ps.setInt(3, brand.getId());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void editBrandVisibility(Integer id, Boolean currentVisibility) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE brand SET visibility = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setBoolean(1, !currentVisibility);
        ps.setInt(2, id);
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public Brand getBrandById(Integer id) throws ClassNotFoundException, SQLException {
        Brand brand = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT * FROM brand WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            brand = new Brand(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getBoolean("visibility")
            );
        }
        con.close();
        ps.close();
        return brand;
    }

    @Override
    public Brand getBrandByName(String name) throws ClassNotFoundException, SQLException {
        Brand brand = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT * FROM brand WHERE name = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, name);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            brand = new Brand(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("image"),
                    rs.getBoolean("visibility")
            );
        }
        con.close();
        ps.close();
        return brand;
    }
}
