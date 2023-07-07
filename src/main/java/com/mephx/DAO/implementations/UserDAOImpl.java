package com.mephx.DAO.implementations;

import com.mephx.DAO.interfaces.UserDAO;
import com.mephx.database.DatabaseConnection;
import com.mephx.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class UserDAOImpl extends DatabaseConnection implements UserDAO {

    @Override
    //add new user
    public void addUser(User user) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "INSERT INTO user(first_name, last_name, address, email, password, sex, profile_picture, date_of_birth, phone) VALUES (?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, user.getFirst_name());
        ps.setString(2, user.getLast_name());
        ps.setString(3, user.getAddress());
        ps.setString(4, user.getEmail());
        ps.setString(5, user.getPassword());
        ps.setString(6, user.getSex());
        ps.setString(7, user.getImage());
        ps.setString(8, user.getDateOfBirth());
        ps.setLong(9, user.getPhone());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    //change user data in the database
    public void updateUser(User user, HashMap<String,String> updates) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String iniQuery = "UPDATE user SET ";
        int updatesLength = updates.size();
        StringBuilder query = new StringBuilder(iniQuery);
        for (String key : updates.keySet()){
            if (updates.get(key) != null) {
                if (!updates.get(key).isBlank()){
                    query.append(key).append(" = ").append('?');
                    if (updatesLength > 1) {
                        query.append(", ");
                    }
                }
            }
        }
        query.deleteCharAt(query.lastIndexOf(", "));
        query.append("WHERE email = ? AND password = ?");

        PreparedStatement ps = con.prepareStatement(query.toString());
        int i = 1;
        for (String key : updates.keySet()){
            if (updates.get(key) != null) {
                if (!updates.get(key).isBlank()){
                    ps.setString(i, updates.get(key));
                    i++;
                }
            }
        }
        ps.setString(i, user.getEmail());
        ps.setString(i+1, user.getPassword());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    //Delete user from the database
    public void deleteUser(User user) throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "UPDATE user SET is_active = ? WHERE email = ? AND password = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setBoolean(1, false);
        ps.setString(2, user.getEmail());
        ps.setString(3, user.getPassword());
        ps.execute();
        con.close();
        ps.close();
    }

    @Override
    //Gets user details by using email
    public User getUserByEmail(String email) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        User user = null;
        Connection con = getConnection();
        String query = "SELECT * FROM user WHERE email = ?"; //Query for fetching details of user using email
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null; //If the user is not matched returns null
        }
        if(rs.getBoolean("is_active")){
            user = new User(
                rs.getInt("id"),
                rs.getString("first_name"),
                rs.getString("last_name"),
                Date.valueOf(rs.getString("date_of_birth")).toString(),
                rs.getString("sex"),
                rs.getString("email"),
                rs.getString("password"),
                rs.getString("address"),
                rs.getString("profile_picture"),
                rs.getString("role"),
                Long.parseLong(rs.getString("phone"))
            );
        }
        con.close();
        ps.close();
        return user;
    }

    @Override
    public ArrayList<User> getAllUsers() throws SQLException, ClassNotFoundException {
        ArrayList<User> users = new ArrayList<>();

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();
        String query = "SELECT id, first_name, last_name, address, email, sex, profile_picture, date_of_birth, phone, is_active FROM user";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        if (!rs.next()) {
            return null; //If the user is not matched returns null
        }
        do {
            if (rs.getBoolean("is_active")) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("first_name"),
                        rs.getString("last_name"),
                        Date.valueOf(rs.getString("date_of_birth")).toString(),
                        rs.getString("sex"),
                        rs.getString("email"),
                        null,
                        rs.getString("address"),
                        rs.getString("profile_picture"),
                        null,
                        Long.parseLong(rs.getString("phone"))
                ));
            }
        }while (rs.next());
        con.close();
        ps.close();
        return users;
    }

}
