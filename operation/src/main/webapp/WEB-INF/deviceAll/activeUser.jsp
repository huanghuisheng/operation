<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/basicPage/header.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>
<script type="text/javascript" src="${contextPath}/js/base.js"></script>
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
											<span>活跃用户概览</span>
										</div>
										<div class="data-box-content">
											<ul class="userinfo-data">
												<li class="usda-row">
													<div class="usda-cell head">今日活跃用户</div>
													<div class="usda-cell head">昨日活跃用户</div>
													<div class="usda-cell head">过去7天活跃用户</div>
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
													<div class="usda-cell">
														<p id="data4">789</p>
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
												<!-- <div class="wang41"></div> -->
												<div id="container2" style="height: 100%"></div>

											</div>

										</div>
									</div>

									<div class="data-box distribution">
									
	                             <jsp:include page="/WEB-INF/basicPage/distribution.jsp">
										<jsp:param name="title" value="运营后台" />
									</jsp:include>
	
	
										<div class="data-box-content">
											<div>
												<div class="area-left">

													<div id="container" style="height: 100%"></div>

												</div>
												<div class="area-right1">
													<div id="container1" style="height: 100%"></div>

												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%--  <script type="text/javascript" src="${contextPath}/js/huang.js"></script>
  <script type="text/javascript" src="${contextPath}/js/base.js"></script> --%>
<jsp:include page="/WEB-INF/basicPage/footer.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>
<script type="text/javascript">
	var myChart;
	var myChart1;
	var myChart2;
	var areaData;
	Date.prototype.diff = function(date) {
		return (this.getTime() - date.getTime()) / (24 * 60 * 60 * 1000);
	}
	$(function() {
		
		/* 初始化 */
			$("#dynamic-dialog").addClass("dialog");
		
		$("#loading").addClass("loading");
		
		$('.loading').shCircleLoader({
		    //options
		});
		
		
		
		
		
		
		$.getJSON("${contextPath}/controller/activeUser", function(data) {
			$("#data1").html("");//清空info内容
			$("#data1").html(data[0].uv_0);
			$("#data2").html("");//清空info内容
			$("#data2").html(data[0].uv_1);
			$("#data3").html("");//清空info内容
			$("#data3").html(data[0].uv7);
			$("#data4").html("");//清空info内容
			$("#data4").html(data[0].uv30);
		});
		$.getJSON("${contextPath}/controller/activeTendency", function(data) {

			/* 			var date = $('.headDate').text();
			 var strs = new Array(); //定义一数组
			 var strs1 = new Array(); //定义一数组
			 strs = date.split("-"); //字符分割    
			
			
			 // 构造两个日期，分别是系统时间和2013/04/08 12:43:45
			 var now = new Date(strs[1]);
			 var now1 = now;
			 var date = new Date(strs[0]);
			 // 调用日期差方法，求得参数日期与系统时间相差的天数
			 var diff = now.diff(date);
			 // 打印日期差	
			
			 for (var i = diff; i >= 0; i--) {
			 var year = now1.getFullYear();
			 var month = now1.getMonth() + 1; //js从0开始取 
			 var date = now1.getDate();
			 strs1[i] = year + "-" + month + "-" + date;
			 now1.setDate(now1.getDate() - 1);
			 } */
			var strs1 = BaseUtility.InitDate();

			var dom2 = document.getElementById("container2");
			myChart2 = echarts.init(dom2);

			var app2 = {};
			option2 = null;
			option2 = {
				title : {
					text : '活跃用户整体趋势'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '活跃用户' ]
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
					name : '活跃用户量',
					type : 'line',
					stack : '总量',
					data : [ data[0].nv_6, data[0].nv_5, data[0].nv_4,
							data[0].nv_3, data[0].nv_2, data[0].nv_1,
							data[0].nv_0 ]
				} ]
			};
			;
			if (option2 && typeof option2 === "object") {
				myChart2.setOption(option2, true);
			}
		});

		//---------------------------------------------------------------------------扇形；	
		var date1 = $('.headDate1').text();
		var strs2 = new Array(); //定义一数组
		strs2 = date1.split("-"); //字符分割 

		$.getJSON("${contextPath}/controller/activeAreaDistribution", {
			starttime : "00.00.00",
			endtime : strs2[1],
		}, function(data) {
			areaData = data;
			var dom1 = document.getElementById("container1");
			myChart1 = echarts.init(dom1);
			var app1 = {};
			var hh = "sssss";
			option1 = null;
			option1 = {
				color : [ '#ba55d3', '#ffa500', '#40e0d0', '#ff6347',
						'#7b68ee', '#00fa9a', '#ffd700', '#6b8e23', '#ff00ff',
						'#b8860b', '#30e0e0' ],
			
				tooltip : {
					trigger : 'item',
					formatter : "{a} <br/>{b} : {c} ({d}%)"
				},
				legend : {
					orient : 'horizontal',
					left : 'top',
					data : [ data[0].city, data[1].city, data[2].city,
							data[3].city, data[4].city, data[5].city,
							data[6].city, data[7].city, data[8].city,
							data[9].city ]
				},
				series : [ {

					type : 'pie',
					radius : '55%',
					center : [ '50%', '60%' ],
					data : [ {
						value : data[0].number,
						name : data[0].city
					}, {
						value : data[1].number,
						name : data[1].city
					}, {
						value : data[2].number,
						name : data[2].city
					}, {
						value : data[3].number,
						name : data[3].city
					}, {
						value : data[4].number,
						name : data[4].city
					}, {
						value : data[5].number,
						name : data[5].city
					}, {
						value : data[6].number,
						name : data[6].city
					}, {
						value : data[7].number,
						name : data[7].city
					}, {
						value : data[8].number,
						name : data[8].city
					}, {
						value : data[9].number,
						name : data[9].city
					}, {
						value : data[10].number,
						name : data[10].city
					}, {
						value : data[11].number,
						name : data[11].city
					}, {
						value : data[12].number,
						name : data[12].city
					}, {
						value : data[13].number,
						name : data[13].city
					}, {
						value : data[14].number,
						name : data[14].city
					}, {
						value : data[15].number,
						name : data[15].city
					}, {
						value : data[16].number,
						name : data[16].city
					}, {
						value : data[17].number,
						name : data[17].city
					}, {
						value : data[18].number,
						name : data[18].city
					}, {
						value : data[19].number,
						name : data[19].city
					}, {
						value : data[20].number,
						name : data[20].city
					}, {
						value : data[21].number,
						name : data[21].city
					}, {
						value : data[22].number,
						name : data[22].city
					}, {
						value : data[23].number,
						name : data[23].city
					}, {
						value : data[24].number,
						name : data[24].city
					}, {
						value : data[25].number,
						name : data[25].city
					}, {
						value : data[26].number,
						name : data[26].city
					}, {
						value : data[27].number,
						name : data[27].city
					}, {
						value : data[28].number,
						name : data[28].city
					}, {
						value : data[29].number,
						name : data[29].city
					}, {
						value : data[30].number,
						name : data[30].city
					}, {
						value : data[31].number,
						name : data[31].city
					}, {
						value : data[32].number,
						name : data[32].city
					}, {
						value : data[33].number,
						name : data[33].city
					}, ],
					itemStyle : {
						emphasis : {
							shadowBlur : 10,
							shadowOffsetX : 0,
							shadowColor : 'rgba(0, 0, 0, 0.5)'
						}
					}
				} ]
			};
			;
			if (option1 && typeof option1 === "object") {
				myChart1.setOption(option1, true);
			}
			//-----------------------------------------------------------地图;
			var dom = document.getElementById("container");
			myChart = echarts.init(dom);
			var app = {};
			option = null;

			option = {
				title : {
					text : '活跃用户',
					left : 'center'
				},
				tooltip : {
					trigger : 'item'
				},
				legend : {
					orient : 'horizontal',
					left : 'left',
					data : [ '活跃用户' ]
				},
				visualMap : {
					min : 0,
					max : 50,
					/* left : 'left',
					top : 'bottom', */
					text : [ '高', '低' ], // 文本，默认为数值文本
					calculable : true,
					inRange : {
						color : [ '#ffffff', '#9baefb', '#5777f9', '#0937f2' ]
					},
					textStyle : {
						color : '#000000'
					}
				},
				series : [ {
					name : '活跃用户',
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
					data : [ {
						name : areaData[0].city,
						value : areaData[0].number
					}, {
						name : areaData[1].city,
						value : areaData[1].number
					}, {
						name : areaData[2].city,
						value : areaData[2].number
					}, {
						name : areaData[3].city,
						value : areaData[3].number
					}, {
						name : areaData[4].city,
						value : areaData[4].number
					}, {
						name : areaData[5].city,
						value : areaData[5].number
					}, {
						name : areaData[6].city,
						value : areaData[6].number
					}, {
						name : areaData[7].city,
						value : areaData[7].number
					}, {
						name : areaData[8].city,
						value : areaData[8].number
					}, {
						name : areaData[9].city,
						value : areaData[9].number
					}, {
						name : areaData[10].city,
						value : areaData[10].number
					}, {
						name : areaData[11].city,
						value : areaData[11].number
					}, {
						name : areaData[12].city,
						value : areaData[12].number
					}, {
						name : areaData[13].city,
						value : areaData[13].number
					}, {
						name : areaData[14].city,
						value : areaData[14].number
					}, {
						name : areaData[15].city,
						value : areaData[15].number
					}, {
						name : areaData[16].city,
						value : areaData[16].number
					}, {
						name : areaData[17].city,
						value : areaData[17].number
					}, {
						name : areaData[18].city,
						value : areaData[18].number
					}, {
						name : areaData[19].city,
						value : areaData[19].number
					}, {
						name : areaData[20].city,
						value : areaData[20].number
					}, {
						name : areaData[21].city,
						value : areaData[21].number
					}, {
						name : areaData[22].city,
						value : areaData[22].number
					}, {
						name : areaData[23].city,
						value : areaData[23].number
					}, {
						name : areaData[24].city,
						value : areaData[24].number
					}, {
						name : areaData[25].city,
						value : areaData[25].number
					}, {
						name : areaData[26].city,
						value : areaData[26].number
					}, {
						name : areaData[27].city,
						value : areaData[27].number
					}, {
						name : areaData[28].city,
						value : areaData[28].number
					}, {
						name : areaData[29].city,
						value : areaData[29].number
					}, {
						name : areaData[30].city,
						value : areaData[30].number
					}, {
						name : areaData[31].city,
						value : areaData[31].number
					}, {
						name : areaData[32].city,
						value : areaData[32].number
					}, {
						name : areaData[33].city,
						value : areaData[33].number
					}, ]

				} ]
			};

			if (option && typeof option === "object") {
				myChart.setOption(option, true);
			}
		});
		
		 $("#dynamic-dialog").removeClass("dialog");
			
	       $("#loading").removeClass("loading");
	       
	       $('#loading').shCircleLoader('destroy');	
		
		
	});
	setTimeout(function() {
		window.onresize = function() {
			myChart.resize();
			myChart1.resize();
			myChart2.resize();
		}
	}, 200)

	//----------------------------------------------------------------------------------动态地图数据刷新；
	$(".basedistribution").bind(
			'click',
			function() {
				/* 初始化 */
				$("#dynamic-dialog").addClass("dialog");
				
				$("#loading").addClass("loading");
				
				$(".loading").shCircleLoader({
				    //options
				});
				
				//日期
				var date = $('.headDate1').text();
				var strs = new Array(); //定义一数组
				strs = date.split("-"); //字符分割     

				if (strs[0] == "截止到") {
					strs[0] = "00.00.00";
				}
				//发送请求；
				$.post("${contextPath}/controller/activeAreaDistribution", {
					starttime : strs[0],
					endtime : strs[1],
				}, function(result) {
					myChart.setOption({
						tooltip : {
							trigger : 'item'
						},
						legend : {
							orient : 'horizontal',
							left : 'top',
						/* data : [ '新增用户' ] */
						},
						visualMap : {
							min : 0,
							max : 50,
							orient : 'horizontal',
							top : 'top',
							left : 'center',
							text : [ '高', '低' ], // 文本，默认为数值文本
							calculable : true,
							inRange : {
								color : [ '#ffffff', '#9baefb', '#5777f9',
										'#0937f2' ]
							},
							textStyle : {
								color : '#000000'
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
							data : [ {
								name : result[0].city,
								value : result[0].number
							}, {
								name : result[1].city,
								value : result[1].number
							}, {
								name : result[2].city,
								value : result[2].number
							}, {
								name : result[3].city,
								value : result[3].number
							}, {
								name : result[4].city,
								value : result[4].number
							}, {
								name : result[5].city,
								value : result[5].number
							}, {
								name : result[6].city,
								value : result[6].number
							}, {
								name : result[7].city,
								value : result[7].number
							}, {
								name : result[8].city,
								value : result[8].number
							}, {
								name : result[9].city,
								value : result[9].number
							}, {
								name : result[10].city,
								value : result[10].number
							}, {
								name : result[11].city,
								value : result[11].number
							}, {
								name : result[12].city,
								value : result[12].number
							}, {
								name : result[13].city,
								value : result[13].number
							}, {
								name : result[14].city,
								value : result[14].number
							}, {
								name : result[15].city,
								value : result[15].number
							}, {
								name : result[16].city,
								value : result[16].number
							}, {
								name : result[17].city,
								value : result[17].number
							}, {
								name : result[18].city,
								value : result[18].number
							}, {
								name : result[19].city,
								value : result[19].number
							}, {
								name : result[20].city,
								value : result[20].number
							}, {
								name : result[21].city,
								value : result[21].number
							}, {
								name : result[22].city,
								value : result[22].number
							}, {
								name : result[23].city,
								value : result[23].number
							}, {
								name : result[24].city,
								value : result[24].number
							}, {
								name : result[25].city,
								value : result[25].number
							}, {
								name : result[26].city,
								value : result[26].number
							}, {
								name : result[27].city,
								value : result[27].number
							}, {
								name : result[28].city,
								value : result[28].number
							}, {
								name : result[29].city,
								value : result[29].number
							}, {
								name : result[30].city,
								value : result[30].number
							}, {
								name : result[31].city,
								value : result[31].number
							}, {
								name : result[32].city,
								value : result[32].number
							}, {
								name : result[33].city,
								value : result[33].number
							},

							]
						} ]
					});

					//------------------------------------------------------扇形图动态刷新

					myChart1.setOption({

						color : [ '#ba55d3', '#ffa500', '#40e0d0', '#ff6347',
								'#7b68ee', '#00fa9a', '#ffd700', '#6b8e23',
								'#ff00ff', '#b8860b', '#30e0e0' ],
						tooltip : {
							trigger : 'item',
							formatter : "{a} <br/>{b} : {c} ({d}%)"
						},
						legend : {
							orient : 'horizontal',
							left : 'top',
							data : [ result[0].city, result[1].city,
									result[2].city, result[3].city,
									result[4].city, result[5].city,
									result[6].city, result[7].city,
									result[8].city, ]
						},
						series : [ {
							type : 'pie',
							radius : '55%',
							center : [ '50%', '60%' ],
							data : [ {
								value : result[0].number,
								name : result[0].city
							}, {
								value : result[1].number,
								name : result[1].city
							}, {
								value : result[2].number,
								name : result[2].city
							}, {
								value : result[3].number,
								name : result[3].city
							}, {
								value : result[4].number,
								name : result[4].city
							}, {
								value : result[5].number,
								name : result[5].city
							}, {
								value : result[6].number,
								name : result[6].city
							}, {
								value : result[7].number,
								name : result[7].city
							}, {
								value : result[8].number,
								name : result[8].city
							}, {
								value : result[9].number,
								name : result[9].city
							}, {
								value : result[10].number,
								name : result[10].city
							}, {
								value : result[11].number,
								name : result[11].city
							}, {
								value : result[12].number,
								name : result[12].city
							}, {
								value : result[13].number,
								name : result[13].city
							}, {
								value : result[14].number,
								name : result[14].city
							}, {
								value : result[15].number,
								name : result[15].city
							}, {
								value : result[16].number,
								name : result[16].city
							}, {
								value : result[17].number,
								name : result[17].city
							}, {
								value : result[18].number,
								name : result[18].city
							}, {
								value : result[19].number,
								name : result[19].city
							}, {
								value : result[20].number,
								name : result[20].city
							}, {
								value : result[21].number,
								name : result[21].city
							}, {
								value : result[22].number,
								name : result[22].city
							}, {
								value : result[23].number,
								name : result[23].city
							}, {
								value : result[24].number,
								name : result[24].city
							}, {
								value : result[25].number,
								name : result[25].city
							}, {
								value : result[26].number,
								name : result[26].city
							}, {
								value : result[27].number,
								name : result[27].city
							}, {
								value : result[28].number,
								name : result[28].city
							}, {
								value : result[29].number,
								name : result[29].city
							}, {
								value : result[30].number,
								name : result[30].city
							}, {
								value : result[31].number,
								name : result[31].city
							}, {
								value : result[32].number,
								name : result[32].city
							}, {
								value : result[33].number,
								name : result[33].city
							}, ],
							itemStyle : {
								emphasis : {
									shadowBlur : 10,
									shadowOffsetX : 0,
									shadowColor : 'rgba(0, 0, 0, 0.5)'
								}
							}
						} ]
					});
				});
				
				<!-- 初始化结束 -->	
				 $("#dynamic-dialog").removeClass("dialog");
				
			       $("#loading").removeClass("loading");
			       
			       $('#loading').shCircleLoader('destroy');	
				
			});

	//--------------------------------------------------------------------------------------------动态表格；

	$(".tendency_model").bind('click', function() {
	$("#dynamic-dialog").addClass("dialog");
		
		$("#loading").addClass("loading");
		
		$('.loading').shCircleLoader({
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
		$.post("${contextPath}/controller/activeTendency1", {
			starttime : strs[0],
			endtime : strs[1],
			regoin : area,
			model : model
		}, function(result) {
			var length = result.length;
			var strs2 = new Array();
			for (var i = length - 1; i >= 0; i--) {
				strs2[i] = result[i]["number"];
			}
			strs2.reverse();

			myChart2.setOption({
				title : {
					text : '活跃用户整体趋势'
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : [ '活跃用户' ]
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
					name : '活跃用户量',
					type : 'line',
					stack : '总量',
					data : strs2
				} ]
			});

		});
		
		<!-- 初始化结束 -->	
		 $("#dynamic-dialog").removeClass("dialog");
		
	       $("#loading").removeClass("loading");
	       
	       $('#loading').shCircleLoader('destroy');	
		

	});
</script>








