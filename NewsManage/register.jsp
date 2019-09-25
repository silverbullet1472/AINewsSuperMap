<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>注册页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css/sb-admin.css" rel="stylesheet">
    <link rel="shortcut icon" type="image/x-icon" href="images/tesla.png" />
  </head>
  
  <body background="images/register.jpg" style=" background-repeat:no-repeat;background-size:100%;background-attachment:fixed;">
  <div class="container">
    <div class="card card-register mx-auto mt-5">
      <div class="card-header">注册账户</div>
      <div class="card-body">
        <form action="register_check.jsp" method="post">
         
          <div class="form-group">
            <label for="email">邮箱地址</label>
            <input class="form-control" id="email" name="email" placeholder="Enter email">
          </div>
          <div class="form-group">
            <div class="form-row">
              <div class="col-md-6">
                <label for="password">密码</label>
                <input class="form-control" id="password" name="password" placeholder="Password">
              </div>
              <div class="col-md-6">
                <label for="ConfirmPassword">确认密码</label>
                <input class="form-control" id="ConfirmPassword" name="confirmpassword" placeholder="Confirm password">
              </div>
            </div>
          </div>
          <input class="btn btn-primary btn-block" type="submit" value="注册" onclick="isSame()"/>
        </form>
        <div class="text-center">
          <a class="d-block small mt-3" href="login.jsp">登陆页面</a>
        </div>
      </div>
    </div>
  </div>
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
   <script>
  function isSame(){
        var email = $("input[name=email]");
        var p1 = $("input[name=password]");
		var p2 = $("input[name=confirmpassword]");
		if(email.val() == '' || p1.val() ==''|| p2.val() =='')
		{
		    alert("邮箱或密码不能为空");
		}
		else if(p1.val()!=p2.val())
			{
				alert("两次密码不一致！");
			}
  }
  </script>
  </body>
</html>
