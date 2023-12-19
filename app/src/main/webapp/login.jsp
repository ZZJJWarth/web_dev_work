<html>
    <head>
        <title>login</title>
    </head>
    <body>
        <div style="text-align: center;">
            <form action="/login" method="post" id="loginForm">

                name:<input type="text" name="uname1" id="uname"><br>
                password:<input type="password" name="psw1" id="psw"><br>
                <span id="msg" style="color:red"></span><br>
                <button type="button" id="loginTap">Login</button>
                <button type="button" id="signupButton">Sign up</button>
            </form>
        </div>
    </body>
    <script src="https://cdn.bootcdn.net/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
        $("#loginTap").click(function(){
            var uname=$("#uname").val();
            var psw=$("#psw").val();
            
            if(uname=="admin"){
                if(psw=="admin"){
                    <%-- console.log(uname.length) --%>
                    window.location.href = "manage_commodity.jsp";

                }else{
                    $("#msg").html("admin password is wrong!")
                    return
                }
            }
            if (isEmpty(uname)){
                $("#msg").html("Username is empty")
                return
            }
            if(isEmpty(psw)){
                $("#msg").html("password is empty")
                return
            }
            
            $.ajax({
                type: "Post",
                url: "/app/LoginServlet",  // 替换为实际的后端登录处理URL
                data: {
                    username: uname,
                    password: psw
                },
                success: function (response) {
                    console.log(response[0])
                    if (response[0] == "s") {
                        // 登录成功，可以在这里跳转到其他页面
                        window.location.href = "buy.jsp?username="+uname;
                        
                    } else {
                        // 登录失败，显示错误消息
                        $("#msg").html("Invalid username or password");
                    }
                },
                error: function () {
                    // 处理Ajax请求错误
                    $("#msg").html("Error during login");
                }
            });
        });
        

        function isEmpty(str){
            if(str==null||str.trim()==""){
                return true;
            }else{
                return false;
            }
        }

        $("#signupButton").click(function () {
            window.location.href = "signup.jsp";
        });
    </script>
</html>