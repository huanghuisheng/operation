<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html>
<head>
<%-- <jsp:include page="/WEB-INF/basicPage/header.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include> --%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	
	<script type="text/javascript" src="${contextPath}/assets/jquery.js"></script>
	<script type="text/javascript" src="${contextPath}/assets/mediaelement-and-player.min.js"></script>
	
	
	
	<link rel="stylesheet"  href="${contextPath}/assets/mediaelementplayer.min.css" />
</head>

<style type="text/css">
body, html {
	width: 100%;
	height: 80%;
	margin: 0;
	font-family: "微软雅黑";
}
div#mep_0 {
    height: 600px ! important;
}
/* #allmap {
	width: 100%;
	height: 60%;
}
 */
</style>
</head>

<body>
<video width="100%" height="90%" id="player2" controls="controls">
	<source src="" type="video/mp4" title="mp4">
</video>
	
	
	
	
</body>
</html>
<%-- <jsp:include page="/WEB-INF/basicPage/footer.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include> --%>
<script type="text/javascript">
         //轨迹数据；
     var data=parent.videoData[parent.videoDataIndex];
         
         
         var src="http://112.35.5.37:5000"+data.c_res_path;

     	$("source").attr("src", src);
	
     	$('video').mediaelementplayer({
     		features: ['playpause','progress','volume','sourcechooser']
     	});
     	
         
         
         
</script>
