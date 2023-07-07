package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.CartDAO;
import com.mephx.database.DatabaseConnection;
import com.mephx.model.Cart;
import com.mephx.model.Product;
import com.mephx.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CartDAOImpl extends DatabaseConnection implements CartDAO {
    @Override
    public void createCart(Cart cart) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "INSERT INTO cart(user_id) VALUES (?)";

        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cart.getUser_id());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void updateCart(Cart cart) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE cart SET is_checked_out = ?, modified_at = CURRENT_TIMESTAMP WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setBoolean(1, cart.getIsCartCheckedOut());
        ps.setInt(2, cart.getCartId());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void deleteCart(Cart cart) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "DELETE FROM cart WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cart.getCartId());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public Cart getCartByUserId(Integer userId) throws ClassNotFoundException, SQLException {
        Cart cart = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT * FROM cart WHERE user_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            if (!rs.getBoolean("is_checked_out")) {
                cart = new Cart(
                    rs.getInt("id"),
                    rs.getInt("user_id"),
                    rs.getBoolean("is_checked_out"),
                    rs.getString("created_at"),
                    rs.getString("modified_at")
                );
            }
        }
        con.close();
        ps.close();
        return cart;
    }
}
