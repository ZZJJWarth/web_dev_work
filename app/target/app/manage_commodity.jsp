<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.naming.*" %>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Show Buttons from Database</title>

</head>
<body>
    <button onclick="add_c()">add a commodity</button><br>
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

        // 遍历查询结果生成按钮
        while (resultSet.next()) {
            String name = resultSet.getString("name");
            String price = resultSet.getString("price");
%>          
            price:<h3><%= price %></h3><br>
            manage:<button type="button" onclick="handleButtonClick('<%= name %>')"><%= name %></button><br>
            <form method="post" action="deleteCommodityServlet?name=<%= name %>">
                <button>delete</button>
            </form>
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

<script>
    function handleButtonClick(itemName) {
        var a="change.jsp?c_name="+itemName;

        window.location.href = a ;
        <%-- window.location.href = "change.jsp?i=1" ; --%>
    }

    function add_c(){
        console.log("123")
        window.location.href="add.jsp"
    }
</script>

</body>
</html>