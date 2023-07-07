package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.CartDAO;
import com.mephx.DAO.interfaces.CartItemDAO;
import com.mephx.DAO.interfaces.ProductDAO;
import com.mephx.database.DatabaseConnection;
import com.mephx.model.Cart;
import com.mephx.model.CartItem;
import com.mephx.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CartItemDAOImpl extends DatabaseConnection implements CartItemDAO {
    @Override
    public void addItemToCart(CartItem cartItem) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "INSERT INTO cart_item(cart_id, product_id, quantity, item_total, size, color) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cartItem.getCart_id());
        ps.setInt(2, cartItem.getProduct_id());
        ps.setInt(3, cartItem.getQuantity());
        ps.setDouble(4, cartItem.getItemTotal());
        ps.setString(5, cartItem.getSize());
        ps.setString(6, cartItem.getColor());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void updateCartItem(CartItem cartItem) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE cart_item SET quantity = ?, item_total = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cartItem.getQuantity());
        ps.setDouble(2, cartItem.getItemTotal());
        ps.setInt(3, cartItem.getId());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void deleteCartItem(Integer cartItemId) throws SQLException, ClassNotFoundException{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "DELETE FROM cart_item WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cartItemId);
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void deleteAllCartItemsByUserId(Integer userId) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        ProductDAO productDAO = new ProductDAOImpl();
        CartDAO cartDAO = new CartDAOImpl();
        ArrayList<CartItem> cartItems = getCartItemsByUserId(userId);

        if (cartItems == null) {
            return;
        }

        Connection con = getConnection();

        for (CartItem cartItem : cartItems) {
            Product product = productDAO.getProductById(cartItem.getProduct_id());
            productDAO.updateProduct(
                new Product(
                    product.getId(),
                    product.getName(),
                    product.getPrice(),
                    product.getRating(),
                    product.getColor(),
                    product.getSize(),
                    product.getQuantity() + cartItem.getQuantity(),
                    product.getImages(),
                    product.getDescription(),
                    product.getReviews(),
                    product.getBrand(),
                    product.getCategory(),
                    product.getVisibility()
                )
            );
        }

        String query = "DELETE FROM cart_item WHERE cart_id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cartDAO.getCartByUserId(userId).getCartId());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public ArrayList<CartItem> getCartItemsByUserId(Integer userId) throws ClassNotFoundException, SQLException {
        ArrayList<CartItem> cartItems = new ArrayList<>();
        CartDAO cartDAO = new CartDAOImpl();
        Cart cart = cartDAO.getCartByUserId(userId);
        if (cart == null) {
            return null;
        }

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT * FROM cart_item WHERE cart_id = ? ";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, cart.getCartId());
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        do {
            cartItems.add(new CartItem(
                rs.getInt("id"),
                rs.getInt("cart_id"),
                rs.getInt("product_id"),
                rs.getInt("quantity"),
                rs.getDouble("item_total"),
                rs.getString("color"),
                rs.getString("size")
            ));
        } while (rs.next());
        con.close();
        ps.close();
        return cartItems;
    }
}
