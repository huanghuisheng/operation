<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	<link href="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.css" rel="stylesheet"/> 
	<script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>
	<script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>  
	<script src="${contextPath}/js/jquery.shCircleLoader.js"></script> 
	<script src="${contextPath}/js/ajaxfileupload.js"></script>
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
         		<ul class="nav navbar-nav">
					<li><a href="${contextPath1}deviceControl">设备监控</a></li>
	  	 		</ul>
          		<ul class="nav navbar-nav navbar-right">
            		<li class="dropdown">
              			<a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">个人中心<span class="caret"></span></a>
              			<ul class="dropdown-menu" role="menu">
                	<li><a href="${contextPath2}secondDeviceControl">退出</a></li>
              			</ul>
            		</li>
          	    </ul>
<%-- 	  	        <form class="navbar-form navbar-right" role="search"   action="${contextPath}/controller/search" method="post"  >
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
							<div class="panel panel-default">
								<div class="panel-heading">
									<button id="addNewFenzu" type="button" class="btn btn-default">
										<span class="glyphicon glyphicon-plus"></span>新增
									</button>
									<button id="reviseFenzu" type="button" class="btn btn-default">
										<span class="glyphicon glyphicon-pencil"></span>修改
									</button>
									<button id="deleteFenzu" type="button" class="btn btn-default">
										<span class="glyphicon glyphicon-minus-sign"></span>删除
									</button>
									<button id="daoruFenzu" type="button" class="btn btn-default">
										<span class="glyphicon glyphicon-cloud-upload"></span>批量导入
									</button>
									<div class="form-group sbglTopSearch">
										<input type="text" class="form-control pull-left"
											placeholder="Search" id="search-imei">
										<button type="submit" class="btn btn-primary" id="search">搜索</button>
										<div class="list-group" id="search-fuzzy">
											<ul class="dropdown-menu" role="menu"
												aria-labelledby="dropdownMenu1" id="search-fuzzy1">
												<li role="presentation"><a role="menuitem"
													tabindex="-1">Java</a></li>
											</ul>
										</div>
									</div>
								</div>
								<div class="ecCharLoading" id="data-ecCharLoading"></div>
								<table class="table table-bordered" id="dataShow">
									<thead>
										<tr>
							                 <th data-checkbox="true" data-sortable="false"  ><input type="checkbox" id="allselect"></th>
							                 <th data-field="n_id" data-visible="false" data-class="n_id"  >id</th>
							                 <th data-field="c_group" data-visible="false" data-class="c_group"  >c_group</th>
							                 <th data-field="c_imei" data-class="c_imei" data-events="operateEvent">IMEI</th>  
							                 <th data-field="c_client_name" data-class ="c_client_name">用户名称</th>  
							                 <th data-field="c_car_number" data-class ="c_car_number">车牌号</th>  
							                 <th data-field="c_remark" data-class ="c_remark">备注</th>  
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
					<h4 class="modal-title" id="myModalLabel">新增账号</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">IMEI</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-imei" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">所属分组</label>
							<div class="col-sm-9">
								<p style="padding-top: 7px;">全部设备</p>
							</div>
					  	</div>

					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-name" placeholder="">
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">车牌号</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-car-number" placeholder="">
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">备注</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-remark" placeholder="">
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
							<label for="inputEmail3" class="col-sm-2 control-label">IMEI</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-imei1" placeholder="">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">所属分组</label>
							<div class="col-sm-9">
								<p style="padding-top: 7px;">全部设备</p>
							</div>
					  	</div>

					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">用户名称</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-name1" placeholder="">
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">车牌号</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-car-number1" placeholder="">
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">备注</label>
							<div class="col-sm-9">
								<input type="text" class="form-control" id="client-remark1" placeholder="">
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
					<h4 class="modal-title" id="myModalLabel">删除设备</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-2 control-label">
								<span class="glyphicon glyphicon-exclamation-sign jinggao"></span>
							</label>
							<div class="col-sm-10">
								<p>您确定要删除设备：<span class="alert-danger"><label id="deleteFenzuModalText">23348934355</label></span>吗？</p>
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
					<form class="form-horizontal" id="formId1" role="form"  action="${contextPath}/controller/secondFileUpload" method="post" enctype="multipart/form-data">
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">分组选择</label>
							<div class="col-sm-9">
								<p style="padding-top: 7px;">全部设备</p>
							</div>
					  	</div>
					  	<div class="form-group">
							<label for="inputEmail3" class="col-sm-2 control-label">上传文件</label>
							<div class="col-sm-9">
								  <input type="file" name="file" id="secondFile">
								<p class="help-block"><a href="${contextPath}/controller/fileDownload">下载文件模板</a></p>
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

	<script id="tableObjView" type="text/html">
	{{# for(var i = 0, len = d.length; i < len; i++){ }}
      <tr data-n_id={{d[i].n_id}} data-c_group={{d[i].c_group}} data-c_imei={{d[i].c_imei}}   data-c_client_name={{d[i].c_client_name}} data-c_remark={{d[i].c_remark}} data-c_car_number={{d[i].c_car_number}}                   >
			<td><input type="checkbox"></td>
			<td>{{d[i].c_imei}}</td>
            <td>{{d[i].c_client_name}}</td>
            <td>{{d[i].c_car_number}}</td>
            <td>{{d[i].c_remark}}</td>
      </tr>
	{{# } }}
   </script>
	<script id="searchGroup" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
            <li  role="presentation" data-n_id={{d[i].n_id}} data-c_imei={{d[i].c_imei}} >
		    <a role="menuitem" tabindex="-1" >{{d[i].c_imei}}</a>
			</li> 
 	    {{# } }}
	</script>	
	
	<script>
	$("#data-ecCharLoading").hide();
	var groupid;
	//显示分组数据
	function showData(data, tmpl, target){
		var gettpl = $(tmpl).html();
		laytpl(gettpl).render(data, function(html){
	  		$(target).html(html)
		});
	}
		
	//----------------------------------------显示账号；
	$('#dataShow').bootstrapTable({
    	            method: 'get',
    	            url: "${contextPath}/controller/showSecondeClientAccout",
    	            height: 400,    	             
    	            pagination: true,
    	            sidePagination: "server",//服务器分页  
    	            pageSize: 10,
    	            pageNumber: 1,
    	            pageList: [10],
    	            queryParams: getParams,    
    	            clickToSelect: true,//选择行即选择checkbox  
                    singleSelect: true,//仅允许单选  
    /* 	             columns: [
    	                        
                            { checkbox:"ture",  align: "center", valign: "middle", sortable: "false" },
    	                    { field: "n_id", title:"id", align: "center", valign: "middle", sortable: "true"},  
    	                    { field: "c_imei", title: "ss", align: "center", valign: "middle", sortable: "true" }, 
    	                    { field: "c_group_id", title: "dd", align: "center", valign: "middle", sortable: "true" },     
    	                    ], */ 
    	                       
    	                      
    	        });
	        function getParams(params) {  
	            return { offset: params.offset};  
	        }  
		
	
	    	//----------------------------------实时监听searchimei的变化
	    	$('#search-imei').bind('input propertychange', function() { 
	    		var data= $(this).val();
	      //实时模糊查询
	    		if(data.length>0){
	    			$.post("${contextPath}/controller/fuzzySearch", 
	    					{
	    				search:data,
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
	    	$("#search").click(function(){

	    			var value = $("#search-imei").val();	
	    			 $.post("${contextPath}/controller/secondSearch", 
	    					 {
	    				 search:value,
	    					 },
	    					 function(data){				
	    					$('#dataShow').bootstrapTable('load',data);
	    			    });		
	    		})
		
		
		
	//	新增IMEI账号
		$("#addNewFenzu").click(function(){
			$("#addNewFenzuModal .alert").hide();
			$("#addNewFenzuModal").modal();
		});
		
		$("#addNewFenzuModal").on("hidden.bs.modal", function(){
			addFenzuGroupEle.val("");
			$("#addNewFenzuModal .alert").hide();
		});
		
		$("#addNewFenzuModal .saveBtn").click(function(){
			var clientImei= $('#client-imei').val();
			var clientName= $('#client-name').val();
			var carNumber= $('#client-car-number').val();
			var clientRemark= $('#client-remark').val();

			if(clientImei === ""){
				$("#addNewFenzuModal .alert").show();
				return;
			}
			  $.post("${contextPath}/controller/addDeviceClient", {
				  clientName: clientName,
				  clientImei: clientImei,
				 carNumber: carNumber,
				 clientRemark: clientRemark,
				 imeiRroup: groupid,
			}, function(data){			
				$('#dataShow').bootstrapTable('refresh', {silent: true});
				$("#addNewFenzuModal").modal("hide");
			});  
		});
		
	
		
	     $('#dataShow').on('click-row.bs.table', function (row, $element, field) {
	            var data=$element;
	            changeFenzuObj.el = data;
	            changeFenzuObj.n_id = data.n_id;			
	 			changeFenzuObj.c_imei = data.c_imei; 
	 		    changeFenzuObj.c_group = data.c_group;			
	 			changeFenzuObj.c_client_name = data.c_client_name; 
	 		    changeFenzuObj.c_car_number = data.c_car_number;			
	 			changeFenzuObj.c_remark = data.c_remark; 
	        });
		
		var changeFenzuObj = {
			el: null,
			n_id: null,
			c_group: null,
			c_imei: null,
			c_client_name: null,
			c_remark: null,
			c_car_number: null,		
		};
		
		//修改分组
		$("#reviseFenzu").click(function(){
			if(changeFenzuObj.n_id == null){
				alert("请选择一个账号");
				return;
			}
			//自动填充
			$("#client-imei1").val(changeFenzuObj.c_imei);
			$("#client-name1").val(changeFenzuObj.c_client_name);
			$("#client-car-number1").val(changeFenzuObj.c_car_number);
			$("#client-remark1").val(changeFenzuObj.c_remark);
			$("#reviseFenzuModal").modal();
		});
		
		$("#reviseFenzuModal").on("hidden.bs.modal", function(){
			$("#reviseFenzuModalText").val("");
			$("#reviseFenzuModal .alert").hide();
		});
		
		$("#reviseFenzuModal .saveBtn").click(function(){
            var clientImei= $('#client-imei1').val();
			var clientName= $('#client-name1').val();
			var carNumber= $('#client-car-number1').val();	
			var clientRemark= $('#client-remark1').val();		
			if(clientImei === ""){
			  alert("imei号不能为空");	
				return;
			}
		$.post("${contextPath}/controller/updateDeviceClient", {
				clientId : changeFenzuObj.n_id,
				clientName : clientName,
				clientImei : clientImei,
				carNumber : carNumber,
				clientRemark : clientRemark,
				imeiRroup : groupid,
			}, function(data) {
				$('#dataShow').bootstrapTable('refresh', {
					silent : true
				});
				$("#reviseFenzuModal").modal("hide")
			});
		});

		//删除
		$("#deleteFenzu").click(function() {
			if (changeFenzuObj.n_id == null) {
				alert("请选择一个分组");
				return;
			}
			$("#deleteFenzuModalText").html(changeFenzuObj.c_imei);
			$("#deleteFenzuModal").modal();
		});

		$("#deleteFenzuModal .saveBtn").click(function() {
			$.post("${contextPath}/controller/deleteDeviceClient", {
				deviceClientId : changeFenzuObj.n_id
			},
			function(data) {
				$('#dataShow').bootstrapTable('refresh', {
					silent : true
				});
				$("#deleteFenzuModal").modal("hide");
			});
		});

		//-----------------------------------------------批量导入;
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
		
            $.ajaxFileUpload
            (
                {
                    url: '${contextPath}/controller/secondFileUpload', //用于文件上传的服务器端请求地址
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId: 'secondFile', //文件上传域的ID
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
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

		//-------------------------------点击空白处

		$("body").bind('click', function() {
			$('#search-fuzzy').hide();
			$('#search-fuzzy1').hide();
		});
	</script>
</body>
</html>