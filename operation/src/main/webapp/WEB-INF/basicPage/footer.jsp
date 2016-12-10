<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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

<script type="text/javascript"
	src="${contextPath}/js/TextIconOverlay_min.js"></script>

<script type="text/javascript"
	src="${contextPath}/js/MarkerClusterer.js"></script>


<!--页眉 js-->

<!-- Load jQueryUI -->
<script type="text/javascript"
	src="${contextPath}/assets/js/bootstrap.min.js"></script>
<!-- Load Bootstrap -->
<script type="text/javascript"
	src="${contextPath}/assets/js/enquire.min.js"></script>
<!-- Load Enquire -->

<script type="text/javascript"
	src="${contextPath}/assets/plugins/velocityjs/velocity.min.js"></script>
<!-- Load Velocity for Animated Content -->
<script type="text/javascript"
	src="${contextPath}/assets/plugins/velocityjs/velocity.ui.min.js"></script>

<script type="text/javascript"
	src="${contextPath}/assets/plugins/wijets/wijets.js"></script>
<!-- Wijet -->

<script type="text/javascript"
	src="${contextPath}/assets/plugins/codeprettifier/prettify.js"></script>
<!-- Code Prettifier  -->
<script type="text/javascript"
	src="${contextPath}/assets/plugins/bootstrap-switch/bootstrap-switch.js"></script>
<!-- Swith/Toggle Button -->

<script type="text/javascript"
	src="${contextPath}/assets/plugins/bootstrap-tabdrop/js/bootstrap-tabdrop.js"></script>
<!-- Bootstrap Tabdrop -->

<script type="text/javascript"
	src="${contextPath}/assets/plugins/iCheck/icheck.min.js"></script>
<!-- iCheck -->

<script type="text/javascript"
	src="${contextPath}/assets/plugins/nanoScroller/js/jquery.nanoscroller.min.js"></script>
<!-- nano scroller -->
<script type="text/javascript"
	src="${contextPath}/assets/plugins/jquery-mousewheel/jquery.mousewheel.min.js"></script>
<!-- Mousewheel support needed for Mapael -->

<script type="text/javascript"
	src="${contextPath}/assets/plugins/sparklines/jquery.sparklines.min.js"></script>
<!-- Sparkline -->

<script type="text/javascript"
	src="${contextPath}/assets/js/application.js"></script>
<script type="text/javascript" src="${contextPath}/assets/demo/demo.js"></script>



<!-- 自定义js -->
<%-- <script type="text/javascript" src="${contextPath}/js/huang.js"></script>  --%>

<script type="text/javascript" src="${contextPath}/js/echarts.js"></script>
<script type="text/javascript" src="${contextPath}/js/base.js"></script>

<!-- <script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/extension/dataTool.min.js"></script> -->

<%-- <script type="text/javascript"
	src="${contextPath}/js/echartsdataTool.min.js"></script>	 --%>


<!-- <script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/china.js"></script> -->

<%-- 	<script type="text/javascript"
	src="${contextPath}/js/china.js"></script> --%>



<!-- <script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/map/js/world.js"></script> -->

<%-- <script type="text/javascript"
	src="${contextPath}/js/world.js"></script>	 --%>


<!-- <script type="text/javascript"
	src="http://echarts.baidu.com/gallery/vendors/echarts/extension/bmap.min.js"></script> -->

<%-- <script type="text/javascript"
	src="${contextPath}/js/bmap.min.js"></script>	 --%>

<!-- <script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=ZUONbpqGBsYGXNIYHicvbAbM"></script> -->



<script type="text/javascript" src="${contextPath}/js/transform.js"></script>

<!-- <script type="text/javascript"
	src="http://api.map.baidu.com/library/CurveLine/1.5/src/CurveLine.min.js"></script> -->

<script type="text/javascript" src="${contextPath}/js/CurveLine.min.js"></script>

<!-- <script type="text/javascript"
	src="http://api.map.baidu.com/library/AreaRestriction/1.2/src/AreaRestriction_min.js"></script> -->


<%-- <script type="text/javascript"
	src="${contextPath}/js/AreaRestriction_min.js"></script> --%>
<script type="text/javascript" src="${contextPath}/js/layer.js"></script>


<script type="text/javascript" src="${contextPath}/js/LuShu_min.js"></script>

<!-- 动态框框架 -->
<script src="${contextPath}/js/jquery.shCircleLoader.js"></script>













