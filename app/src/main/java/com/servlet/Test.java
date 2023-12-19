package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mapper.DatabaseConnector;

public class Test extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                response.setContentType("text/html;charset=UTF-8");
        
                try (PrintWriter out = response.getWriter()) {
                    try {
                        Connection connection = DatabaseConnector.connect();
        
                        try {
                            // 执行查询示例
                            String sql = "SELECT * FROM tb_user";
                            PreparedStatement statement = connection.prepareStatement(sql);
                            ResultSet resultSet = statement.executeQuery();
        
                            // 处理查询结果
                            while (resultSet.next()) {
                                out.println("ID: " + resultSet.getInt("userId") + ", Name: " + resultSet.getString("userName") + "<br>");
                                out.println("<button>购买</button>");
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            // 关闭数据库连接
                            if (connection != null) {
                                try {
                                    connection.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
    }

