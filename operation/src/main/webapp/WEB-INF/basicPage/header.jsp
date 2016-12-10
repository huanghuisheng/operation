<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<%
String cntextPath = request.getContextPath();

if (cntextPath.equalsIgnoreCase("/")) {
    cntextPath = "";
}
if (cntextPath.endsWith("/")) {
    cntextPath = cntextPath.substring(0, cntextPath.length() - 1);
}
String contextPath=cntextPath;
request.setAttribute("contextPath",contextPath);
%>

<meta charset="UTF-8">
<%--  <title>${param.title}</title>  --%>
<title>运营后台</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-touch-fullscreen" content="yes">
<meta name="description" content="Outline Admin Theme">
<meta name="author" content="KaijuThemes">


<!--百度地图  -->
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=GtZUIgCp33rDZWImHqtlzwYT"></script>
<!-- <script type="text/javascript"
	src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script> -->




<script type="text/javascript" src="${contextPath}/assets/js/jquery-1.10.2.min.js"></script>
<!-- Load jQuery -->
<script type="text/javascript" src="${contextPath}/assets/js/jqueryui-1.10.3.min.js"></script>

<%-- <link rel="stylesheet" href="${contextPath}/css/layer.css"> --%>


<!-- <link type='text/css'
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,400italic,600'
	rel='stylesheet'> -->
	<link type='text/css'
	href='${contextPath}/css/fonts.css'
	rel='stylesheet'>	
<link type="text/css"
	href="${contextPath}/assets/fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link type="text/css"
	href="${contextPath}/assets/fonts/themify-icons/themify-icons.css" rel="stylesheet">
<!-- Themify Icons -->
<link type="text/css"
	href="${contextPath}/assets/fonts/weather-icons/css/weather-icons.min.css"
	rel="stylesheet">
<!-- Weather Icons -->
<link rel="stylesheet" href="${contextPath}/assets/css/styles-alternative.css"
	id="theme">
<!-- Default CSS: Altenate Style -->
<link rel="prefetch alternate stylesheet" href="${contextPath}/assets/css/styles.css">
<!-- Prefetched Secondary Style -->
<link type="text/css" href="${contextPath}/assets/plugins/codeprettifier/prettify.css"
	rel="stylesheet">
<!-- Code Prettifier -->
<link type="text/css"
	href="${contextPath}/assets/plugins/iCheck/skins/minimal/blue.css" rel="stylesheet">
<!-- iCheck -->
<link type="text/css"
	href="${contextPath}/assets/plugins/fullcalendar/fullcalendar.css" rel="stylesheet">
<!-- FullCalendar -->
<link type="text/css"
	href="${contextPath}/assets/plugins/jvectormap/jquery-jvectormap-2.0.2.css"
	rel="stylesheet">
<!-- jVectorMap -->
<link type="text/css" href="${contextPath}/assets/plugins/switchery/switchery.css"
	rel="stylesheet">
<!-- Switchery -->



<!-- 自定义样式  -->
<link rel="stylesheet" href="${contextPath}/css/normalize.css">
<link rel="stylesheet" href="${contextPath}/css/css.css">
<link rel="stylesheet" href="${contextPath}/css/huang.css">



















