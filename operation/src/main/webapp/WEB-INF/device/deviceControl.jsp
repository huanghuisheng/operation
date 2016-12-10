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
<script src="${contextPath}/js/jquery.shCircleLoader.js"></script>

<script src="${contextPath}/js/china.js"></script>


<link
	href="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.css"
	rel="stylesheet" />
<script
	src="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>
<script
	src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>
</head>
<body>
	<div class="dynamic-dialog" id="dynamic-dialog">
		<div id="loading"></div>
	</div>
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

		        <jsp:include page="/WEB-INF/basicPage/groupMenu1.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>

				<jsp:include page="/WEB-INF/basicPage/firstSearch.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>
			</div>
		</div>
	</nav>

	<div class="container-fluid" id="allclick">
		<div class="row">
			<div class="col-sm-12 col-md-12  main">

				<h3 class="page-header">群体统计分析</h3>
				<div class="row placeholders qttjfxBox">
					<div class="col-xs-12 col-md-4 placeholder" data-toggle="modal"
						data-target="#jsxwpfModal">
						<div class="panel panel-default">
							<div class="panel-heading">驾驶行为评分</div>
							<div class="panel-body">
								<div id="jsxwpfBrief" class="ecChartBox"></div>
								<div class="ecCharLoading" id="driverBeheaver-ecCharLoading"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-md-4 placeholder" data-toggle="modal"
						data-target="#dgjsxwfxModal">
						<div class="panel panel-default">
							<div class="panel-heading">单个驾驶行为分析:碰撞</div>
							<div class="panel-body">
								<div id="dgjsxwfxBrief" class="ecChartBox"></div>
									<div class="ecCharLoading" id="singleDriverBeheaver-ecCharLoading"></div>
							</div>
						</div>
					</div>

					<div class="col-xs-12 col-md-4 placeholder" data-toggle="modal"
						data-target="#glhddyModal">
						<div class="panel panel-default">
							<div class="panel-heading">规律活动地域</div>
							<div class="panel-body">
								<div id="glhddyBrief" class="ecChartBox"></div>
								<div class="ecCharLoading" id="ruleActivityArea-ecCharLoading"></div>
							</div>
						</div>
					</div>

					<div class="col-xs-12 col-md-4 placeholder" data-toggle="modal"
						data-target="#jslbModal">
						<div class="panel panel-default">
							<div class="panel-heading">车主类别</div>
							<div class="panel-body">
								<div id="jslbBrief" class="ecChartBox"></div>
								<div class="ecCharLoading" id="divercategory-ecCharLoading"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-12 col-md-4 placeholder" data-toggle="modal"
						data-target="#jsglsjdModal">
						<div class="panel panel-default">
							<div class="panel-heading">驾驶规律时间段</div>
							<div class="panel-body">
								<div id="jsglsjdBrief" class="ecChartBox"></div>
								<div class="ecCharLoading" id=diverRuleTime-ecCharLoading></div>
							</div>
						</div>
					</div>
				</div>

				<h3 class="page-header">所有已激活用户列表</h3>
				<div class="panel panel-default syyhzfList">
					<div class="panel-heading">
						<h3 class="panel-title clearfix">
							<div class="dropdown pull-right  syyhzfSelect">
								<button class="btn btn-default dropdown-toggle device-userlist-button1"type="button " id="dropdownMenu1" data-toggle="dropdown">最近一年 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu" id="dropdown-menu1"
									aria-labelledby="dropdownMenu1">
									<li role="presentation" class="userlist" value="year"><a
										role="menuitem" tabindex="-1">最近一年</a></li>
									<li role="presentation" class="userlist" value="month3"><a
										role="menuitem" tabindex="-1">最近一季度</a></li>
									<li role="presentation" class="userlist" value="month1"><a
										role="menuitem" tabindex="-1">最近一个月</a></li>
								<!-- 	<li role="presentation" class="userlist" value="week"><a
										role="menuitem" tabindex="-1">最近一周</a></li> -->
								</ul>
							</div>
						</h3>
					</div>
					<table class="table table-hover" id="dataShow">
					</table>
				</div>

			</div>

		</div>
	</div>

	<div class="modal fade bs-example-modal-lg" id="jsxwpfModal"
		tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">驾驶行为评分
					<div class="fnTips">
							<i class="glyphicon glyphicon-question-sign"></i>
							<div class="fnTipsInfo">了解用户驾驶行为评分的整体水平和分布</div>
					</div>
					</h4>
				</div>

				<div class="modal-body">
					<div class="modalDropdownSelectBox clearfix">
						<div class="dropdown pull-left">
							<p class="pull-left">用户群体选择：</p>
								<p class="pull-left">
								<select class="form-control pull-left operation-content"
									name="device-divercategory" id="device-driverbehaviour">
									<option value="allcode">全国</option>
									<option value="43">湖南省</option>
									<option value="37">山东省</option>
									<option value="36">江西省</option>
									<option value="34">安徽省</option>
								</select>
							   </p>
						</div>
						<div class="dropdown pull-right  syyhzfSelect">
							<button
								class="btn btn-default dropdown-toggle device-driverbehaviour-button1" value="year"
								type="button " id="dropdownMenu1" data-toggle="dropdown">
								最近一年 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu" id="dropdown-menu1"
								aria-labelledby="dropdownMenu1">
								<li role="presentation" class="driverbehaviour" value="year"><a
									role="menuitem" tabindex="-1">最近一年</a></li>
								<li role="presentation" class="driverbehaviour" value="month3"><a
									role="menuitem" tabindex="-1">最近一季度</a></li>
								<li role="presentation" class="driverbehaviour" value="month1"><a
									role="menuitem" tabindex="-1">最近一个月</a></li>
								<li role="presentation" class="driverbehaviour" value="week"><a
									role="menuitem" tabindex="-1">最近一周</a></li>
							</ul>
						</div>
					</div>
					<div class="ecCharLoading" id=deviceBehaviour1-ecCharLoading></div>
				 	<p class="modalInfoP">
					<span class="lead">用户：<label id="alluser">全体用户（200人）</label></span>
				    <span class="lead">人均驾驶行为评分：<label id="grade">67分</label></span>
					<span class="lead">方差值：<label id="variance">1</label></span>
					</p> 
					<div class="modalEchartsBody">
						<div id="jsxwpfDetails" class="echartsBox"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade bs-example-modal-lg" id="dgjsxwfxModal"
		tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">单个驾驶行为分析
					 <div class="fnTips">
							<i class="glyphicon glyphicon-question-sign"></i>
							<div class="fnTipsInfo">了解用户单项驾驶行为的整体水平和分布</div>
					</div>
					</h4>
				</div>
				<div class="modal-body">
				<div class="ecCharLoading1" id="singleDriverBeheaver-ecCharLoading1"></div>
					<div class="modalDropdownSelectBox clearfix">
						<div class="dropdown pull-left  syyhzfSelect">
							<button
								class="btn btn-default dropdown-toggle device-singledriverbehaviour"
								type="button " id="dropdownMenu1" data-toggle="dropdown"
								value="collide">碰撞次数 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu" id="dropdown-menu1"
								aria-labelledby="dropdownMenu1">
								<li role="presentation" class="singledriverbehaviour-presentation1" value="collide"><a
									role="menuitem" tabindex="-1">碰撞次数</a></li>
								<li role="presentation" class="singledriverbehaviour-presentation1" value="turn"><a
									role="menuitem" tabindex="-1">急转弯次数</a></li>
								<li role="presentation" class="singledriverbehaviour-presentation1" value="speed_up"><a
									role="menuitem" tabindex="-1">急加速次数</a></li>
								<li role="presentation" class="singledriverbehaviour-presentation1" value="speed_down"><a
									role="menuitem" tabindex="-1">急刹车次数</a></li>
							</ul>
						</div>



						<div class="dropdown pull-left">
							<p class="pull-left">用户群体选择：</p>
							   <p class="pull-left">
								<select class="form-control pull-left operation-content"
									name="device-divercategory" id="device-singledriverbehaviour1">
									<option value="allcode">全国</option>
									<option value="43">湖南省</option>
									<option value="37">山东省</option>
									<option value="36">江西省</option>
									<option value="34">安徽省</option>
								 
								</select>
							   </p>
							
						</div>
						<div class="dropdown pull-right  syyhzfSelect">
							<button
								class="btn btn-default dropdown-toggle device-singledriverbehaviour-button1"
								type="button " id="dropdownMenu1" data-toggle="dropdown"
								value="year">
								最近一年 <span class="caret"></span>
							</button>
							<ul class="dropdown-menu" role="menu" id="dropdown-menu1"
								aria-labelledby="dropdownMenu1">
								<li role="presentation" class="singledriverbehaviour"
									value="year"><a role="menuitem" tabindex="-1">最近一年</a></li>
								<li role="presentation" class="singledriverbehaviour"
									value="month3"><a role="menuitem" tabindex="-1">最近一季度</a></li>
								<li role="presentation" class="singledriverbehaviour"
									value="month1"><a role="menuitem" tabindex="-1">最近一个月</a></li>
								<li role="presentation" class="singledriverbehaviour"
									value="week"><a role="menuitem" tabindex="-1">最近一周</a></li>
							</ul>
						</div>


					</div>
					<p class="modalInfoP">
						<span class="lead">用户：全体用户 <label id="alluser2">（200人）</label></span>
					</p>
					<!-- <p class="modalInfoP"><span class="lead">总超速次数：400次</span><span class="lead">人均超速次数：2次</span></p> -->
					<p class="modalInfoP">
						<span class="lead">方差值：<laleb id="variance2">1</laleb></span>
					</p>
					<div class="modalEchartsBody">
						<div id="dgjsxwfxDetails" class="echartsBox"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade bs-example-modal-lg" id="glhddyModal"
		tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">规律活动地域
					 <div class="fnTips">
							<i class="glyphicon glyphicon-question-sign"></i>
							<div class="fnTipsInfo">了解用户在哪个省活动居多</div>
					</div>
					</h4>
				</div>
				<div class="modal-body">
					<div class="modalDropdownSelectBox clearfix">
						<div class="dropdown pull-left">
							<p class="pull-left">用户群体选择:</p>
					        <p class="pull-left">全部用户</p>
						</div>
						<div class="dropdown pull-right">
							<p class="pull-left">统计时间：</p>
							<p class="pull-left" id="ruleArea">截止到1234</p>

						</div>
					</div>
					<div class="modalEchartsBody">
						<div id="glhddyDetails" class="echartsBox"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade bs-example-modal-lg" id="jslbModal"
		tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">车主类别
					 <div class="fnTips">
							<i class="glyphicon glyphicon-question-sign"></i>
							<div class="fnTipsInfo">了解车主的职业类型和占比</div>
					</div>
					</h4>
				</div>
				<div class="modal-body">
					<div class="modalDropdownSelectBox clearfix">
						<div class="ecCharLoading1" id="divercategory-ecCharLoading11"></div>
						<div class="dropdown pull-right">
							<p class="pull-left">用户群体选择:</p>
							<p class="pull-left">
								<select class="form-control pull-left operation-content"
									name="device-divercategory" id="device-divercategory">
							    <option value="allcode">全国</option>
									<option value="43">湖南省</option>
									<option value="37">山东省</option>>
								    <option value="36">江西省</option>
									<option value="34">安徽省</option>
								 
								</select>
							</p>
						</div>
					</div>
					<div class="modalEchartsBody">
						<div id="jslbDetails" class="echartsBox"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade bs-example-modal-lg" id="jsglsjdModal"
		tabindex="-1" role="dialog">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
					</button>
					<h4 class="modal-title">驾驶规律时间段
					 <div class="fnTips">
							<i class="glyphicon glyphicon-question-sign"></i>
							<div class="fnTipsInfo">了解车主通常在一天中的哪些时段开车</div>
					</div>
					</h4>
				</div>
				<div class="modal-body">
					<div class="modalDropdownSelectBox clearfix">
						<div class="dropdown pull-left">
							<p class="pull-left">用户群体选择:</p>
							<p class="pull-left">
								<select class="form-control pull-left operation-content"
									name="device-diverRuleTime" id="device-diverRuleTime">
							        <option value="allcode">全国</option>
									<option value="43">湖南省</option>
									<option value="37">山东省</option>
								    <option value="36">江西省</option>
									<option value="34">安徽省</option>
								</select>
							</p>
						</div>
					</div>
					<div class="modalEchartsBody">
						<div id="jsglsjdDetails" class="echartsBox"></div>
						<div class="ecCharLoading" id=diverRuleTime-ecCharLoading1></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(function() {
			var option;
			var option2;
			var option3;
			var option4;
			var option5;

			//----------初始化时间；
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

			$(".device-time").html("截止到" + "-" + dateTime);
			$(".device-time1").html("截止到" + "-" + dateTime);
			$("#ruleArea").html("截止到" + "-" + dateTime);
			//------------------------------------------------退出登录；

			$("#user_dropout").click(
					function() {
						$.post("${contextPath}/controller/closeAccount",
								function(data) {
									if (data.state == "1") {
										alert("没有此imei号");
									} else {
										window.location.href = "${contextPath}"
												+ "/index.do";
									}
								});
					});
			//-------------------------------------------分页显示初始化；
			$('#dataShow').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/userList?timeFlag=year",
				height : 480,
				pagination : true,
				sidePagination : "server",//服务器分页  
				sortable : true,
				sortOrder : "desc",
				sortName : "c_grade",
				pageSize : 10,
				pageNumber : 1,
				pageList : [ 10 ],
				queryParams : getParams,
				clickToSelect : true,
				columns : [ {
					field : "c_imei",
					title : "设备",
					align : "center",
					valign : "middle",
					sortable : "true",
					formatter : nameFormatter,
				}, {
					field : "c_device_name",
					title : "设备名称",
					align : "center",
					valign : "middle",
				}, {
					field : "c_user_name",
					title : "昵称",
					align : "center",
					valign : "middle",
				}, {
					field : "c_grade",
					title : "总综合评分",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "c_collide",
					title : "总碰撞次数",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "c_fatigue",
					title : "总疲劳次数",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "c_trun",
					title : "总急转弯次数",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "c_speed_up",
					title : "总急加速次数",
					align : "center",
					valign : "middle",
					sortable : "true"
				}, {
					field : "c_speed_down",
					title : "总急刹车次数",
					align : "center",
					valign : "middle",
					sortable : "true"
				} ],
			});
			function nameFormatter(value) {
				if (role == "1") {
					return '<a href="${contextPath1}singleDeviceAll?c_imei='
							+ value + '">' + value + '</a>';
				} else {
					return '<a href="${contextPath1}singleDevice?c_imei='
							+ value + '">' + value + '</a>';
				}

			}
			function getParams(params) {
				return {
					offset : params.offset,
					sort : params.sort,
					order : params.order,
				};
			}

			//-----------------------------------------------------驾驶行为初始化

			$.post("${contextPath}/controller/DriveBehaviorGrade", {
				timeFlag : "year",
				code : "allcode"
			}, function(result) {
				$("#driverBeheaver-ecCharLoading").hide();
				//驾驶行为评分
				$("#alluser").html(result[0].allUser)
				$("#grade").html(result[0].behaviorGrade);
				$("#variance").html(result[0].variance);
				option = {
					tooltip : {
						trigger : 'axis'
					},
					title : {},
					tooltip : {},
					legend : {

					},
					xAxis : {
						data : [ "0~10分", "11~20分", "21~30分", "31~40分",
								"41~50分", "51~60分", "61~70分", "71~80分",
								"81~90分", "91~100分" ]
					},
					yAxis : {
						name : '设备数(台)',
					},
					series : [ {
						name : '驾驶评分',
						type : 'bar',
						data : [ result[0].number1, result[0].number2,
								result[0].number3, result[0].number4,
								result[0].number5, result[0].number6,
								result[0].number7, result[0].number8,
								result[0].number9, result[0].number10 ]
					} ]
				};

				var jsxwpBriefChart = echarts.init($("#jsxwpfBrief")[0]);
				jsxwpBriefChart.setOption(option);
			});
			//-----------------------------------------------------------------单个驾驶行为初始化
			$.post("${contextPath}/controller/singleDriveBehavior", {
				behavior : "collide",
				timeFlag : "year",
				code : "allcode"
			}, function(result) {
				$("#singleDriverBeheaver-ecCharLoading").hide();
				$("#alluser2").html(result[0].sumImei);
				$("#variance2").html(result[0].variance);
				option2 = {
					tooltip : {
						trigger : 'axis'
					},
					xAxis : {
						name : '碰撞次数',
						data : [ '1~50', '51~100', '101~150', '151~200',
								'201~250', '251~300', '301~500', '501~700',
								'701~900', '901~1000' ]
					},
					yAxis : {
						name : '设备数(台)',
					},
					series : [ {
						name : '设备数(台)',
						type : 'bar',
						data : [ result[0].number1, result[0].number2,
								result[0].number3, result[0].number4,
								result[0].number5, result[0].number6,
								result[0].number7, result[0].number8,
								result[0].number9, result[0].number10 ]
					} ]
				};
				var dghsxwfxBriefChart = echarts.init($("#dgjsxwfxBrief")[0]);
				dghsxwfxBriefChart.setOption(option2);
			});
			//--------------------------------------用户规律活动地域初始化
			$.post("${contextPath}/controller/ruleActivityArea", {

			}, function(result) {
				$("#ruleActivityArea-ecCharLoading").hide();
				var data1 = result[0];
				var data3 = [];
				for (var i = 0; i < data1.length; i++) {
					var jsonData1 = {
						"name" : data1[i].province,
						"value" : data1[i].number,
					};
					data3[i] = jsonData1;
				}

				//规律活动地域
				option3 = {
					tooltip : {
						trigger : 'item'
					},
					legend : {
						orient : 'vertical',
						left : 'left',

					},
					visualMap : {
						min : 0,
						max : 2000,
						left : 'left',
						top : 'bottom',
						text : [ '高', '低' ], // 文本，默认为数值文本
						calculable : true,
						inRange : {
							color : [  "#b3d4fc",'#9baefb', '#5777f9',
									'#0937f2' ]
						},
					},
					toolbox : {
						show : true,
						orient : 'vertical',
						left : 'right',
						top : 'center',
						feature : {
							dataView : {
								readOnly : false
							},
							restore : {},
							saveAsImage : {}
						}
					},
					series : [ {
						type : 'map',
						mapType : 'china',
						roam : false,
						label : {
							normal : {
								show : true
							},
							emphasis : {
								show : true
							}
						},
						data : data3,
					} ]
				};
				var glhddyBriefChart = echarts.init($("#glhddyBrief")[0]);
				glhddyBriefChart.setOption(option3);
			});
			//----------------------------------------------------------------用户驾驶类别分类初始化   
			$.post("${contextPath}/controller/divercategory", {
				code : "allcode"
			}, function(result) {
				var data = [];
				for (var i = 0; i < result.length; i++) {
					var jsonData1 = {
						"value" : result[i].number,
						"name" : result[i].diver
					};
					data[i] = jsonData1;
				}
				$("#divercategory-ecCharLoading").hide();
				//驾驶类别
				option4 = {
					tooltip : {
						trigger : 'item',
						formatter : "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
						left : 'left',
						data : [ '货车司机', '上班族', '出租司机', '其他' ]
					},
					series : [ {
						name : '设备数(台)',
						type : 'pie',
						radius : '55%',
						center : [ '50%', '60%' ],
						data : data,
						itemStyle : {
							emphasis : {
								shadowBlur : 10,
								shadowOffsetX : 0,
								shadowColor : 'rgba(0, 0, 0, 0.5)'
							}
						}
					} ]
				};
				var jslbBriefChart = echarts.init($("#jslbBrief")[0]);
				jslbBriefChart.setOption(option4);
			});
			//----------------------------------------------驾驶规律时间段初始化话
			$.post("${contextPath}/controller/diverRuleTime", {
				code : "allcode"
			}, function(result) {
				$("#diverRuleTime-ecCharLoading").hide();
				var data = [];
				var date = [];
				for (var i = 0; i < result.length; i++) {
					data.push(result[i]["number" + i]);
					date.push((i + 1) + "小时");

				}
				option5 = {
					tooltip : {
						trigger : 'axis',
						position : function(pt) {
							return [ pt[0], '10%' ];
						}
					},
					title : {
						left : 'center',
						text : '平均每天驾驶规律',
					},
					xAxis : {
						name : "时间",
						type : 'category',
						boundaryGap : false,
						data : date
					},
					yAxis : {
						name : "设备数(台)",
						type : 'value',
						boundaryGap : [ 0, '100%' ]
					},
					/* 		dataZoom: [{
								type: 'inside',
								start: 0,
								end: 100
							}, ], */
					series : [ {
						name : '在线台数',
						type : 'line',
						smooth : true,
						symbol : 'none',
						sampling : 'average',
						itemStyle : {
							normal : {
								color : 'rgb(255, 70, 131)'
							}
						},
						areaStyle : {
							normal : {
								color : new echarts.graphic.LinearGradient(0,
										0, 0, 1, [ {
											offset : 0,
											color : 'rgb(255, 158, 68)'
										}, {
											offset : 1,
											color : 'rgb(255, 70, 131)'
										} ])
							}
						},
						data : data
					} ]
				};

				var jsglsjdBriefChart = echarts.init($("#jsglsjdBrief")[0]);
				jsglsjdBriefChart.setOption(option5);
			});

			$('#jsxwpfModal').on('shown.bs.modal', function(e) {
				var myChart = echarts.init($("#jsxwpfDetails")[0]);
				myChart.setOption(option);

				$("#deviceBehaviour1-ecCharLoading").hide();

			});
			$('#dgjsxwfxModal').on('shown.bs.modal', function(e) {
				var myChart = echarts.init($("#dgjsxwfxDetails")[0]);
				myChart.setOption(option2);
				$("#singleDriverBeheaver-ecCharLoading1").hide();

			});
			$('#glhddyModal').on('shown.bs.modal', function(e) {
				var myChart = echarts.init($("#glhddyDetails")[0]);
				myChart.setOption(option3);
			});

			$('#jslbModal').on('shown.bs.modal', function(e) {
				var myChart = echarts.init($("#jslbDetails")[0]);
				myChart.setOption(option4);
				$("#divercategory-ecCharLoading11").hide();

			});

			$('#jsglsjdModal').on('shown.bs.modal', function(e) {
				var myChart = echarts.init($("#jsglsjdDetails")[0]);
				myChart.setOption(option5);
				$("#diverRuleTime-ecCharLoading1").hide();
			});

		});

		//----------------------------------------------------------用户列表时间选择；
		$(".userlist").click(
				function() {

					var model = $(this).text();
					var a = $(this).attr("value");

					$('.device-userlist-button1').html(
							model + "<span class=caret></span>");

					$('.device-userlist-button1').attr("value", a);
					var url = "${contextPath}/controller/userList?timeFlag1="
							+ a;
					$('#dataShow').bootstrapTable('refresh', {
						url : url
					});

				});

		//----------------------------------------------------------驾驶规律时间段地区选择

		$('#device-diverRuleTime')
				.change(
						function() {
							var code = $(this).children('option:selected')
									.val();
							$("#diverRuleTime-ecCharLoading1").show();
							$
									.post(
											"${contextPath}/controller/diverRuleTime",
											{
												code : code,
											},
											function(result) {
												$(
														"#diverRuleTime-ecCharLoading1")
														.hide();
												var data = [];
												var date = [];
												for (var i = 0; i < result.length; i++) {
													data
															.push(result[i]["number"
																	+ i]);
													date.push((i + 1) + "小时");

												}
												option5 = {
													tooltip : {
														trigger : 'axis',
														position : function(pt) {
															return [ pt[0],
																	'10%' ];
														}
													},
													title : {
														left : 'center',
														text : '平均每天驾驶规律',
													},
													xAxis : {
														name : "时间",
														type : 'category',
														boundaryGap : false,
														data : date
													},
													yAxis : {
														name : "设备数(台)",
														type : 'value',
														boundaryGap : [ 0,
																'100%' ]
													},
													series : [ {
														name : '在线台数',
														type : 'line',
														smooth : true,
														symbol : 'none',
														sampling : 'average',
														itemStyle : {
															normal : {
																color : 'rgb(255, 70, 131)'
															}
														},
														areaStyle : {
															normal : {
																color : new echarts.graphic.LinearGradient(
																		0,
																		0,
																		0,
																		1,
																		[
																				{
																					offset : 0,
																					color : 'rgb(255, 158, 68)'
																				},
																				{
																					offset : 1,
																					color : 'rgb(255, 70, 131)'
																				} ])
															}
														},
														data : data
													} ]
												};
												var myChart = echarts
														.init($("#jsglsjdDetails")[0]);
												myChart.setOption(option5);
											});
						});

		//-----------------------------------------------------------驾驶类别地区选择；
		$('#device-divercategory').change(function() {
			var code = $(this).children('option:selected').val();

			$("#divercategory-ecCharLoading11").show();

			$.post("${contextPath}/controller/divercategory", {
				code : code
			}, function(result) {
				$("#divercategory-ecCharLoading11").hide();
				var data = [];
				for (var i = 0; i < result.length; i++) {
					var jsonData1 = {
						"value" : result[i].number,
						"name" : result[i].diver
					};
					data[i] = jsonData1;
				}
				$("#divercategory-ecCharLoading").hide();
				//驾驶类别
				option4 = {
					tooltip : {
						trigger : 'item',
						formatter : "{a} <br/>{b} : {c} ({d}%)"
					},
					legend : {
						orient : 'vertical',
						left : 'left',
						data : [ '货车司机', '上班族', '出租司机', '其他' ]
					},
					series : [ {
						name : '设备数(台)',
						type : 'pie',
						radius : '55%',
						center : [ '50%', '60%' ],
						data : data,
						itemStyle : {
							emphasis : {
								shadowBlur : 10,
								shadowOffsetX : 0,
								shadowColor : 'rgba(0, 0, 0, 0.5)'
							}
						}
					} ]
				};
				var myChart = echarts.init($("#jslbDetails")[0]);
				myChart.setOption(option4);
			});
		});
		//----------------------------------单一的驾驶行地区选择；
		$('#device-singledriverbehaviour1').change(
				function() {
					var code = $(this).children('option:selected').val();
					var a = $('.device-singledriverbehaviour-button1').val();
					var behavior = $(".device-singledriverbehaviour").attr(
							"value");
					var behavior1 = $(".device-singledriverbehaviour").text();

					$("#singleDriverBeheaver-ecCharLoading1").show();
					$.post("${contextPath}/controller/singleDriveBehavior", {
						behavior : behavior,
						timeFlag : a,
						code : code,
					}, function(result) {
						$("#singleDriverBeheaver-ecCharLoading1").hide();
						$("#alluser2").html(result[0].sumImei);
						$("#variance2").html(result[0].variance);
						option2 = {
							tooltip : {
								trigger : 'axis'
							},
							xAxis : {
								name : behavior1,
								data : [ '0~50', '51~100', '101~150',
										'151~200', '201~250', '251~300',
										'301~500', '501~700', '701~900',
										'901~1000' ]
							},
							yAxis : {
								name : '设备数(台)',
							},
							series : [ {
								name : '设备数(台)',
								type : 'bar',
								data : [ result[0].number1, result[0].number2,
										result[0].number3, result[0].number4,
										result[0].number5, result[0].number6,
										result[0].number7, result[0].number8,
										result[0].number9, result[0].number10 ]
							} ]
						};
						var myChart = echarts.init($("#dgjsxwfxDetails")[0]);
						myChart.setOption(option2);
					});

				});

		//----------------------------------单一的驾驶行为时间查询
		$(".singledriverbehaviour")
				.click(
						function() {
							var model = $(this).text();
							var a = $(this).attr("value");
							var behavior = $(".device-singledriverbehaviour")
									.attr("value");
							var behavior1 = $(".device-singledriverbehaviour")
									.text();

							$('.device-singledriverbehaviour-button1').html(
									model + "<span class=caret></span>");
							$('.device-singledriverbehaviour-button1').attr(
									"value", a);

							//获取地区；
							var area = $(
									"#device-singledriverbehaviour1 option:selected")
									.val();
							$("#singleDriverBeheaver-ecCharLoading1").show();

							$
									.post(
											"${contextPath}/controller/singleDriveBehavior",
											{
												behavior : behavior,
												timeFlag : a,
												code : area,
											},
											function(result) {
												$(
														"#singleDriverBeheaver-ecCharLoading1")
														.hide();
												$("#alluser2").html(
														result[0].sumImei);
												$("#variance2").html(
														result[0].variance);
												option2 = {
													tooltip : {
														trigger : 'axis'
													},
													xAxis : {
														name : behavior1,
														data : [ '0~50',
																'51~100',
																'101~150',
																'151~200',
																'201~250',
																'251~300',
																'301~500',
																'501~700',
																'701~900',
																'901~1000' ]
													},
													yAxis : {
														name : '设备数(台)',
													},
													series : [ {
														name : '设备数(台)',
														type : 'bar',
														data : [
																result[0].number1,
																result[0].number2,
																result[0].number3,
																result[0].number4,
																result[0].number5,
																result[0].number6,
																result[0].number7,
																result[0].number8,
																result[0].number9,
																result[0].number10 ]
													} ]
												};

												var myChart = echarts
														.init($("#dgjsxwfxDetails")[0]);
												myChart.setOption(option2);
											});

						});

		//----------------------------------驾驶行为地区选择
		$('#device-driverbehaviour').change(
				function() {
					var behaviourArea = $(this).children('option:selected')
							.val();
					var a = $('.device-driverbehaviour-button1').val();
					$("#deviceBehaviour1-ecCharLoading").show();
					$.post("${contextPath}/controller/DriveBehaviorGrade", {
						timeFlag : a,
						code : behaviourArea
					}, function(result) {
						$("#deviceBehaviour1-ecCharLoading").hide();
						//驾驶行为评分
						$("#alluser").html(result[0].allUser)
						$("#grade").html(result[0].behaviorGrade);
						$("#variance").html(result[0].variance);
						option = {
							tooltip : {
								trigger : 'axis'
							},
							title : {},
							tooltip : {},
							legend : {

							},
							xAxis : {
								data : [ "0~10分", "11~20分", "21~30分", "31~40分",
										"41~50分", "51~60分", "61~70分", "71~80分",
										"81~90分", "91~100分" ]
							},
							yAxis : {
								name : '设备数(台)',
							},
							series : [ {
								name : '驾驶评分',
								type : 'bar',
								data : [ result[0].number1, result[0].number2,
										result[0].number3, result[0].number4,
										result[0].number5, result[0].number6,
										result[0].number7, result[0].number8,
										result[0].number9, result[0].number10 ]
							} ]
						};

						var myChart = echarts.init($("#jsxwpfDetails")[0]);
						myChart.setOption(option);
					})

				});

		//----------------------------------驾驶行为时间选择
		$(".driverbehaviour").click(
				function() {
					var model = $(this).text();
					var a = $(this).attr("value");
					$("#deviceBehaviour1-ecCharLoading").show();

					$('.device-driverbehaviour-button1').html(
							model + "<span class=caret></span>");
					$('.device-driverbehaviour-button1').attr("value", a);

					//获取地区分布；

					var behaviourArea = $(
							"#device-driverbehaviour option:selected").val();

					$.post("${contextPath}/controller/DriveBehaviorGrade", {
						timeFlag : a,
						code : behaviourArea
					}, function(result) {
						$("#deviceBehaviour1-ecCharLoading").hide();
						//驾驶行为评分
						$("#alluser").html(result[0].allUser)
						$("#grade").html(result[0].behaviorGrade);
						$("#variance").html(result[0].variance);
						option = {
							tooltip : {
								trigger : 'axis'
							},
							title : {},
							tooltip : {},
							legend : {

							},
							xAxis : {
								data : [ "0~10分", "11~20分", "21~30分", "31~40分",
										"41~50分", "51~60分", "61~70分", "71~80分",
										"81~90分", "91~100分" ]
							},
							yAxis : {
								name : '设备数(台)',
							},
							series : [ {
								name : '驾驶评分',
								type : 'bar',
								data : [ result[0].number1, result[0].number2,
										result[0].number3, result[0].number4,
										result[0].number5, result[0].number6,
										result[0].number7, result[0].number8,
										result[0].number9, result[0].number10 ]
							} ]
						};

						var myChart = echarts.init($("#jsxwpfDetails")[0]);
						myChart.setOption(option);
					})

				});

		//---------------------------------------------------单一驾驶行为的单一条件查询
		$(".singledriverbehaviour-presentation1").click(
				function() {
					$("#singleDriverBeheaver-ecCharLoading1").show();

					var model = $(this).text();
					var a = $(this).attr("value");
					var area = $(
							"#device-singledriverbehaviour1  option:selected")
							.val();
					var time = $(".device-singledriverbehaviour-button1").attr(
							"value");
					$('.device-singledriverbehaviour').html(
							model + "<span class=caret></span>");
					$('.device-singledriverbehaviour').attr("value", a);

					$.post("${contextPath}/controller/singleDriveBehavior", {
						behavior : a,
						timeFlag : time,
						code : area
					}, function(result) {
						$("#singleDriverBeheaver-ecCharLoading1").hide();
						$("#select-user").modal("hide");
						$("#alluser2").html(result[0].sumImei);
						$("#variance2").html(result[0].variance);
						option2 = {
							tooltip : {
								trigger : 'axis'
							},
							xAxis : {
								name : model,
								data : [ '1~50', '51~100', '101~150',
										'151~200', '201~250', '251~300',
										'301~500', '501~700', '701~900',
										'901~1000' ]
							},
							yAxis : {
								name : '设备数(台)',
							},
							series : [ {
								name : '设备数(台)',
								type : 'bar',
								data : [ result[0].number1, result[0].number2,
										result[0].number3, result[0].number4,
										result[0].number5, result[0].number6,
										result[0].number7, result[0].number8,
										result[0].number9, result[0].number10 ]
							} ]
						};
						var myChart = echarts.init($("#dgjsxwfxDetails")[0]);
						myChart.setOption(option2);

					});
				});

		$("#select-user").click(function() {
			$(this).find(".dropdown-menu").show();
		});
	</script>



</body>
</html>