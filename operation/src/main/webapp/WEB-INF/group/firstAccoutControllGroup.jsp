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
            <jsp:include page="/WEB-INF/basicPage/leftMenu.jsp">
             <jsp:param name="title" value="登录页面"/> 
            </jsp:include>



						<div class="col-sm-12 col-md-10">
							<div class="panel panel-default">
								<div class="panel-heading">
									<button id="addNewFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span>新增</button>
									<button id="reviseFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-pencil"></span>修改</button>
									<button id="deleteFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-minus-sign"></span>删除</button>
			<!-- 						<div class="form-group sbglTopSearch">
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
											<th>组名</th>
										</tr>
									</thead>
									<tbody id="tableObj">
									</tbody>
								</table>
								<div id="view"></div>
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
					<h4 class="modal-title" id="myModalLabel">添加新的分组</h4>
		  		</div>
		  		<div class="modal-body">
		  			<div style="display: none;" class="alert alert-danger" role="alert">请输入分组名称</div>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">分组名称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control">
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
	
	
	<div class="modal fade" id="reviseFenzuModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">修改分组信息</h4>
		  		</div>
		  		<div class="modal-body">
		  			<div style="display: none;" class="alert alert-danger" role="alert">请输入分组名称</div>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">分组名称</label>
							<div class="col-sm-9">
								<input id="reviseFenzuModalText" type="text" class="form-control">
							</div>
							<label class="col-sm-1 must">*</label>
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
					<h4 class="modal-title" id="myModalLabel">删除分组</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-2 control-label">
								<span class="glyphicon glyphicon-exclamation-sign jinggao"></span>
							</label>
							<div class="col-sm-10">
								<p>选定的分组“<span id="deleteFenzuModalText" class="alert-danger">中国人保</span>”将被删除，组内所有设备将会被删除。</p>
								<p>您确定要删除该分组吗？</p>
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" class="btn btn-primary saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
	<script id="tableObjView" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
		<tr data-n_id={{d[i].n_id}} data-c_group_name={{d[i].c_group_name}}>
			<td><input type="checkbox"></td>
			<td>{{d[i].c_group_name}}</td>
		</tr>
		{{# } }}
	</script>
	
	
	 <script>
	 $(function(){
			$.post("${contextPath}/controller/showGroup", function(data){
			console.log(data);
			if(data.code == "0"){
				showData(data.result, "#tableObjView", "#tableObj");
				
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
	 

		//新增分组
		var addFenzuGroupEle = $("#addNewFenzuModal input[type=text]");
		
		$("#addNewFenzu").click(function(){
			$("#addNewFenzuModal .alert").hide();
			$("#addNewFenzuModal").modal();
		});
		
		$("#addNewFenzuModal").on("hidden.bs.modal", function(){
			addFenzuGroupEle.val("");
			$("#addNewFenzuModal .alert").hide();
		});
		
		$("#addNewFenzuModal .saveBtn").click(function(){
			var value = addFenzuGroupEle.val().trim();
			
			if(value === ""){
				$("#addNewFenzuModal .alert").show();
				return;
			}
			
			$.post("${contextPath}/controller/addGroup", {
				groupName: value
			}, function(data){
				console.log(data);
				var resultHtml = '<tr data-n_id="' + data.result[0]["n_id"] + '" data-c_group_name="' + data.result[0]["c_group_name"] + '">' + '<td><input type="checkbox"></td><td> ' + data.result[0]["c_group_name"] + '</td></tr>'; 
				$(resultHtml).appendTo($("#tableObj"));
	
				addFenzuGroupEle.val("");
				$("#addNewFenzuModal").modal("hide");
			});
		});

		
		
		//选择要删除或者修改哪个分组数据
		$("#tableObj" ).on("click", "tr", function(){
			$("#tableObj input[type=checkbox]").removeAttr("checked");
			$(this).find("input[type=checkbox]").prop("checked", true);
			changeFenzuObj.el = $(this);
			changeFenzuObj.n_id = $(this).data("n_id");
			changeFenzuObj.c_group_name = $(this).data("c_group_name");
		});
		
		var changeFenzuObj = {
			el: null,
			n_id: null,
			c_group_name: null
		};

		//修改分组
		$("#reviseFenzu").click(function(){
			if(changeFenzuObj.n_id == null){
				alert("请选择一个分组");
				return;
			}
			
			$("#reviseFenzuModalText").val(changeFenzuObj.c_group_name);
			$("#reviseFenzuModal").modal();
		});
		
		$("#reviseFenzuModal").on("hidden.bs.modal", function(){
			$("#reviseFenzuModalText").val("");
			$("#reviseFenzuModal .alert").hide();
		});
		
		$("#reviseFenzuModal .saveBtn").click(function(){
			var value = $("#reviseFenzuModalText").val().trim();
			
			if(value === ""){
				$("#reviseFenzuModal .alert").show();
				return;
			}
			$.post("${contextPath}/controller/updateGroup", {
				groupid: changeFenzuObj.n_id,
				groupName: value
			}, function(data){
				if(data.code == "0"){
					changeFenzuObj.el.find("td").eq(1).html(value);
					$("#reviseFenzuModalText").val("");
					$("#reviseFenzuModal").modal("hide");
					changeFenzuObj.c_group_name = value;
				}
			});
		}); 
	 
		//删除分组
		$("#deleteFenzu").click(function(){
			if(changeFenzuObj.n_id == null){
				alert("请选择一个分组");
				return;
			}
			$("#deleteFenzuModalText").html(changeFenzuObj.c_group_name);
			$("#deleteFenzuModal").modal();
		});

		
		$("#deleteFenzuModal .saveBtn").click(function(){
			$.post("${contextPath}/controller/deleteGroup", {groupid: changeFenzuObj.n_id}, function(data){
				console.log(data);
				if(data.code == "0"){
					changeFenzuObj.el.remove();
					changeFenzuObj = {
						el: null,
						n_id: null,
						c_group_name: null
					};
					$("#deleteFenzuModal").modal("hide");
				}
			});
		});
	 
	 
	 
	 
	 
	 
	 
	
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 

	 
	 </script>
	













</body>
</html>