package com.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class deleteCommodityServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                String itemName=request.getParameter("name");
                System.out.println(itemName);
                Connection connection=null;
                PreparedStatement preparedStatement = null;

                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/commodity";
                    String dbUsername = "root";
                    String dbPassword = "ZZjj123456";

            // 建立数据库连接
                    connection = DriverManager.getConnection(url, dbUsername, dbPassword);
                    String sql = "delete from commodity where name=?";
                
                    preparedStatement = connection.prepareStatement(sql);
                    preparedStatement.setString(1, itemName);
                    System.out.println(sql);
        
                    // 执行SQL语句
                    int rowsAffected = preparedStatement.executeUpdate();
                    // response.getWriter().println("s");
                    
                }catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    System.out.println("Registration failed. Please try again.");
                }finally{
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
