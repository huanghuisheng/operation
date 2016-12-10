<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
 <jsp:include page="/WEB-INF/basicPage/header.jsp">
             <jsp:param name="title" value="运营后台"/> 
 </jsp:include>
</head>
<body class="animated-content">

	<div class="extrabar-underlay"></div>

	<jsp:include page="/WEB-INF/basicPage/basic.jsp">
		<jsp:param name="title" value="运营后台" />
	</jsp:include>

	<div id="wrapper">
		<div id="layout-static">
          <jsp:include page="/WEB-INF/basicPage/basic1.jsp">
				<jsp:param name="title" value="运营后台" />
			</jsp:include>

			<div class="static-content-wrapper">
				<div class="static-content">
					<div class="page-content">
						<div class="container-fluid">
							<div class="wrapper">
								<div class="main">
									<div class="data-box cumulative">
										<div class="data-box-title">
											<span>累计用户概览</span>
										</div>
										<div class="data-box-content">
											<ul class="userinfo-data">
												<li class="usda-row">
													<div class="usda-cell head">截止到今天</div>
													<div class="usda-cell head">截止到上个月</div>
													<div class="usda-cell head">截止到上个季度</div>
													<div class="usda-cell head">截止到去年</div>
												</li>
												<li class="usda-row">
													<div class="usda-cell">
														<p id="data1"></p>
													</div>
													<div class="usda-cell">
														<p id="data2"></p>
													</div>
													<div class="usda-cell">
														<p id="data3"></p>
													</div>
													<div class="usda-cell">
														<p id="data4"></p>
													</div>
												</li>
											</ul>
										</div>
									</div>
									<div class="data-box trend">
	
							        <jsp:include page="/WEB-INF/basicPage/tendency.jsp">
										<jsp:param name="title" value="运营后台" />
									</jsp:include>
	
										<div class="data-box-content">
											<div class="wang4">

												<div id="container2" class="acontainer2"></div>
											</div>
										</div>


									</div>
								</div>
							</div>
							<!-- .container-fluid -->
						</div>
						<!-- #page-content -->
					</div>

				</div>
			</div>
		</div>
</body>
</html>
  <jsp:include page="/WEB-INF/basicPage/footer.jsp">
             <jsp:param name="title" value="运营后台"/> 
 </jsp:include> 

 
 
<script type="text/javascript">
	var myChart;
	Date.prototype.diff = function(date) {
		return (this.getTime() - date.getTime()) / (24 * 60 * 60 * 1000);
	}
	$(function() {

		$("#dynamic-dialog").addClass("dialog");
			
			$("#loading").addClass("loading");
			
			$(".loading").shCircleLoader({
			    //options
			});
			
		
		$.getJSON("${contextPath}/controller/accumulativeUser", function(data) {
			$("#data1").html("");//清空info内容
			$("#data1").html(data[0].total0);

			$("#data2").html("");//清空info内容
			$("#data2").html(data[0].total1);

			$("#data3").html("");//清空info内容
			$("#data3").html(data[0].total3);
			$("#data4").html("");//清空info内容
			$("#data4").html(data[0].total12);
		});

		
	var strs1=BaseUtility.InitDate();
		


			$.post("${contextPath}/controller/accumulativeTendency", {
				starttime : "",
				endtime : "",
			}, function(data) {

			var dom = document.getElementById("container2");
			myChart = echarts.init(dom);
			var app = {};
			option = null;
			option = {
				title : {
					text : '累计用户整体趋势'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '累计用户' ]
				},
				grid : {
					left : '3%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				xAxis : {
					type : 'category',
					boundaryGap : false,
					data : strs1,
				},
				yAxis : {
					type : 'value'
				},
				series : [
						{
							name : '累计用户量',
							type : 'line',
							stack : '总量',
							// data:[120, 132, 101, 134, 90, 230, 210] 
							data : [ data[0].total_6, data[0].total_5,
									data[0].total_4, data[0].total_3,
									data[0].total_2, data[0].total_1,
									data[0].total_0 ]
						}, ]
			};
			if (option && typeof option === "object") {
				myChart.setOption(option, true);
			}
			window.onresize = myChart.resize;
		});
			
		/* 初始化结束 */	
			 $("#dynamic-dialog").removeClass("dialog");
				
		       $("#loading").removeClass("loading");
		       
		       $('#loading').shCircleLoader('destroy');	
	
			
			
			
			
			
	});

	//--------------------------------------------------------------------累计查询

	
	$(".tendency_model").bind('click', function() {
		/* 初始化 */
		$("#dynamic-dialog").addClass("dialog");
		
		$("#loading").addClass("loading");
		
		$(".loading").shCircleLoader({
		    //options
		});

		//地址
		var area = $('.model6').attr("value");
		//型号
		var model = $('.model1').attr("value");
		//日期
		var date = $('.headDate').text();
		var strs = new Array(); //定义一数组
		var strs1 = new Array(); //定义一数组
		strs = date.split("-"); //字符分割     
		// 构造两个日期，分别是系统时间和2013/04/08 12:43:45
		
	/* 	var now= new Date(Date.parse(strs[1].replace(/-/g,  "/"))); */ 
		var now = new Date(strs[1]);
		var now1 = now;
		var date = new Date(strs[0]);
		// 调用日期差方法，求得参数日期与系统时间相差的天数
		var diff = now.diff(date);
	
		/*  diff=diff+1; */
		// 打印日期差			    
		for (var i = diff; i >= 0; i--) {
			var year = now1.getFullYear();
			var month = now1.getMonth() + 1; //js从0开始取 
			var date = now1.getDate();
			strs1[i] = year + "-" + month + "-" + date;
			now1.setDate(now1.getDate() - 1);
		}
		//发送请求；
		$.post("${contextPath}/controller/accumulativeTendency1", {
			starttime : strs[0],
			endtime : strs[1],
			regoin:area,
		    model:model
		}, function(result) {
			var length = result.length;
			var strs2 = new Array();
			for (var i = length - 1; i >= 0; i--) {
				strs2[i] = result[i]["number"];
			}
			strs2.reverse();

			myChart.setOption({
				title : {
					text : '累计用户整体趋势'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '累计用户' ]
				},
				grid : {
					left : '3%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				xAxis : {
					type : 'category',
					boundaryGap : false,
					data : strs1
				},
				yAxis : {
					type : 'value'
				},
				series : [ {
					name : '累计用户量',
					type : 'line',
					stack : '总量',
					data : strs2
				} ]
			});
			
			<!-- 初始化结束  -->	
			 $("#dynamic-dialog").removeClass("dialog");
			
		       $("#loading").removeClass("loading");
		       
		       $('#loading').shCircleLoader('destroy');	

		});	
	});	
	//------------------------------------------
</script>
