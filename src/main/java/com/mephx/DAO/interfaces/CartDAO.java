package com.mephx.DAO.interfaces;

import com.mephx.model.Cart;
import com.mephx.model.User;

import java.sql.SQLException;
import java.util.ArrayList;

public interface CartDAO {
    void createCart(Cart cart) throws SQLException, ClassNotFoundException;

    void updateCart(Cart cart) throws SQLException, ClassNotFoundException;

    void deleteCart(Cart cart) throws SQLException, ClassNotFoundException;

    Cart getCartByUserId(Integer userId) throws ClassNotFoundException, SQLException;
}
