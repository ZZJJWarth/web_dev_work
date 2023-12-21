<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Modify and Delete Form</title>
    <script>
        function validateForm() {
            var itemName = document.forms["modifyDeleteForm"]["itemName"].value;
            var itemPrice = document.forms["modifyDeleteForm"]["itemPrice"].value;

            // 非空检查
            if (itemName.trim() === "" || itemPrice.trim() === "") {
                alert("Name and price cannot be empty.");
                return false;
            }

            // 价格数字验证
            if (isNaN(itemPrice)) {
                alert("Price must be a valid number.");
                return false;
            }

            return true;
        }
    </script>
</head>
<body>

<body>

<h2>Modify and Delete Form</h2>

<form name="modifyDeleteForm" method="post" action="ModifyDeleteServlet" onsubmit="return validateForm()">
    Name: <input type="text" name="itemName" required><br>
    Price: <input type="text" name="itemPrice" required pattern="\d*"><br>
    <br>
    <button type="submit" name="action" value="modify">Modify</button>

</form>
</body>
</html>