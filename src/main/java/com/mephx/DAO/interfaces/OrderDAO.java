package com.mephx.DAO.interfaces;

import com.mephx.model.Order;
import com.mephx.model.UserOrderProductView;

import java.sql.SQLException;
import java.util.ArrayList;

public interface OrderDAO {
    void addOrder(Order order) throws SQLException, ClassNotFoundException;

    void updateOrder(Order order) throws ClassNotFoundException, SQLException;

    Order getOrderById(Integer id) throws SQLException, ClassNotFoundException;

    ArrayList<UserOrderProductView> getAllOrders(Integer id) throws SQLException, ClassNotFoundException;
}
