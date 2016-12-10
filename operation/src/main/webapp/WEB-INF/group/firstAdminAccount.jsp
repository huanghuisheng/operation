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
    <script src="${contextPath}/js/leftMenu.js"></script>
    </head>
<body>
	<nav class="navbar navbar-inverse" role="navigation">
    	<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			  	</button>
			  	<a class="navbar-brand" href="#">
					<img id="logo" src="${contextPath}/images/obd_logo.png">
				</a>
			</div>
        	<div id="navbar" class="navbar-collapse collapse">
                <jsp:include page="/WEB-INF/basicPage/deviceMenu.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>
          		<ul class="nav navbar-nav navbar-right">
            		<li class="dropdown">
              			<a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">个人中心<span class="caret"></span></a>
              			<ul class="dropdown-menu" role="menu">
                		<li><a href="${contextPath1}deviceControl">退出</a></li>
              			
              			</ul>
            		</li>
          		</ul>
			<jsp:include page="/WEB-INF/basicPage/firstSearch.jsp">
             <jsp:param name="title" value="登录页面"/> 
            </jsp:include>
			  	
        	</div>
    	</div>
    </nav>
	
	<div class="container-fluid" id="allclick">
		<div class="row">
       	
        	<div class="col-sm-9 col-md-10 col-md-offset-2 col-sm-offset-3 main">
				
       			<div class="sbgl">
					<div class="row">
            <jsp:include page="/WEB-INF/basicPage/leftMenu2.jsp">
               <jsp:param name="title" value="登录页面"/> 
                 </jsp:include>
						<div class="col-sm-12 col-md-10">
							<div class="panel panel-default">
								<div class="panel-heading">
									<button id="addNewFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span>新增</button>
									<button id="reviseFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-pencil"></span>修改</button>
									<button id="deleteFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-minus-sign"></span>删除</button>
									<!-- <button id="daoruFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-cloud-upload"></span>批量导入</button> -->
							<!-- 		<div class="form-group sbglTopSearch">
				  						<input type="text" class="form-control pull-left" placeholder="Search">
				  						<button type="submit" class="btn btn-primary">搜索</button>
				  						<div class="list-group">
											<a href="#" class="list-group-item">Dapibus ac facilisis in</a>
										  	<a href="#" class="list-group-item">Morbi leo risus</a>
										  	<a href="#" class="list-group-item">Porta ac consectetur ac</a>
										  	<a href="#" class="list-group-item">Vestibulum at eros</a>
										</div>
									</div> -->
								</div>
								<table class="table table-bordered">
									<thead>
										<tr>
											<th><input type="checkbox"></th>
											<th>用户名</th>
											<th>所属分组</th>
											<th>用户权限</th>
											<th>联系电话</th>
											<th>备注</th>
										</tr>
									</thead>
								    <tbody id="tableObj">
									</tbody>
								</table>
							</div>
						</div>   			
					</div>	
       			</div>
        	</div>
			
		</div>
	</div>
	<div class="modal fade" id="addNewFenzuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">新增账号</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-9">
								<input type="text" class="form-control  " id="userName1" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">所属分组</label>
							<div class="col-sm-9">
								<select class="form-control  " id="select-group"  >
									<option>中国人保</option>
								  	<option>中国平安</option>
								  	<option>太平洋财险</option>
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户权限</label>
							<div class="col-sm-10">
								<div class="radio">
									<label>
								  		<input name="test" type="radio" value="1"checked="true"  >
								  		可查看历史轨迹
									</label>
								</div>
								<div class="radio">
									<label>
								  		<input name="test" type="radio" value="2">
								  		不可查看历史轨迹
									</label>
								</div>
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-9">
								<input type="password" class="form-control " id="user-password1" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">联系电话</label>
							<div class="col-sm-9">
								<input type="text" class="form-control  " id="user-tel1" placeholder="">
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">备注</label>
							<div class="col-sm-9">
								<input type="text" class="form-control " id="user-remark1" placeholder="">
							</div>
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
	
	
	<div class="modal fade" id="reviseFenzuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">修改账号</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="userName2" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">所属分组</label>
							<div class="col-sm-9">
								<select class="form-control" id="select-group-updata">
								
								
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户权限</label>
							<div class="col-sm-10">
								<div class="radio1 ">
									<label>
								  		<input name="test" type="radio" value="1" checked="true">
								  		可查看历史轨迹
									</label>
								</div>
								<div class="radio1">
									<label>
								  		<input name="test" type="radio" value="2">
								  		不可查看历史轨迹
									</label>
								</div>
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="user-password2" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">联系电话</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user-tel2" placeholder="">
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">备注</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="user-remark2" placeholder="">
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" class="btn btn-primary saveBtn">修改</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
	
	<div class="modal fade" id="deleteFenzuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">删除账号</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-2 control-label">
								<span class="glyphicon glyphicon-exclamation-sign jinggao"></span>
							</label>
							<div class="col-sm-10">
								<p>您确定要删除账号：<span class="alert-danger" id="deleteFenzuModalText">中国平安账号1</span>吗？</p>
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" class="btn btn-primary saveBtn">删除</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="daoruFenzuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">设备批量导入</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">分组选择</label>
							<div class="col-sm-9">
								<select class="form-control">
									<option>中国人保</option>
								  	<option >中国平安</option>
								  	<option>太平洋财险</option>
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">上传文件</label>
							<div class="col-sm-9">
								<input type="file" id="exampleInputFile">
								<p class="help-block"><a href="">下载文件模板</a></p>
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
	<script id="tableObjView" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
		<tr data-n_id={{d[i].n_id}} data-c_name={{d[i].c_name}} data-c_department={{d[i].c_department}} data-c_role={{d[i].c_role}} data-c_telephone={{d[i].c_telephone}} data-c_remark={{d[i].c_remark}} >
			<td ><input type="checkbox"></td>
			<td data-c_name={{d[i].c_name}}>{{d[i].c_name}}</td>
			<td data-c_department={{d[i].c_department}}>{{d[i].c_groupName}}</td>
			<td data-c_role={{d[i].c_role}}>{{d[i].c_role}}</td>
	        <td data-c_telephone={{d[i].c_telephone}}>{{d[i].c_telephone}}</td>
			<td data-c_remark={{d[i].c_remark}}>{{d[i].c_remark}}</td>
		</tr>
		{{# } }}
	</script>
	<script id="selectObjView" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
	<option value={{d[i].n_id}} >{{d[i].c_group_name}}</option>
		{{# } }}
	</script>
	
	
	
	<script>	
		$(function(){
			$.post("${contextPath}/controller/showGroup", function(data){
				console.log(data);
				if(data.code == "0"){
					//显示左边分组情况；
                    showData(data.result, "#selectObjView", "#select-group");	
					showData(data.result, "#selectObjView", "#select-group-updata");
				}
		    });
			$.post("${contextPath}/controller/showAdminAccout", 	
				function(data){
				if(data.state == "0"){
					var result=data.result;
		 	 		for(var i=0;i<result.length;i++)
						{
		 	 			console.log(result[0]);
					var role = result[i].c_role;
				 	if(role=="1")
						{
				 		result[i].c_role="可查看用户轨迹";
						}
					else
						{
						result[i].c_role="不可查看用户轨迹";
						} 
						}  
					showData(result, "#tableObjView", "#tableObj");
				}
		    });
			//显示分组数据
			function showData(data, tmpl, target){
				var gettpl = $(tmpl).html();
				laytpl(gettpl).render(data, function(html){
			  		$(target).html(html)
				});
			}	
		});
		
		
		
		//新增分组--------6个参数
		var addFenzuGroupEle = $("#addNewFenzuModal input[type=text]");
		$("#addNewFenzu").click(function(){
			$(".form-control").val("");
			$("#addNewFenzuModal .alert").hide();
			$("#addNewFenzuModal").modal();
			
		});
		$("#addNewFenzuModal").on("hidden.bs.modal", function(){
			addFenzuGroupEle.val("");
			$("#addNewFenzuModal .alert").hide();
		});
		
		$("#addNewFenzuModal .saveBtn").click(function(){
			var userName= $('#userName1').val();
			var userPassword= $('#user-password1').val();
			var usertel= $('#user-tel1').val();
			var userRemark= $('#user-remark1').val();
			
			var groupsssId = $("#select-group option:selected").val();
			var radio = $('.radio  input[name="test"]:checked ').val();

			if(userName === ""){
				$("#addNewFenzuModal .alert").show();
				return;
			}
			 $.post("${contextPath}/controller/addAdminAccout", {
				 adminName: userName,
				 adminPassword: userPassword,
				 adminRole: radio,
				 adminTelephone: usertel,
				 adminDepartment: groupsssId,
				 adminRemark: userRemark
				
			}, function(data){
				
				var role=data.result[0]["c_role"];
				if(role=="1")
				{
					data.result[0]["c_role"]="可查看用户轨迹";
				}
			else
				{
				data.result[0]["c_role"]="不可查看用户轨迹";
				} 
			
			 
				
				var resultHtml = '<tr data-n_id="' + data.result[0]["n_id"] +'" data-c_name="' + data.result[0]["c_name"] +'" data-c_department="' + data.result[0]["c_department"] +'" data-c_role="' + data.result[0]["c_role"] +'"data-c_telephone="' + data.result[0]["c_telephone"] +'"data-c_remark="' + data.result[0]["c_remark"] +'">' + 

				'<td><input type="checkbox"></td>'+
				'<td data-c_name="' + data.result[0]["c_name"] +'"> ' + data.result[0]["c_name"] + '</td>'+
				
				'<td data-c_department="' + data.result[0]["c_department"] +'"> ' + data.result[0]["c_groupName"] + '</td>'+
				'<td data-c_role="' + data.result[0]["c_role"] +'"> ' + data.result[0]["c_role"] + '</td>'+
				'<td data-c_telephone="' + data.result[0]["c_telephone"] +'"> ' + data.result[0]["c_telephone"] + '</td>'+
				'<td data-c_remark="' + data.result[0]["c_remark"] +'"> ' + data.result[0]["c_remark"] + '</td>'+
				'</tr>'; 
				$(resultHtml).appendTo($("#tableObj"));
				$("#addNewFenzuModal").modal("hide");
			}); 
		});
		
		//选择要删除或者修改哪个分组数据
		$("#tableObj" ).on("click", "tr", function(){
			$("#tableObj input[type=checkbox]").removeAttr("checked");
			$(this).find("input[type=checkbox]").prop("checked", true);
			
			changeFenzuObj.el = $(this);
			changeFenzuObj.n_id = $(this).data("n_id");
			
			changeFenzuObj.c_name = $(this).data("c_name");
		});
		
		var changeFenzuObj = {
			el: null,
			n_id: null,
			c_name: null,
			c_telephone: null,
			c_remark: null,
	
		};

		//修改分组
		$("#reviseFenzu").click(function(){
			if(changeFenzuObj.n_id == null){
				alert("请选择一个账号");
				return;
			}
			//自动填充
			$("#userName2").val(changeFenzuObj.c_name);
			$("#reviseFenzuModal").modal();
		});
		
		$("#reviseFenzuModal").on("hidden.bs.modal", function(){
			$("#reviseFenzuModalText").val("");
			$("#reviseFenzuModal .alert").hide();
		});
		
		$("#reviseFenzuModal .saveBtn").click(function(){
			var userPassword1= $('#user-password2').val();
			var userRemark1= $('#user-remark2').val();
			var groupId1 = $("#select-group-updata option:selected").val();	
			var radio1 = $('.radio1  input[name="test"]:checked ').val();
            var userName1= $('#userName2').val();
			var usertel1= $('#user-tel1').val();

			if(userName1 == ""){
				$("#reviseFenzuModal .alert").show();
				return;
			}
  			$.post("${contextPath}/controller/updateAdminAccount", {
 				adminId: changeFenzuObj.n_id,
				adminName: userName1,
				 adminPassword: userPassword1,
				 adminRole: radio1,
				 adminTelephone: usertel1,
				 adminDepartment: groupId1,
				 adminRemark: userRemark1	 
				
			}, function(data){
				
				if(data.state == "0"){
					changeFenzuObj.el.find("td").eq(1).html(userName1);
					$("#reviseFenzuModalText").val("");
					$("#reviseFenzuModal").modal("hide");
				}
				$("#reviseFenzuModal").modal("hide");
			});  
		}); 
		
		
		//删除分组
		$("#deleteFenzu").click(function(){
			if(changeFenzuObj.n_id == null){
				alert("请选择一个分组");
				return;
			}
			$("#deleteFenzuModalText").html(changeFenzuObj.c_name);
			$("#deleteFenzuModal").modal();
		});
		
		
		$("#deleteFenzuModal .saveBtn").click(function(){
			$.post("${contextPath}/controller/deleteAdminAccount", 
					{adminID: changeFenzuObj.n_id}, 
					function(data){
				console.log(data);
				if(data.state == "0"){
					changeFenzuObj.el.remove();
					changeFenzuObj = {
						el: null,
						n_id: null,
					};
					$("#deleteFenzuModal").modal("hide");
				}
			});
		});
	
	</script>
</body>
</html>