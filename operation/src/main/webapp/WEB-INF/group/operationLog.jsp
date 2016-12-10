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
<script src="${contextPath}/js/leftMenu.js"></script>
<link   href="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.css" rel="stylesheet" />
<script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>


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
			   <jsp:include page="/WEB-INF/basicPage/deviceMenu.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" aria-expanded="false">个人中心<span
							class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="${contextPath1}deviceControl">退出</a></li>
						</ul>
					</li>
				</ul>

				<%-- 		  	    <form class="navbar-form navbar-right" role="search"   action="${contextPath}/controller/search" method="post"  >
					<div class="form-group">
				  		<input type="text" class="form-control" placeholder="Search" id="device-search" name="search">
				  		<button type="button" class="btn btn-default"  id="device-search1" >搜索</button>
					</div>
			  	</form> --%>
				<jsp:include page="/WEB-INF/basicPage/firstSearch.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>



			</div>
		</div>
	</nav>

	<div class="container-fluid" id="allclick">
		<div class="row">

			<div class="col-sm-9 col-md-10 col-md-offset-2 col-sm-offset-3 main">

				<div class="sbgl">
					<div class="row">
						<jsp:include page="/WEB-INF/basicPage/leftMenu3.jsp">
							<jsp:param name="title" value="登录页面" />
						</jsp:include>


						<div class="col-sm-12 col-md-10">
							<div class="panel panel-default" id="panel-head">
								<div class="panel-heading">
									<div class="input-group" style="width: 185px;">
										<span class="input-group-addon">操作人：</span> <input type="text"
											class="form-control" placeholder="用户名" id="operationlog-name">
									</div>
									<div class="input-group" style="width: 200px;">
										<span class="input-group-addon">操作类型：</span> 
										<select
											class="form-control pull-left operation-content"
											name="operation-content" id="operation-content">
											<option value="user_login">登录</option>
											<option value="user_dropout">退出</option>
											<option value="user_add">新增</option>
											<option value="user_update">修改</option>
											<option value="user_delete">删除</option>
										</select>
									</div>
									<div class="input-group" style="width: 185px;">
										<span class="input-group-addon">操作时间：</span>
										<div class="modalDropdownSelectBox clearfix" id="operationlog">
											<div class="dropdown pull-right">
												<button class="btn btn-default dropdown-toggle"
													type="button" id="operationlogtime">
													&nbsp;2016.06.25~2016.07.01 <span class="caret"></span>
												</button>
												<ul class="dropdown-menu timeSelect" role="menu"
													id="operationlogtimeSelect">
													<li class="clearfix" role="presentation">
														<p class="pull-left">开始：</p> <select
														class="form-control pull-left year1"
														name="operationlog-year1" id="operationlog-year1">
															<option value="2016">2016年</option>
															<option value="2015">2015年</option>
															<option value="2014">2014年</option>
													</select> <select class="form-control pull-left month1 "
														name="operationlog-month1" id="operationlog-month1">
															<option value="12">12月</option>
															<option value="11">11月</option>
															<option value="10">10月</option>
															<option value="9">9月</option>
															<option value="8">8月</option>
															<option value="7">7月</option>
															<option value="6">6月</option>
															<option value="5">5月</option>
															<option value="4">4月</option>
															<option value="3">3月</option>
															<option value="2">2月</option>
															<option value="1">1月</option>
													</select> <select class="form-control pull-left day1"
														name="operationlog-day1" id="operationlog-day1">
															<option value="31">31日</option>
															<option value="30">30日</option>
															<option value="29">29日</option>
															<option value="28">28日</option>
															<option value="27">27日</option>
															<option value="26">26日</option>
															<option value="25">25日</option>
															<option value="24">24日</option>
															<option value="23">23日</option>
															<option value="22">22日</option>
															<option value="21">21日</option>
															<option value="20">20日</option>
															<option value="19">19日</option>
															<option value="18">18日</option>
															<option value="17">17日</option>
															<option value="16">16日</option>
															<option value="15">15日</option>
															<option value="14">14日</option>
															<option value="13">13日</option>
															<option value="12">12日</option>
															<option value="11">11日</option>
															<option value="10">10日</option>
															<option value="09">09日</option>
															<option value="08">08日</option>
															<option value="07">07日</option>
															<option value="06">06日</option>
															<option value="05">05日</option>
															<option value="04">04日</option>
															<option value="03">03日</option>
															<option value="02">02日</option>
															<option value="01">01日</option>
													</select>
													</li>
													<li class="clearfix" role="presentation">
														<p class="pull-left">结束：</p> <select
														class="form-control pull-left year2"
														name="operationlog-year2" id="operationlog-year2">
															<option value="2016">2016年</option>
															<option value="2015">2015年</option>
															<option value="2014">2014年</option>
													</select> <select class="form-control pull-left month2"
														name="operationlog-month2" id="operationlog-month2">
															<option value="12">12月</option>
															<option value="11">11月</option>
															<option value="10">10月</option>
															<option value="9">9月</option>
															<option value="8">8月</option>
															<option value="7">7月</option>
															<option value="6">6月</option>
															<option value="5">5月</option>
															<option value="4">4月</option>
															<option value="3">3月</option>
															<option value="2">2月</option>
															<option value="1">1月</option>
													</select> <select class="form-control pull-left day2"
														name="operationlog-day2" id="operationlog-day2">
															<option value="31">31日</option>
															<option value="30">30日</option>
															<option value="29">29日</option>
															<option value="28">28日</option>
															<option value="27">27日</option>
															<option value="26">26日</option>
															<option value="25">25日</option>
															<option value="24">24日</option>
															<option value="23">23日</option>
															<option value="22">22日</option>
															<option value="21">21日</option>
															<option value="20">20日</option>
															<option value="19">19日</option>
															<option value="18">18日</option>
															<option value="17">17日</option>
															<option value="16">16日</option>
															<option value="15">15日</option>
															<option value="14">14日</option>
															<option value="13">13日</option>
															<option value="12">12日</option>
															<option value="11">11日</option>
															<option value="10">10日</option>
															<option value="09">09日</option>
															<option value="08">08日</option>
															<option value="07">07日</option>
															<option value="06">06日</option>
															<option value="05">05日</option>
															<option value="04">04日</option>
															<option value="03">03日</option>
															<option value="02">02日</option>
															<option value="01">01日</option>
													</select>
													</li>
													<li class="clearfix" role="presentation">
														<button type="button" class="btn btn-primary"
															id="operationlog-confirm">确定</button>
														<button type="button" class="btn btn-default" id="cancel3">取消</button>
													</li>
												</ul>
											</div>
										</div>


									</div>
									<button type="button" class="btn btn-primary"
										id="operationlog-search">搜索</button>
								</div>
								<table class="table table-bordered" id="dataShow">
									<thead>
										<tr>
										<!-- data-field="state" data-checkbox="true" -->
										<th data-field="state" data-checkbox="true" data-sortable="false"></th>
										
										<!-- 	<th data-checkbox="true" data-sortable="false"><input type="checkbox" id="allselect"></th> -->
											<th data-field="n_id" data-visible="false" data-class="n_id">id</th>
											<th data-field="c_name" data-class="c_name" >操作人</th>
											<th data-field="c_address" data-class="c_address">ip地址</th>
											<th data-field="c_type" data-class="c_type">操作类型</th>
											<th data-field="c_content" data-class="c_content">操作内容</th>
											<th data-field="t_create_time"      data-formatter="nameFormatter"      data-class="t_create_time">操作时间</th>
											<th data-field="c_group" data-class="c_group">所属分组</th>


										</tr>
									</thead>
								</table>
				<!-- 				<table class="table table-bordered" id="dataShow1" >
									<thead>
										<tr>
											<th data-checkbox="true" data-sortable="false"><input type="checkbox" id="allselect"></th>
											<th data-field="n_id" data-visible="false" data-class="n_id">id</th>
											<th data-field="c_name" data-class="c_name" >操作人</th>
											<th data-field="c_address" data-class="c_address">ip地址</th>
											<th data-field="c_type" data-class="c_type">操作类型</th>
											<th data-field="c_content" data-class="c_content">操作内容</th>
											<th data-field="t_create_time" data-class="t_create_time">操作时间</th>
											<th data-field="c_group" data-class="c_group">所属分组</th>


										</tr>
									</thead>
								</table> -->
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>



	<script id="tableGroup" type="text/html">

		{{# for(var i = 0, len = d.length; i < len; i++){ }}

     <li class="list-group-item"><a href=firstDeviceImei.jsp?groupId={{d[i].n_id}}>{{d[i].c_group_name}}</a></li>

     	{{# } }}
	</script>

	<script id="searchGroup" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}

                <li  role="presentation" data-n_id={{d[i].n_id}} data-c_imei={{d[i].c_imei}} >
				<a role="menuitem" tabindex="-1" >{{d[i].c_imei}}</a>
				</li> 
    
 	{{# } }}
	</script>

	<!-- 		<li data-n_id={{d[i].n_id}} data-c_imei={{d[i].c_imei}}>		
             <td>{{d[i].c_imei}}</td>
		</li> -->

	<!--    选择分组	 -->
	<!-- "select-group"> -->
	<script id="selectObjView" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
		<option value={{d[i].n_id}} >{{d[i].c_group_name}}</option>
     	{{# } }}
	</script>

	<script>
	
		function baseDate(nowDate, pastDate) {

			return (nowDate.getTime() - pastDate.getTime())
					/ (24 * 60 * 60 * 1000);
		};
		function addDate1(date, days) {

			var d = date;
			d.setDate(d.getDate() + days);
			var month = d.getMonth() + 1;
			var day = d.getDate();
			if (month < 10) {
				month = "0" + month;
			}
			if (day < 10) {
				day = "0" + day;
			}
			// var val = d.getFullYear()+"."+month+"."+day;

			var val = new Array(); // 定义一数组
			val[0] = d.getFullYear();
			val[1] = month;
			val[2] = day;

			return val;
		}
		//-------------时间操作；
		var now = new Date();
		var year = now.getFullYear();
		var month = (now.getMonth() + 1).toString();
		var day = (now.getDate()).toString();
		if (month.length == 1) {
			month = "0" + month;
		}
		if (day.length == 1) {
			day = "0" + day;
		}
		var dateTime = year + "." + month + "." + day;
		var time = [];
		time = addDate1(now, -6);

		// 下拉框默认选中
		// year1.selectedIndex=0 开始
		$(".year1 option").each(function() {
			if ($(this).attr("value") == time[0]) {
				$(this).attr("selected", "selected");
			}
		});
		$(".month1 option").each(function() {
			if ($(this).attr("value") == time[1]) {
				$(this).attr("selected", "selected");
			}
		});

		$(".day1 option").each(function() {
			if ($(this).attr("value") == time[2]) {
				$(this).attr("selected", "selected");
			}
		});
		// 结束
		$(".year2 option").each(function() {
			if ($(this).attr("value") == year) {
				$(this).attr("selected", "selected");
			}
		});
		$(".month2 option").each(function() {
			if ($(this).attr("value") == month) {
				$(this).attr("selected", "selected");
			}
		});

		$(".day2 option").each(function() {
			if ($(this).attr("value") == day) {
				$(this).attr("selected", "selected");
			}
		});

		time = time[0] + "." + time[1] + "." + time[2]

		$("#operationlogtime").html(time + "-" + dateTime);

		$("#operationlog").click(function(event) {
			$(this).find(".dropdown-menu").show();
		});

		$("#operationlog-confirm").click(function(event) {

			var time1 = $("#operationlog-year1 option:selected").val();
			var time2 = $("#operationlog-month1 option:selected").val();
			var time3 = $("#operationlog-day1 option:selected").val();
			var time4 = time1 + "." + time2 + "." + time3;

			var time5 = $("#operationlog-year2 option:selected").val();
			var time6 = $("#operationlog-month2 option:selected").val();
			var time7 = $("#operationlog-day2 option:selected").val();
			var time8 = time5 + "." + time6 + "." + time7;

			var start;
			var end
			var mb = BaseUtility.myBrowser();
			if (mb == "Firefox") {
				start = new Date(time1, time2, time3, "", "", "");
				end = new Date(time5, time6, time7, "", "", "");
			} else {
				start = new Date(time4);
				end = new Date(time8);
			}

			var operationlogtime = baseDate(end, start);
			if (operationlogtime < 0) {
				alert("日期选择错误,开始时间不能大于结束时间");
			} else {
				$("#operationlogtime").html(time4 + "-" + time8);
			}
			$("#operationlogtimeSelect").hide();
			event.stopPropagation();

		});
		var alltype;
		var allname;
		var time1;
		var time2;
		var url="${contextPath}/controller/showOperationlog";
		var getParamsAll=getParams;
		
		
		$("#operationlog-search").click(function(event) {
			

			//$("#dataShow").css({display:"none"});
			

			var name = $("#operationlog-name").val();
			allname=name;
			var type = $("#operation-content option:selected").val();
            alltype=type;
			var time = $("#operationlogtime").html();
			
			var timeSum = time.split("-");
			 time1=timeSum[0];
			 time2=timeSum[1];

			url="${contextPath}/controller/searchOperationlog?name="+allname+"&&type="+alltype+"&&time1="+time1+"&&time2="+time2;
			$('#dataShow').bootstrapTable('refresh', {url: url});
		});
		
		function getParams1(params) {
			return {
				offset : params.offset,
				name : allname,
				type : alltype,
				time1 : time1,
				time2 : time2
			};
		}
		
		
		$(function() {
			//---------------------------------------------显示日志；
			$('#dataShow').bootstrapTable({
				method : 'get',
				url : url,
				height : 600,
				pagination : true,
				sidePagination : "server",//服务器分页  
				sortable : true,
				sortOrder : "desc",
				sortName:"t_create_time",
				pageSize : 20,
				pageNumber : 1,
				pageList : [ 20 ],
				queryParams : getParams,
				clickToSelect : true,//选择行即选择checkbox  
				singleSelect : true,//仅允许单选  
			});
		});	
		
		function nameFormatter(value) {
	
			var time=BaseUtility.longConvertDate(value);
			
		    return time;
		}
		
		
		function getParams(params) {
			return {
				offset : params.offset,
				sort : params.sort,
				order : params.order
			};
		}

		
		
		
	
		
		
		
		
		
		
		
		
		
		
		
		

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


	</script>
</body>
</html>