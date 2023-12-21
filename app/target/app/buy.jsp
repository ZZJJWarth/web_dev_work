<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Show Buttons from Database</title>
</head>
<body>

<%
    try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    // JDBC连接参数
    String jdbcUrl = "jdbc:mysql://localhost:3306/commodity";
    String dbUsername = "root";
    String dbPassword = "ZZjj123456";

    // SQL查询语句
    String sql = "SELECT name,price FROM commodity";

    try {
        // 加载JDBC驱动
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 建立数据库连接
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

        // 执行查询
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet resultSet = preparedStatement.executeQuery();
        String username=request.getParameter("username");
        out.println("<h1>Welcome!"+username+"</h1><br>");
        // 遍历查询结果生成按钮
        while (resultSet.next()) {
            String name = resultSet.getString("name");
            String price = resultSet.getString("price");
%>          
            price:<h3><%= price %></h3><br>
            buy:<button type="button" onclick="handleButtonClick('<%= name %>','<%= username%>')"><%= name %></button><br>
            <h1>---------------------------------------------------</h1><br>
<%
        }

        // 关闭资源
        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("An error occurred while processing the database.");
    }
%>
<script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
    function handleButtonClick(itemName,username) {
        $.ajax({
                type: "Post",
                url: "/app/addPayServlet",  
                data: {
                    username: username,
                    commodity: itemName
                },
                success: function (response) {
                    console.log(response[0])
                    if (response[0] == "s") {
                        alert(username+",you buy a " + itemName);
                        
                    } else {
                        alert(username+",your buying is not successful,place try again");
                    }
                },
                error: function () {
                    alert(username+",we cannot post a request!");
                }
            });
    }
</script>

</body>
</html>