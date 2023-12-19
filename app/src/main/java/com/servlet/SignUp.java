package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
// import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// @WebServlet("/RegisterServlet")
public class SignUp extends HttpServlet {
    // protected void doGet(HttpServletRequest request, HttpServletResponse response)
    //         throws ServletException, IOException{
    //             System.out.println("hhhhhhhhhhhhhhhhhh");
    //         }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // System.out.println("hhhhhhhhhhhhhhhhhh");
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        // 获取前端传递的参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 替换以下信息为你的数据库连接参数
            String url = "jdbc:mysql://localhost:3306/user_login";
            String dbUsername = "root";
            String dbPassword = "ZZjj123456";

            // 建立数据库连接
            connection = DriverManager.getConnection(url, dbUsername, dbPassword);
            // System.out.println(dbPassword+":"+dbUsername);
            // 执行插入数据的SQL语句
            String sql = "INSERT INTO tb_user (userName, userPwd) VALUES (?, ?)";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, username);
            preparedStatement.setString(2, password);

            // 执行SQL语句
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Registration successful");
            } else {
                System.out.println("Registration failed. Please try again.");
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.println("Registration failed. Please try again.");
        } finally {
            // 关闭资源
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}