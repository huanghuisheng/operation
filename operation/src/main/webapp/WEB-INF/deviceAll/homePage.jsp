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
<script src="${contextPath}/js/jquery.shCircleLoader.js"></script>
<script src="${contextPath}/js/china.js"></script>
<link
	href="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.css"
	rel="stylesheet" />
<script
	src="http://cdn.bootcss.com/bootstrap-table/1.9.1/bootstrap-table.min.js"></script>
<script
	src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>
<!-- 百度地图 -->
<style type="text/css">
#allmap {
	margin-left: auto;
	margin-right: auto;
	text-align: center;
	width: 100%;
	height: 100%;
	border: solid 1px gray
}
</style>
<jsp:include page="/WEB-INF/basicPage/header.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>
</head>

<body class="animated-content">
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







	<div id="wrapper">
		<div id="layout-static">
			<div class="static-content-wrapper">
				<div class="static-content">
					<div class="page-content">
						<div class="container-fluid">
							<div class="wrapper">
								<div class="main">
									<div class="data-box key-indicator">
										<div class="data-box-title">
											<span>关键指标</span>
										</div>
										<div class="data-box-content">
											<ul class="userinfo-data">
												<li class="usda-row">
													<div class="usda-cell head">累计用户</div>
													<div class="usda-cell head">今日新增用户</div>
													<div class="usda-cell head">过去30天活跃用户</div>
												</li>
												<li class="usda-row">
													<div class="usda-cell">
														<p id="data1">123</p>
													</div>
													<div class="usda-cell">
														<p id="data2">999999</p>
													</div>
													<div class="usda-cell">
														<p id="data3">789</p>
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="homeMap">
								<div id="allmap"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



</body>
</html>
<script type="text/javascript">

	$(function() {
		
		$.getJSON("${contextPath}/controller/homepageUser", function(data) {
			$("#data1").html("");//清空info内容
			$("#data1").html(data[0].total0);

			$("#data2").html("");//清空info内容
			$("#data2").html(data[0].newUser0);

			$("#data3").html("");//清空info内容
			$("#data3").html(data[0].uv30);
		});
	});
	
	
	
	
	// 百度地图API功能
	var map = new BMap.Map("allmap"); // 创建Map实例
/* 	map.centerAndZoom("西安", 5); // 初始化地图,设置中心点坐标和地图级别
	//添加地图类型控件
	map.setCurrentCity("西安"); // 设置地图显示的城市 此项是必须设置的 */
	 map.centerAndZoom(new BMap.Point(108.948024,34.263161), 5);
	
	map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
	var markers = [];
	
	
	$.post("${contextPath}/controller/homeMap", function(result) {
		var length = result.length;
		var strs2 = new Array();
		for (var i = length - 1; i >= 0; i--) {
			var pt = new BMap.Point(result[i].lng, result[i].lat);
			var marker = new BMap.Marker(pt);
			marker.imei = result[i].imei;
			marker.model = result[i].model;
			marker.buildtime = result[i].buildtime;
			markers.push(marker);
		}
		for (var j = 0; j < markers.length; j++) {
			(function() {
				var index = j;
				markers[j].addEventListener('mouseover', function() {

					var sContent = "<div>" + "IMEI号："
							+ "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"
							+ this.imei + "</h4>" + "设备型号："
							+ "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"
							+ this.model + "</h4>" + "设备版本:"
							+ "<h4 style='margin:0 0 5px 0;padding:0.2em 0'>"
							+ this.buildtime + "</h4>" + "</div>";
					this.openInfoWindow(new BMap.InfoWindow(sContent));

				});

				markers[j].addEventListener("click", showInfo);
				function showInfo(e) {
					<%-- window.location.href = '<%=request.getAttribute("contextPath1")%>'+"user.jsp?imei=" + this.imei
							+ "&model=" + this.model + "&buildtime="
							+ this.buildtime; --%>
					var userhref='<%=request.getAttribute("contextPath1")%>';	
					BaseUtility.homePagePost(userhref+"user.jsp" , {imei :this.imei,model:this.model,buildtime:this.buildtime});  
					
					
				}
			})();
		}
		//最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
		var markerClusterer = new BMapLib.MarkerClusterer(map, {
			markers : markers
		});
		
		
 

	});
	
	
</script>


