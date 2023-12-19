package com.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
// import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// @WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                // System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhh");
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        // 获取前端传递的参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // JDBC连接参数
        String jdbcUrl = "jdbc:mysql://localhost:3306/user_login";
        String dbUsername = "root";
        String dbPassword = "ZZjj123456";

        // SQL查询语句
        String sql = "SELECT * FROM tb_user WHERE userName=? AND userPwd=?";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // 设置查询参数
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    // 用户名和密码匹配
                    out.println("success");
                } else {
                    // 用户名和密码不匹配
                    out.println("failure");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("An error occurred during login.");
        }
    }
}