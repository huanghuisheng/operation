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
	width: 100%;
	height: 100%;
}

p {
	margin-left: 5px;
	font-size: 14px;
}
</style>
</head>

<body>
	<div id="allmap"></div>
</body>
</html>
<jsp:include page="/WEB-INF/basicPage/footer.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>

<script type="text/javascript">
         //轨迹数据；
			var data=parent.trackData[parent.hello];
			var map = new BMap.Map("allmap");
			map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
			var myIcon = new BMap.Icon(
					"${contextPath}/images/car.png",
					new BMap.Size(52,26), {
						imageOffset : new BMap.Size(0, 0)
					},
					{anchor : new BMap.Size(27, 13)});
			var myIcon1 = new BMap.Icon(
					"${contextPath}/images/markers_new2_4ab0bc5.png",
					new BMap.Size(32, 70), {
						imageOffset : new BMap.Size(0, 0)
					});
			var myIcon2 = new BMap.Icon(
					"${contextPath}/images/asdf.png",
					new BMap.Size(32, 70), {
						imageOffset : new BMap.Size(0, 0)
					});

	var myIcon1;
	 var point=[];
				var length = data.length;
				 var pt11;
				   if(data[0].type == 1)
					   pt11 = wgs2bd(data[0].lat,data[0].lng);
		           else{
		        	   pt11 = gcj2bd(data[0].lat,data[0].lng);
		           }
				var pt1 = new BMap.Point(pt11.lng, pt11.lat);
				var marker1 = new BMap.Marker(pt1,{icon:myIcon1});
				map.addOverlay(marker1);
				
				//中心点;
			 var center1;
			 if((data.length%2)==0)
			 {
				 center1=data.length/2;
			 }else{
				 center1=(data.length+1)/2;
			 }						
			 var center;
			 if (data[center1].type == 1)
				   center = wgs2bd(data[center1].lat, data[center1].lng);
				else {
				   center = gcj2bd(data[center1].lat, data[center1].lng);
				}
			 var ptCenter = new BMap.Point(center.lng, center.lat);	
				map.centerAndZoom(ptCenter, 17);
				for (var i = 0; i < data.length; i++) {
	
					 var pt00=null;
					   if(data[i].type == 1)
						   pt00 = wgs2bd(data[i].lat,data[i].lng);
			           else{
			        	   pt00 = gcj2bd(data[i].lat,data[i].lng);
			           }
					  point.push(new BMap.Point(pt00.lng, pt00.lat));
				}
				var polyline = new BMap.Polyline(point,{
					strokeColor : "blue",
					strokeWeight : 3,
					strokeOpacity : 1
				}); //定义折线
				map.addOverlay(polyline);
				var pt12;
				   if(data[data.length -1].type == 1)
					   pt12 = wgs2bd(data[length - 1].lat,data[data.length - 1].lng);
		           else{
		        	   pt12 = gcj2bd(data[length - 1].lat,data[data.length - 1].lng);
		           }
				var pt5 = new BMap.Point(pt12.lng,
						pt12.lat);
				var marker5 = new BMap.Marker(pt5,{icon:myIcon2});
				map.addOverlay(marker5);

				//路书进行车辆行驶
				 var lushu = new BMapLib.LuShu(map,point,{
		                defaultContent:"",//"从天安门到百度大厦"
		                autoView:true,//是否开启自动视野调整，如果开启那么路书在运动过程中会根据视野自动调整
		                icon  :myIcon,
		                speed: 200,
		                enableRotation:true,//是否设置marker随着道路的走向进行旋转
		                landmarkPois: []
		                });	
				marker1.addEventListener("click", showInfo);
				function showInfo(e) {
					lushu.start();
				}
				</script>
