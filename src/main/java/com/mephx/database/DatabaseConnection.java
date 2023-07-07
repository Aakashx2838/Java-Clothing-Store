package com.mephx.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    public Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + DBCredentials.getDbName(), DBCredentials.getDbUsername(), DBCredentials.getDbPassword());
            if (conn != null) {
                System.out.println("Connection Established!");
            } else {
                System.out.println("Connection Failed!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}
