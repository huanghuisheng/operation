<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/basicPage/header.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>
<style type="text/css">
body, html {
	width: 100%;
	height: 100%;
	margin: 0;
	font-family: "微软雅黑";
}

#allmap {
	    width: 97%;
	    height: 60%;
}
.user-car li {
    float: left;
     list-style-type:none;
}

.user-car1 li p {
   margin: 0;	
}

.user-car li p {
   margin: 0;	
}


.user-car li label {
    padding: 0 10px 0 130px;
}



.user-car1 li {
    float: left;
     list-style-type:none;
}

.user-car1 li label {
    padding: 0 10px 0 130px;
}

.device-info1 {
    height: 80px;
}
.device-info2 {
    height: 100px;
}
.device-info3 {
    height: 60px;
}



.device-info1  div {
    height: 30px;
}
.device-info2  div {
    height: 30px;
}
.device-info3  div {
    height: 30px;
        margin-top: 20px;
}

.user-car1{
float:left;
}



.user-car2{
float:left;
}
.user-car4{
float:left;
}

.user-datainfo1{
border: 2px dashed #bfbfbf;
  
    margin-left: 15px;
    margin-right: 15px;
    margin-top: 5px;
}

.device-info3 div h4 {
    float: left;
}
.car-group {
    float: left;
}



</style>
</head>

<body>
	<div id="allmap"></div>
	<div class="user-datainfo1 clearfix">
		<div class="device-info1">
			<div>
				<h4>本车行车数据</h4>
			</div>
			<div>
				<div class="user-car1">
					<li><label>行驶里程：</label></li>
					<li>
						<p class="user_trave"></p>
					</li>
				</div>
				<div class="user-car1">
					<li><label>总耗时：</label></li>
					<li>
						<p class="user_sumTime"></p>
					</li>
				</div>
				<div class="user-car1">
					<li><label>平均车速：</label></li>
					<li>
						<p class="user_driveRate"></p>
					</li>
				</div>

			</div>

		</div>
		<div class="device-info2">
			<div>
				<h4>驾驶行为数据统计</h4>
			</div>
			<div class="car-group">
				<div class="user-car">
					<li><label>急刹车次数：</label></li>
					<li>
						<p class="user_speed_down">v 1.2.6</p>
					</li>
				</div>
				<div class="user-car">
					<li><label>急转弯：</label></li>
					<li>
						<p class="user_turn"></p>
					</li>
				</div>
				<div class="user-car">
					<li><label>疲劳驾驶：</label></li>
					<li>
						<p class="user_fatigue"></p>
					</li>
				</div>


			</div>
			<div class="car-group">
				<div class="user-car">
					<li><label>急加速次数：</label></li>
					<li>
						<p class="user_speed_up"></p>
					</li>
				</div>
				<div class="user-car">
					<li><label>碰撞次数：</label></li>
					<li>
						<p class="user_compile"></p>
					</li>
				</div>

			</div>

		</div>

		<div class="device-info3">
			<div>
				<h4>综合评分：</h4>
				<h4 class="composite-grade"></h4>
			</div>
			<div></div>
		</div>
</body>
</html>
<jsp:include page="/WEB-INF/basicPage/footer.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>

<script type="text/javascript">
 
	//轨迹数据；
	var data = parent.trackData[parent.hello - 1][0];
	var driver = parent.trackData[parent.hello - 1][1];

	console.log(driver);

	var map = new BMap.Map("allmap");
	map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
	var myIcon = new BMap.Icon("${contextPath}/images/car.png", new BMap.Size(
			52, 26), {
		imageOffset : new BMap.Size(0, 0)
	}, {
		anchor : new BMap.Size(27, 13)
	});
	var myIcon1 = new BMap.Icon(
			"${contextPath}/images/markers_new2_4ab0bc5.png", new BMap.Size(32,
					70), {
				imageOffset : new BMap.Size(0, 0)
			});
	var myIcon2 = new BMap.Icon("${contextPath}/images/asdf.png",
			new BMap.Size(32, 70), {
				imageOffset : new BMap.Size(0, 0)
			});
	var myIcon1;
	var point = [];

	var length = data.length;
	var pt11=data[0];
/* 	if (data[0].type == 1)
		pt11 = wgs2bd(data[0].lat, data[0].lng);
	else {
		pt11 = gcj2bd(data[0].lat, data[0].lng);
	} */
	var pt1 = new BMap.Point(pt11.clng, pt11.clat);
	var marker1 = new BMap.Marker(pt1, {
		icon : myIcon1
	});
	map.addOverlay(marker1);

	//中心点;
	var center1;
	if ((data.length % 2) == 0) {
		center1 = data.length / 2;
	} else {
		center1 = (data.length + 1) / 2;
	}
	var center=data[center1];
	/* if (data[center1].type == 1)
		center = wgs2bd(data[center1].lat, data[center1].lng);
	else {
		center = gcj2bd(data[center1].lat, data[center1].lng);
	} */
	var ptCenter = new BMap.Point(center.clng, center.clat);
	map.centerAndZoom(ptCenter, 17);
	for (var i = 0; i < data.length; i++) {

		var pt00 = data[i];
		/* if (data[i].type == 1)
			pt00 = wgs2bd(data[i].lat, data[i].lng);
		else {
			pt00 = gcj2bd(data[i].lat, data[i].lng);
		} */
		point.push(new BMap.Point(pt00.clng, pt00.clat));
	}
	var polyline = new BMap.Polyline(point, {
		strokeColor : "blue",
		strokeWeight : 3,
		strokeOpacity : 1
	}); //定义折线
	map.addOverlay(polyline);
	var pt12=data[length - 1];
	/* if (data[data.length - 1].type == 1)
		pt12 = wgs2bd(data[length - 1].lat, data[data.length - 1].lng);
	else {
		pt12 = gcj2bd(data[length - 1].lat, data[data.length - 1].lng);
	} */
	var pt5 = new BMap.Point(pt12.clng, pt12.clat);
	var marker5 = new BMap.Marker(pt5, {
		icon : myIcon2
	});
	map.addOverlay(marker5);

	//路书进行车辆行驶
	var lushu = new BMapLib.LuShu(map, point, {
		defaultContent : "",//"从天安门到百度大厦"
		autoView : true,//是否开启自动视野调整，如果开启那么路书在运动过程中会根据视野自动调整
		icon : myIcon,
		speed : 200,
		enableRotation : true,//是否设置marker随着道路的走向进行旋转
		landmarkPois : []
	});
	marker1.addEventListener("click", showInfo);
	function showInfo(e) {
		lushu.start();
	}
	var trackTime1 = data[0].dataTime;
	var trackTime2 = data[data.length - 1].dataTime;

	var imei = data[0].imei;
	var model = data[0].model;

	$(".user_trave").html(driver.distance/1000 + "公里");

	$(".user_sumTime").html(driver.time + "小时");
	$(".user_driveRate").html(driver.speed + "km/h");

	$(".user_speed_down").html(driver.speed_down + "次");

	$(".user_speed_up").html(driver.speed_up + "次");

	$(".user_turn").html(driver.turn + "次");
	$(".user_compile").html(driver.collide + "次");
	$('.composite-grade').html(driver.grade + "分");
	$('.user_fatigue').html(driver.fatigue + "次");

	//获取驾驶行为;		     

	/* 				  $.post("${contextPath}/controller/drive",
	 {
	 time1 :trackTime2,
	 time2 : trackTime1,
	 imei : imei,
	 model : model,
	 },
	 function(data) {
	
	 $(".user_trave").html(data[0].path+"公里");	
	
	 $(".user_sumTime").html(data[0].sumTime+"分钟");
	 $(".user_driveRate").html(data[0].driveRate+"km/h");
	
	 $(".user_speed_down").html(data[0].speed_down+"次");
	
	 $(".user_speed_up").html(data[0].speed_up+"次");
	
	 $(".user_turn").html(data[0].turn+"次");
	 $(".user_compile").html(data[0].turn+"次");
	
	
	 $('.composite-grade').html(data[0].grade+"小时");
	 });  */
</script>
