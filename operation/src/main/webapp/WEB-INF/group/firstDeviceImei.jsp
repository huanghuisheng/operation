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
    <script src="${contextPath}/js/base.js"></script>
    <script src="${contextPath}/js/leftMenu1.js"></script>
<link href="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.css" rel="stylesheet"/> 
<script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>   
      <script src="${contextPath}/js/ajaxfileupload.js"></script>
      <script src="${contextPath}/js/jquery.shCircleLoader.js"></script>
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
           
            <jsp:include page="/WEB-INF/basicPage/leftMenu1.jsp">
             <jsp:param name="title" value="登录页面"/> 
            </jsp:include>
						<div class="col-sm-12 col-md-10">
							<div class="panel panel-default">
								<div class="panel-heading">
									<button id="addNewFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-plus"></span>新增</button>
									<button id="reviseFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-pencil"></span>修改</button>
									<button id="deleteFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-minus-sign"></span>删除</button>
									<button id="daoruFenzu" type="button" class="btn btn-default"><span class="glyphicon glyphicon-cloud-upload"></span>批量导入</button>
									<div class="form-group sbglTopSearch">
				  						<input type="text" class="form-control pull-left" placeholder="search" id="search-imei">
				  						<button type="button" class="btn btn-primary" id="search">搜索</button>
				  						<div class="list-group" id="search-fuzzy" >
											<!-- <a href="#" class="list-group-item">Dapibus ac facilisis in</a>
										  	<a href="#" class="list-group-item">Morbi leo risus</a>
										  	<a href="#" class="list-group-item">Porta ac consectetur ac</a>
										  	<a href="#" class="list-group-item">Vestibulum at eros</a> -->
										  	  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="search-fuzzy1">
											 	<li role="presentation" >
													<a role="menuitem" tabindex="-1" >Java</a>
												</li> 
											  </ul>
										</div>
									</div>
								</div>
								<div class="ecCharLoading" id="data-ecCharLoading"></div>
	 							<table class="table table-bordered"  id="dataShow">
									<thead>
										<tr>
							                 <th data-checkbox="true" data-sortable="false"  ><input type="checkbox" id="allselect"></th>
							                 <th data-field="n_id" data-visible="false" data-class="n_id"  data-sortable="true"  >id</th>
							                 <th data-field="c_imei" data-class="c_imei" data-events="operateEvent" data-sortable="true"  >IMEI</th>  
							                 <th data-field="c_group_id" data-class ="c_group_id"   data-sortable="true" >所属分组</th>  
										</tr>
									</thead>
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
					<h4 class="modal-title" id="myModalLabel">单个设备导入</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">IMEI</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="inputEmail3" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">所属分组</label>
							<div class="col-sm-9">
								<select class="form-control" id="select-group">
								<!-- 	<option >中国人保</option>
								  	<option >中国平安</option>
								  	<option >太平洋财险</option> -->
								</select>
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
					<h4 class="modal-title" id="myModalLabel">设备信息修改</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">IMEI</label>
							<div class="col-sm-9">
								<input id="reviseFenzuModalText" type="text" class="form-control">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">所属分组</label>
							<div class="col-sm-9">
								<select class="form-control" id="select-group-updata">
								<!-- 	<option>中国人保</option>
								  	<option >中国平安</option>
								  	<option>太平洋财险</option> -->
								</select>
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
								<p>您确定要删除 设备imei号：<span id="deleteFenzuModalText" class="alert-danger">23348934355</span> 吗？</p>
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
					<form class="form-horizontal" id="formId" role="form"  action="${contextPath}/controller/fileUpload2" method="post" enctype="multipart/form-data" >
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">分组选择</label>
							<div class="col-sm-9">
								<select class="form-control" id="select-group-daoru" name="groupid">
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">上传文件</label>
							<div class="col-sm-9">
								  <input type="file" name="file" id="groupFile">
								
								<p class="help-block"><a href="${contextPath}/controller/firstFileDownload">下载文件模板</a></p>
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

	<script id="tableGroup" type="text/html">
	{{# for(var i = 0, len = d.length; i < len; i++){ }}
     <li class="list-group-item"><a href=firstDeviceImei?groupId={{d[i].n_id}}>{{d[i].c_group_name}}</a></li>
    {{# } }}
	</script>

	<script id="searchGroup" type="text/html">
	{{# for(var i = 0, len = d.length; i < len; i++){ }}
        <li  role="presentation" data-n_id={{d[i].n_id}} data-c_imei={{d[i].c_imei}} >
	    <a role="menuitem" tabindex="-1" >{{d[i].c_imei}}</a>
		</li> 
 	{{# } }}
	</script>
	
<!--    选择分组	 -->
<!-- "select-group"> -->
	<script id="selectObjView" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
		<option value={{d[i].n_id}} >{{d[i].c_group_name}}</option>
     	{{# } }}
	</script>

	<script>
	//----------------------------------实时监听searchimei的变化
	$('#search-imei').bind('input propertychange', function() { 

		var data= $(this).val();
      //实时模糊查询
		if(data.length>0){
			$.post("${contextPath}/controller/fuzzySearch", 
					{
				search:data,
				groupid : groupId,
	              },	
					function(data){
				if(data.state == "0"){	
					showData(data.result, "#searchGroup", "#search-fuzzy1");				
					$('#search-fuzzy').show();
					 $('#search-fuzzy1').show(); 	
				}else
					{
					showData(data.result, "#searchGroup", "#search-fuzzy1");
					 $('#search-fuzzy').hide();
					 $('#search-fuzzy1').hide();  
					}
		
		    });  		
		}
		else{
			$('#search-fuzzy').hide();
			 $('#search-fuzzy1').hide(); 	
		}
});
	
	//模糊查询点击事件；
	$("#search-fuzzy ul").on("click","li", function() {
	     var imei=$(this).data("c_imei");
	     $("#search-imei").val(imei); 
	 	 $('#search-fuzzy').hide();
		 $('#search-fuzzy1').hide(); 
	 });
	
	
	
	
	//查询；
		$("#search").click(function() {

			var value = $("#search-imei").val();
			$.post("${contextPath}/controller/groupSearch", {
				search : value,
				groupid : groupId,
			}, function(data) {
				if (data.state == "1") {
					alert("没有此imei号");
				} else {
					if (data.rows.length > 0) {
						for (var i = 0; i < data.rows.length; i++) {
							data.rows[i].c_group_id = groupName;
						}
					}
					$('#dataShow').bootstrapTable('load', data);
				}
			});
		})

		//显示分组数据
	
		function showData(data, tmpl, target) {
			var gettpl = $(tmpl).html();
			laytpl(gettpl).render(data, function(html) {
				$(target).html(html)
			});
		}

		var groupId;
		var groupName;
		//获取跳转过来的参数
		function GetQueryString(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if (r != null)
				return unescape(r[2]);
			return null;
		}
		$(function() {
			//--------------
			$("#data-ecCharLoading").hide();
			
			
			//获取分组数据
			$.post("${contextPath}/controller/showGroup", function(data) {
				console.log(data);
				if (data.code == "0") {
					//显示左边分组情况；
					showData(data.result, "#tableGroup", "#admin-group");
				}
			});
			groupId = GetQueryString("groupId");
			//---------------------------------------------显示分组imei号；
			$('#dataShow').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/showGroupImei",
				height : 400,
				pagination : true,
				sidePagination : "server",//服务器分页     	    
				pageSize : 10,
				pageNumber : 1,
				pageList : [ 10 ],
				queryParams : getParams,
				clickToSelect : true,//选择行即选择checkbox  
				singleSelect : true,//仅允许单选  
			/* 	             columns: [
				                        
			                        { checkbox:"ture",  align: "center", valign: "middle", sortable: "false" },
				                    { field: "n_id", title:"id", align: "center", valign: "middle", sortable: "true"},  
				                    { field: "c_imei", title: "ss", align: "center", valign: "middle", sortable: "true" }, 
				                    { field: "c_group_id", title: "dd", align: "center", valign: "middle", sortable: "true" },     
				                    ], */

			});
			function getParams(params) {
				return {
					offset : params.offset,
					groupId : groupId,
					sort : params.sort,
					order : params.order
				};
			}
			//-------------------------------------------------------------显示下拉框	
			$.post("${contextPath}/controller/singleShowGroupName", {
				groupId : groupId,
			}, function(data) {
				if (data.state == "0") {
					showData(data.result, "#selectObjView", "#select-group");
					showData(data.result, "#selectObjView","#select-group-updata");
					showData(data.result, "#selectObjView","#select-group-daoru");
					groupName = data.result[0].c_group_name;
				}
			});

		});
		//---------------------批量导入
		$("#daoruFenzu").click(function() {
			$("#daoruFenzuModal .alert").hide();
			$("#daoruFenzuModal").modal();
		});
		$("#daoruFenzuModal .saveBtn").click(function() {
		
			//上传imei
			var file=$("input[name='file']").val(); 
			var filename=file.replace(/.*(\/|\\)/, ""); 
			var fileExt=(/[.]/.exec(filename)) ? /[^.]+$/.exec(filename.toLowerCase()) : '';  
			 if(fileExt!="xlsx")
				 {
				 alert("上传文件类型错误,请重新上传文件")
				 }else{
					 ajaxFileUpload();
						$("#data-ecCharLoading").show();
						$("#daoruFenzuModal").modal("hide");
				 }
			 
			
		});
		//上传文件；
		 function ajaxFileUpload() {
			 var groupid= $("#select-group-daoru option:selected").attr("value");
	            $.ajaxFileUpload
	            (
	                {
	                    url: '${contextPath}/controller/fileUpload2?groupid='+groupid, //用于文件上传的服务器端请求地址
	                    secureuri: false, //是否需要安全协议，一般设置为false
	                    fileElementId: 'groupFile', //文件上传域的ID
	                    dataType: 'json', //返回值类型 一般设置为json
	                    success: function (data, status)  //服务器成功响应处理函数
	                    {
	                    	$('#dataShow').bootstrapTable('refresh', {
	        					silent : true
	        				});
	                    	$("#data-ecCharLoading").hide();
	                    	
	                    },
	                }
	            )
	            return false;
	        }
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		//新增分组
		var addFenzuGroupEle = $("#addNewFenzuModal input[type=text]");
		$("#addNewFenzu").click(function() {
			$("#addNewFenzuModal .alert").hide();
			$("#addNewFenzuModal").modal();
		});
		$("#addNewFenzuModal").on("hidden.bs.modal", function() {
			addFenzuGroupEle.val("");
			$("#addNewFenzuModal .alert").hide();
		});
		$("#addNewFenzuModal .saveBtn").click(function() {
			var value = addFenzuGroupEle.val().trim();
			if (value === "") {
				$("#addNewFenzuModal .alert").show();
				return;
			}
			$.post("${contextPath}/controller/addDeviceImei", {
				imei : value,
				groupid : groupId
			}, function(data) {
				$('#dataShow').bootstrapTable('refresh', {
					silent : true
				});
				$("#addNewFenzuModal").modal("hide");
			});

		});

		$('#dataShow').on('click-row.bs.table', function(row, $element, field) {
			var data = $element;
			//  n_id: 64, c_imei: "1111111111111111111", c_group_id: "中国太平洋保险"
			console.log(data);
			changeFenzuObj.el = data;
			changeFenzuObj.n_id = data.n_id;
			changeFenzuObj.c_imei = data.c_imei;
		});
		var changeFenzuObj = {
			el : null,
			n_id : null,
			c_imei : null,
		};
		//删除分组
		$("#deleteFenzu").click(function() {
			if (changeFenzuObj.n_id == null) {
				alert("请选择一个imei号");
				return;
			}
			$("#deleteFenzuModalText").html(changeFenzuObj.c_imei);
			$("#deleteFenzuModal").modal();
		});

		$("#deleteFenzuModal .saveBtn").click(function() {

			$.post("${contextPath}/controller/deleteDeviceImei", {
				groupid : changeFenzuObj.n_id,
			}, function(data) {
				if (data.state == "0") {
					changeFenzuObj = {
						el : null,
						n_id : null,
						c_imei : null,
					};
					$('#dataShow').bootstrapTable('refresh', {
						silent : true
					});
					$("#deleteFenzuModal").modal("hide");
				}
			});
		});

		//--------------------------------------------------修改	
		//修改分组
		$("#reviseFenzu").click(function() {
			if (changeFenzuObj.n_id == null) {
				alert("请选择一个imei号");
				return;
			}
			$("#reviseFenzuModalText").val(changeFenzuObj.c_imei);
			$("#reviseFenzuModal").modal();
		});

		$("#reviseFenzuModal").on("hidden.bs.modal", function() {
			$("#reviseFenzuModalText").val("");
			$("#reviseFenzuModal .alert").hide();
		});

		$("#reviseFenzuModal .saveBtn").click(function() {
			var value = $("#reviseFenzuModalText").val().trim();

			if (value === "") {
				$("#reviseFenzuModal .alert").show();
				return;
			}
			$.post("${contextPath}/controller/updateDeviceImei", {
				id : changeFenzuObj.n_id,
				imei : value,
				groupid : groupId

			}, function(data) {
				console.log(data);
				if (data.state == "0") {

					$("#reviseFenzuModalText").val("");
					$("#reviseFenzuModal").modal("hide");
					$('#dataShow').bootstrapTable('refresh', {
						silent : true
					});
				}
			});
		});

		//-------------------------------点击空白处

		$("body").bind('click', function() {

			$('#search-fuzzy').hide();
			$('#search-fuzzy1').hide();
		});
	</script>
</body>
</html>