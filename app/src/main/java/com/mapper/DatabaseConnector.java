package com.mapper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnector {
    public static Connection connect() throws SQLException {
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // 替换以下信息为你的数据库连接参数
            String url = "jdbc:mysql://localhost:3306/user_login";
            String username = "root";
            String password = "ZZjj123456";

            // 建立数据库连接
            return DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found", e);
        }
    }
}
