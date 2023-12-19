<html>
    <head>
        <title>Sign up</title>
    </head>
    <body>
        <form id="signupForm">
            username:<input type="text" name="username" id="username"><br>
            password:<input type="text" name="password" id="password"><br>
            <span style="color:red" id="hint"></span><br>
            <button type="button" id="signupButton">Sign up</button>
        </form>
        
    </body>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
         $(document).ready(function () {
            $("#signupButton").click(function () {
                // 获取输入框的值
                var username = $("#username").val();
                var password = $("#password").val();

                // 检验用户名和密码是否为空
                if (isEmpty(username) || isEmpty(password)) {
                    $("#hint").html("Username or password is empty");
                } else {
                    // 使用Ajax将数据发送到后端
                    $.ajax({
                        type: "Post",
                        url: "/app/SignUp", // 替换为实际的后端处理URL
                        data: {
                            username: username,
                            password: password
                        },
                        success: function (response) {
                            // 后端处理成功后的回调函数
                            $("#hint").html("Registration successful");
                            setTimeout(function () {
                                window.location.href = "login.jsp"; // 替换为实际的登录页面URL
                            }, 2000);
                        },
                        error: function (error) {
                            // 后端处理失败后的回调函数
                            
                            $("#hint").html("Registration failed. Please try again.");

                        }
                    });
                }
            });

            function isEmpty(str) {
                return str.trim() === "";
            }
        });

    </script>
</html>