<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.tonetime.commons.util.*"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/basicPage/header.jsp">
	<jsp:param name="title" value="登录页面" />
</jsp:include>
</head>
<body>
	<div class="account-box">
		<div class="logo">
			<img src="images/obd_logo.png">
		</div>
		<h3>运营后台</h3>
		<div class="login-box">
			<form action="user/login" method="post">
				<div class="account-list cur">
					<i class="account-icon username"></i> <input type="text"
						placeholder="用户名" id="username" name="userName" value=${username}>
				</div>
				<div class="account-list">
					<i class="account-icon password"></i> <input type="password"
						placeholder="密码" id="password" name="userPassword"
						value=${userpassword} >
				</div>
				<div class="login-btn">
					<button type="button" id="button1">登录</button>
				</div>
			</form>
		</div>

	</div>
</body>
</html>
<jsp:include page="/WEB-INF/basicPage/footer.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>
<script type="text/javascript">
	//捕获回车键
	$('html').bind('keydown',function(e){
	    if(e.keyCode==13){
			var username = $("#username").val();
			var password = $("#password").val();
			var mainUrl = "${contextPath}";
			if (username == null || username == "") {
				alert("请输入用户名");
			} else if (password == null || password == "") {
				alert("请输入密码")
			} else if ((password == null || password == "")
					&& (username == null || username == "")) {
				alert("请输入密码和用户名");
			} else {
				$.post("${contextPath}/user/login", {
					userName : username,
					userPassword : password
				}, function(data) {
					if (data.state == "0") {
						var url = data.result[0]["jsp"];
						var mainUrl = "${contextPath}" + url;
						window.location.href = mainUrl;
					} else {
						var msg = data.msg;
						alert(msg);
					}
				});
			}
	    }
	});

	$("#button1").bind('click',function() {
				var username = $("#username").val();
				var password = $("#password").val();
				var mainUrl = "${contextPath}";
				if (username == null || username == "") {
					alert("请输入用户名");
				} else if (password == null || password == "") {
					alert("请输入密码")
				} else if ((password == null || password == "")
						&& (username == null || username == "")) {
					alert("请输入密码和用户名");
				} else {
					$.post("${contextPath}/user/login", {
						userName : username,
						userPassword : password
					}, function(data) {
						if (data.state == "0") {
							var url = data.result[0]["jsp"];
							var mainUrl = "${contextPath}" + url;
							window.location.href = mainUrl;
						} else {
							var msg = data.msg;
							alert(msg);
						}
					});
				}

			});
	
	
	
	
	
</script>



















