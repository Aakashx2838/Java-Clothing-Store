package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.OrderDAO;
import com.mephx.database.DatabaseConnection;
import com.mephx.model.Order;
import com.mephx.model.UserOrderProductView;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class OrderDAOImpl extends DatabaseConnection implements OrderDAO {
    @Override
    public void addOrder(Order order) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "INSERT INTO orders (cart_id, is_delivered, order_total) VALUES (?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, order.getCartId());
        ps.setBoolean(2, false);
        ps.setDouble(3, order.getOrderTotal());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    public void updateOrder(Order order) throws ClassNotFoundException, SQLException {

    }

    @Override
    public Order getOrderById(Integer id) throws SQLException, ClassNotFoundException {
        return null;
    }

    @Override
    public ArrayList<UserOrderProductView> getAllOrders(Integer id) throws SQLException, ClassNotFoundException {
        ArrayList<UserOrderProductView> orders = new ArrayList<>();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT o.id AS order_id, o.cart_id, c.user_id, SUM(ci.quantity) AS total_items, SUM(ci.quantity * p.price) AS total_price, GROUP_CONCAT(CONCAT(ci.color) SEPARATOR '; ') AS colors, GROUP_CONCAT(CONCAT(ci.size) SEPARATOR '; ') AS sizes, u.first_name, u.last_name, GROUP_CONCAT(CONCAT(ci.quantity) SEPARATOR '; ') AS quantities, GROUP_CONCAT(CONCAT(p.price) SEPARATOR '; ') AS prices, GROUP_CONCAT(CONCAT(p.name) SEPARATOR '; ') AS products, o.is_delivered FROM orders o JOIN cart c ON o.cart_id = c.id JOIN cart_item ci ON c.id = ci.cart_id JOIN user u ON c.user_id = u.id JOIN product p ON ci.product_id = p.id ";
        if(id != null){
            query += "WHERE user_id = " + id;
        }
        query += " GROUP BY o.id";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()){
            return null;
        }
        do {
            orders.add(new UserOrderProductView(
                rs.getInt("order_id"),
                rs.getInt("cart_id"),
                rs.getInt("user_id"),
                rs.getInt("total_items"),
                rs.getDouble("total_price"),
                rs.getString("colors"),
                rs.getString("sizes"),
                rs.getString("quantities"),
                rs.getString("prices"),
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getString("products"),
                rs.getBoolean("is_delivered")
            ));
        } while (rs.next());
        return orders;
    }
}
