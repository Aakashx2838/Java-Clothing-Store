package com.mephx.DAO.implementations;

import com.mephx.database.DatabaseConnection;
import com.mephx.model.AdminStatisticsView;
import com.mephx.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class WebStatistics extends DatabaseConnection {

    public AdminStatisticsView getAdminStatistics() throws ClassNotFoundException, SQLException {
        AdminStatisticsView asv = null;

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = getConnection();

        String query = "SELECT u.total_users, o.total_sales, p.total_products, b.total_brands, c.total_categories FROM (SELECT COUNT(*) as total_users FROM user) as u, (SELECT SUM(order_total) as total_sales FROM orders) as o, (SELECT COUNT(*) as total_products FROM product) as p, (SELECT COUNT(*) as total_brands FROM brand) as b, (SELECT COUNT(*) as total_categories FROM category) as c ";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        while (rs.next()){
            asv = new AdminStatisticsView(
                rs.getInt("total_users"),
                rs.getInt("total_sales"),
                rs.getInt("total_products"),
                rs.getInt("total_categories"),
                rs.getInt("total_brands")
            );
        }
        ps.close();

        return asv;
    }

}
