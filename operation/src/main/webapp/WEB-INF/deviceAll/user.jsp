<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
	<%@page import="java.util.Date"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="/WEB-INF/basicPage/header.jsp">
	<jsp:param name="title" value="运营后台" />
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
		 					<div class="user-datainfo clearfix">
									<div class="device-info">
										<div>
											<label>IMEI号：</label>
											<p class="user_imei">78655454455556</p>
										</div>
										<div>
											<label>设备型号：</label>
											<p class="user_model">patron</p>
										</div>
										<div>
											<label>设备版本：</label>
											<p class="user_buildtime">v 1.2.6</p>
										</div>
										<div>
											<p>其他信息：如车型、行驶里程、行驶时间、总耗油、平均耗油等</p>
										</div>
									</div>
								</div>  

								<div class="data-box historypaths">
									<div class="data-box-title">
										<span>历史轨迹</span>
									</div>
									<div class="data-box-content"></div>
								</div>
								<div class="homeMap1">
									<!--   <div id="allmap"></div>  -->
								</div>
								<div class="user_month">
									<ul class="pagination">
										<li class="user_month1" id="user_month01"><a href="#">1月</a></li>
										<li class="user_month1" id="user_month02"><a href="#">2月</a></li>
										<li class="user_month1" id="user_month03"><a href="#">3月</a></li>
										<li class="user_month1" id="user_month04"><a href="#">4月</a></li>
										<li class="user_month1" id="user_month05"><a href="#">5月</a></li>
										<li class="user_month1" id="user_month06"><a href="#">6月</a></li>
										<li class="user_month1" id="user_month07"><a href="#">7月</a></li>
										<li class="user_month1" id="user_month08"><a href="#">8月</a></li>
										<li class="user_month1" id="user_month09"><a href="#">9月</a></li>
										<li class="user_month1" id="user_month10"><a href="#">10月</a></li>
										<li class="user_month1" id="user_month11"><a href="#">11月</a></li>
										<li class="user_month1" id="user_month12"><a href="#">12月</a></li>


										<li><select name="user_year" id="user_year">
												<option value="volvo">2016</option>
												<option value="volvo">2015</option>
												<option value="volvo">2014</option>
										</select></li>

										<!-- <li><a href="#"> <select name="user_year" id="user_year">
													<option value="volvo">2016</option>
													<option value="volvo">2015</option>
													<option value="volvo">2014</option>
											</select>
										</a></li> -->






									</ul>
								</div>
								<div>
									<input type="hidden" id="user_track" value="轨迹">
								</div>
								<!-- 从首页传过来的参数 -->
								<div>
									<input type="hidden" id="user_track_imei"
										value=<%=request.getParameter("imei")%>> <input
										type="hidden" id="user_track_model"
										value=<%=request.getParameter("model")%>> <input
										type="hidden" id="user_track_buildtime"
										value=<%=request.getParameter("buildtime")%>>
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
	var imei, model, buildtime;
	imei ='<%=request.getParameter("imei")%>' ;
	model = '<%=request.getParameter("model")%>';
	buildtime='<%=request.getParameter("buildtime")%>';
	

	$('.user_imei').html(imei);
	$('.user_model').html(model);
	$('.user_buildtime').html(buildtime);
	
	//-------------------------------------------------------------------------------------------动态生成路程缩略图；
	var hello = 'hello';
	var trackData = 'hello';

	/* 时间格式 */
       
	  //获取路径时间；测试中减少一个月；
	    var now = new Date();
	    var year = now.getFullYear();
	    var month =(now.getMonth()).toString();   
	    var day = (now.getDate()).toString();
	    if (month.length == 1) {
	        month = "0" + month;
	    }
	    if (day.length == 1) {
	        day = "0" + day;
	    }
	    var travel1 = year +"-"+ month;
	    var travel2 = year +"-"+ month;
	    

	     $("#user_month"+month).addClass("user_month3"); 
	    
	    
	    
	  
	    /* 初始化 */
	   $("#dynamic-dialog").addClass("dialog");
		
		$("#loading").addClass("loading");
		
		$('.loading').shCircleLoader({
		    //options
		});
	    
	    
		
		
		
	      $.post("${contextPath}/controller/track",
					{
						strartTime :travel1,
						endTime : travel2,
						imei : imei,
						model : model,
					},
					function(data) {
						if(data.length<1)
						{
						alert("没有数据,请选择其他月份");
						}
						trackData=data;
						
						
						for (var k = 0; k < data.length; k++) {
							/* 		  $(".homeMap1").prepend("<div id=user_map"+k+"></div>"); */
							
							$(".homeMap1").prepend("<div"+" "+"id=usermap"+k+"></div>");				
							$(".homeMap1").children("div").addClass("allmap1");
							var data1 = data[k];
							 //显示时间;
							 
							 var trackTime1=data1[0].datatime;
							 var trackTime2=data1[data1.length-1].datatime;
				
							 trackTime1= BaseUtility.longConvertDate(trackTime1);
	 
							 trackTime2=BaseUtility.longConvertDate(trackTime2);
							 
							 $("#usermap"+k)
								.prepend("<label"+" "+"id=maplabell"+k+">"+"到 "+" "+trackTime2+"</label>");
							 $("#usermap"+k)
								.prepend("<label"+" "+"id=maplabel"+k+">日期:"+" "+trackTime1+"</label>");
							 
							 $("#usermap"+k).children("label").addClass("maplabel");
							 
							 
								$("#usermap"+k)
								.prepend("<img"+" "+"id="+k+"></img>");
							 
							 
							 
							//起点
							var pt11;
							if (data1[0].type == 1)
								pt11 = wgs2bd(data1[0].lat, data1[0].lng);
							else {
								pt11 = gcj2bd(data1[0].lat, data1[0].lng);
							}
                            
							 var center1;
							 if((data1.length%2)==0)
							 {
								 center1=data1.length/2;
							 }else{
								 
								 center1=(data1.length+1)/2;
							 }						
							
							 var center;
							 if (data1[center1].type == 1)
								   center = wgs2bd(data1[center1].lat, data1[center1].lng);
								else {
								   center = gcj2bd(data1[center1].lat, data1[center1].lng);
								}
	
							var length = data1.length;
							var pt1 = new BMap.Point(pt11.lng, pt11.lat);

							var paths = null;

							var point = [];
							for (var i = 1; i < data1.length-1; i++) {
								var pt00 = null;
								if (data1[i].type == 1)
									pt00 = wgs2bd(data1[i].lat,
											data1[i].lng);
								else {
									pt00 = gcj2bd(data1[i].lat,
											data1[i].lng);
								}
								point.push(new BMap.Point(pt00.lng, pt00.lat));
								paths = paths + pt00.lng + "," + pt00.lat + ";"
							}
							//终点：
							var pt12;
							if (data1[data1.length - 1].type == 1)
								pt12 = wgs2bd(data1[length - 1].lat,
										data1[data1.length - 1].lng);
							else {
								pt12 = gcj2bd(data1[length - 1].lat,
										data1[data1.length - 1].lng);
							}
							var src = "http://api.map.baidu.com/staticimage?width=260&height=220&center="
									+ center.lng
									+ ","
									+ center.lat
									+ "&zoom=16&paths="
									+ paths
									+ "&pathStyles=0x0000ff,3,1"
									+ "&markerStyles=-1,http://api.map.baidu.com/images/marker_red.png,-1,23,25"
									+ "&markers="
									+ pt11.lng
									+ ","
									+ pt11.lat
									+ "|"
									+ pt12.lng
									+ ","
									+ pt12.lat;
							$("#" + k).attr("src", src);
							$("#" + k).bind('click', function() {
								var usertrack="${contextPath1}";	
								alert(usertrack);
								  var imgid = $(this).attr("id");
								hello =imgid;
			                     layer.open({
			                    	 type:2,
			                    	 icon:1,
			                    	 title:"用户行车轨迹",
			                    	 maxmin:true,
			                    	 shadeClose:true,
			                    	 shade:0.5,
			                    	 closeBtn:1,
			                    	 area:["70%","70%"],
			                    	 content:usertrack+"track.jsp"	                    	 
			                     });
							});			
						}
						/* 初始化结束 */
						 $("#dynamic-dialog").removeClass("dialog");
							
					       $("#loading").removeClass("loading");
					       
					       $('#loading').shCircleLoader('destroy');	
						
					});
	      
	      
	      
//-----------------------------------------------------------------------选择时间显示轨迹
	      
$(".user_month1").bind('click', function() {

	 <!-- 初始化 -->

		$("#dynamic-dialog").addClass("dialog");
			
			$("#loading").addClass("loading");
			
			$('.loading').shCircleLoader({
			    //options
			});	
	
$(".user_month1").removeClass("user_month3");
						
var month0 = $(this).text();
	
var year = $("#user_year option:selected").text();
var month=null;
if(month0.length>2)
	{
	  month= month0.substring(0,2);
	
	}else{
		
		month= month0.substring(0,1);
		  month="0"+month;
	}

var yearmonth=year+"-"+month;
$.post(
		"${contextPath}/controller/track",
		{
			strartTime :yearmonth,
			endTime : yearmonth,
			imei : imei,
			model : model,
		},
		function(data) {
			trackData=data;
			if(data.length<1)
				{
				alert("没有数据,请选择其他月份");
				}
			if(data.length==0)
				{
				  $(".homeMap1").empty();	
				return;
				}
			
			for (var k = 0; k < data.length; k++) {

				$(".homeMap1")
				.prepend("<div"+" "+"id=usermap"+k+"></div>");
		
	      	$(".homeMap1").children("div").addClass("allmap1");

				var data1 = data[k];
				 //显示时间;
				 
				 var trackTime1=data1[0].datatime;
				 var trackTime2=data1[data1.length-1].datatime;
				 
				 
				 trackTime1= BaseUtility.longConvertDate(trackTime1);
				 
				 trackTime2=BaseUtility.longConvertDate(trackTime2);
				 
				 
				 $("#usermap"+k)
					.prepend("<label"+" "+"id=maplabell"+k+">"+"到 "+trackTime2+"</label>");
				 $("#usermap"+k)
					.prepend("<label"+" "+"id=maplabel"+k+">日期:"+trackTime1+"</label>");
				 
				 $("#usermap"+k).children("label").addClass("maplabel");
				 
				 
					$("#usermap"+k)
					.prepend("<img"+" "+"id="+k+"></img>");
		
				//起点
				var pt11;
				if (data1[0].type == 1)
					pt11 = wgs2bd(data1[0].lat, data1[0].lng);
				else {
					pt11 = gcj2bd(data1[0].lat, data1[0].lng);
				}

				 var center1;
				 if((data1.length%2)==0)
				 {
					 center1=data1.length/2;
				 }else{
					 
					 center1=(data1.length+1)/2;
				 }						
				
				 var center;
				 if (data1[center1].type == 1)
					   center = wgs2bd(data1[center1].lat, data1[center1].lng);
					else {
					   center = gcj2bd(data1[center1].lat, data1[center1].lng);
					}
				

				var length = data1.length;
	

				var paths = null;

				var point = [];
				for (var i = 0; i < 10; i++) {
					var pt00 = null;
					if (data1[i].type == 1)
						pt00 = wgs2bd(data1[i].lat,
								data1[i].lng);
					else {
						pt00 = gcj2bd(data1[i].lat,
								data1[i].lng);
					}
					point.push(new BMap.Point(pt00.lng, pt00.lat));
					

					paths = paths + pt00.lng + "," + pt00.lat + ";"

				}
				//终点：
				var pt12;
				if (data1[data1.length - 1].type == 1)
					pt12 = wgs2bd(data1[length - 1].lat,
							data1[data1.length - 1].lng);
				else {
					pt12 = gcj2bd(data1[length - 1].lat,
							data1[data1.length - 1].lng);
				}

	
				
				var src = "http://api.map.baidu.com/staticimage?width=260&height=220&center="
					+ center.lng
					+ ","
					+ center.lat
					+ "&zoom=16&paths="
					+ paths
					+ "&pathStyles=0x0000ff,3,1"
					+ "&markerStyles=-1,http://api.map.baidu.com/images/marker_red.png,-1,23,25"
					+ "&markers="
					+ pt11.lng
					+ ","
					+ pt11.lat
					+ "|"
					+ pt12.lng
					+ ","
					+ pt12.lat;
				
				$("#" + k).attr("src", src);

				$("#" + k).bind('click', function() {
					var usertrack='<%=request.getAttribute("contextPath1")%>';
					var imgid = $(this).attr("id");
					hello = imgid;

					layer.open({
								type : 2,
								icon : 1,
								title : "用户行车轨迹",
								maxmin : true,
								shadeClose : true,
								shade : 0.5,
								closeBtn : 1,
								area:["70%","70%"],
								content : usertrack+"track.jsp"
							  });
		                 	});
			   }
		});
		
<!-- 初始化结束 -->	
$("#dynamic-dialog").removeClass("dialog");

  $("#loading").removeClass("loading");
  
  $('#loading').shCircleLoader('destroy');	
		
		
		
		
});

</script>


