package com.mephx.DAO.interfaces;

import com.mephx.model.User;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public interface UserDAO {

    ArrayList<User> getAllUsers() throws SQLException, ClassNotFoundException;

    void addUser(User user) throws SQLException, ClassNotFoundException;

    void updateUser(User user, HashMap<String,String> updates) throws ClassNotFoundException, SQLException;

    void deleteUser(User user) throws ClassNotFoundException, SQLException;

    User getUserByEmail(String email) throws SQLException, ClassNotFoundException;
}
