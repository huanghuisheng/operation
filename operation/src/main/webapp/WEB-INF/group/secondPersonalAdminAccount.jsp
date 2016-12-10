<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="renderer" content="webkit">
<title>中国移动4G车联网</title>
<link rel="stylesheet" href="${contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${contextPath}/css/clw4G.css">
<script src="${contextPath}/js/jquery-1.11.3.js"></script>
<script src="${contextPath}/js/bootstrap.js"></script>
<script src="${contextPath}/js/echarts.js"></script>
<script src="${contextPath}/js/laytpl.js"></script>



</head>
<body>
	<nav class="navbar navbar-inverse" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#"> <img id="logo"
					src="${contextPath}/images/obd_logo.png">
				</a>
			</div>
			<div id="navbar" class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li><a href="${contextPath1}deviceControl">设备监控</a></li>
			
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" aria-expanded="false">个人中心<span
							class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
						<li><a href="${contextPath2}secondDeviceControl">退出</a></li>
						</ul></li>
				</ul>
<%-- 		  	<form class="navbar-form navbar-right" role="search"   action="${contextPath}/controller/search" method="post"  >
					<div class="form-group">
				  		<input type="text" class="form-control" placeholder="Search" id="device-search" name="search">
				  		<button type="button" class="btn btn-default"  id="device-search1" >搜索</button>
					</div>
			</form> --%>
	      <jsp:include page="/WEB-INF/basicPage/firstSearch.jsp">
             <jsp:param name="title" value="登录页面"/> 
            </jsp:include>			
		
			
			</div>
		</div>
	</nav>

	<div class="container-fluid">
		<div class="row">

			<div class="col-sm-9 col-md-10 col-md-offset-2 col-sm-offset-3 main">

				<div class="sbgl">
					<div class="row">
					
					<jsp:include page="/WEB-INF/basicPage/secondLeftMenu.jsp">
                  <jsp:param name="title" value="登录页面"/> 
                    </jsp:include>




						<div class="col-sm-12 col-md-10">
							<h4 class="zhzl">账户资料</h4>
							<div class="zhzlInfo">
								<div class="row">
									<div class="col-sm-4 col-md-2">用户名：</div>
									<div class="col-sm-4 col-md-2" id="userName">admin</div>
									<div class="col-sm-4 col-md-8">
										<a id="editNickname">修改</a>
									</div>
								</div>
								<div class="row">
									<div class="col-sm-4 col-md-2">角色：</div>
									<div class="col-sm-4 col-md-2">管理员</div>
								</div>
								<div class="row">
									<div class="col-sm-4 col-md-2">密码：</div>
									<div class="col-sm-4 col-md-2">******</div>
									<div class="col-sm-4 col-md-8">
										<a id="editPassword">修改</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>
	</div>


	<div class="modal fade" id="editNicknameModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">昵称修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">填写新昵称</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="userName1"
									placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary saveBtn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="editPasswordModal" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改密码</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">原密码</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="password1"
									placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">新密码</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="password2"
									placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
						</div>
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-3 control-label">确定密码</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="password3"
									placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary saveBtn">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				</div>
			</div>
		</div>
	</div>




	<script>
	
/* 	$("#device-search1").click(function(){

		var value = $("#device-search").val();	
		 $.post("${contextPath}/controller/secondSearch", 
				 {
			 search:value,
				 },
				 function(data){
				console.log(data);
				
			if(data.state=="1"){
				alert("没有此imei号");
			}else				
			{
				window.location.href="${contextPath1}singleDeviceSecond.jsp?imei="+value; 	
			}

		    });		

	}) */
	
	
	
	
	
	
	
	
	
	
	
	
		$(function(){
			$("#editNickname").click(function(){
				$("#editNicknameModal").modal();
			});
			
			$("#editPassword").click(function(){
				$("#editPasswordModal").modal();
			});	
		});
		
		
	var userName=	'${username}';
	$("#userName").text(userName);

	$("#editNicknameModal .saveBtn").click(function(){
		var userName= $('#userName1').val();
		
		
 	 	 $.post("${contextPath}/controller/updatePersonalClientAccount", {
 	 		adminName: userName,	
		}, function(data){
			
			$("#userName").text(userName);
		
			$("#editNicknameModal").modal("hide");
		});  
 		 
 		 
	});
	
	
	
	
	
	$("#editPasswordModal .saveBtn").click(function(){
		var password1= $('#password1').val();
		var password2= $('#password2').val();
		var password3= $('#password3').val();
		
		if(password1=="")
			{
			alert("密码不能为空");
			}
		
		
		
		
          if(password2==password3)
        	  {
       $.post("${contextPath}/controller/updatePersonalClientAccount1", {
           oldAdminPass: password1,
           adminPass1: password3,
           
  		}, function(data){
  		
  			$("#editPasswordModal").modal("hide");
  		});  
        	  }else{
        		  alert("密码输入不一致");
        	  }
 		
		
		

	});
	
		
		
	</script>
</body>
</html>