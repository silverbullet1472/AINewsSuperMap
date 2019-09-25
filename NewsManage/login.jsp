<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>登陆页</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="css/sb-admin.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery.form.js"></script>
    <link rel="shortcut icon" type="image/x-icon" href="images/tesla.png" />

  </head>
  
  <body background="images/login.jpg" style=" background-repeat:no-repeat;background-size:100% ;background-attachment:fixed;">
 <div class="container">
    <div class="card card-login mx-auto mt-5">
      <div class="card-header" align="center">即时新闻信息管理系统</div>
      <div class="card-body">
        <form id="login" action="login_check.jsp" method="post">
          <div class="form-group">
            <label for="email">邮箱</label>
            <input class="form-control" id="email" name="email" placeholder="Enter email">
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input class="form-control" id="password" name="password" placeholder="Password">
          </div>
          <div class="form-group">
            <div class="form-check">
              <label class="form-check-label">
                <input class="form-check-input" type="checkbox">记住密码</label>
            </div>
          </div>
          <input class="btn btn-primary btn-block" type="submit" value="登陆" onclick="isEmpty()"/>
        </form>
        <div class="text-center">
          <a class="d-block small mt-3" href="register.jsp">注册账户</a>
          <a class="d-block small" href="index.jsp">游客登陆</a>
        </div>
        <p id="ts"></p>
      </div>
    </div>
  </div>
  
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>
  <script>
  function isEmpty(){
        var u = $("input[name=email]");
		var p = $("input[name=password]");
		
			if(u.val() == '' || p.val() =='')
			{
				alert("邮箱或密码不能为空");
			}
		
  }
  
  </script>
  </body>
</html>
