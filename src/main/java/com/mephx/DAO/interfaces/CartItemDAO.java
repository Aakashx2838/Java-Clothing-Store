package com.mephx.DAO.interfaces;

import com.mephx.model.CartItem;
import com.mephx.model.Product;

import java.sql.SQLException;
import java.util.ArrayList;

public interface CartItemDAO {
    void addItemToCart(CartItem cartItem) throws SQLException, ClassNotFoundException;

    void updateCartItem(CartItem cartItem) throws SQLException, ClassNotFoundException;

    void deleteCartItem(Integer cartItemId) throws SQLException, ClassNotFoundException;

    ArrayList<CartItem> getCartItemsByUserId(Integer userId) throws ClassNotFoundException, SQLException;

    void deleteAllCartItemsByUserId(Integer userId) throws SQLException, ClassNotFoundException;

}
