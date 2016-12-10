<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<ul class="nav navbar-nav">
	<li><a href="${contextPath1}deviceControl">设备监控</a></li>
	<li id="spareMoble"><a href="${contextPath3}spareMobleAll">备用机管理</a></li>
	<li id="spareAll"><a href="${contextPath3}spareAll">备用机管理</a></li>
	<li id="spareAsAll"><a href="${contextPath4}spareAsAll">售后管理</a></li>
	<%-- <li id="deviceAll"><a href="${contextPath5}homePage">设备统计</a></li> --%>
<%-- 	<li role="presentation" class="dropdown">
	<a class="dropdown-toggle" data-toggle="dropdown" href="#">设备统计<span class="caret"></span></a>

		<ul class="dropdown-menu" role="menu">
			<li ><a href="${contextPath5}homePage">设备分布</a></li>
			<li role="presentation" class="divider"></li>
			<li ><a href="${contextPath5}accumulating">累计用户</a></li>
			<li role="presentation" class="divider"></li>
			<li ><a href="${contextPath5}increased">新增用户</a></li>'
			<li role="presentation" class="divider"></li>
			<li ><a href="${contextPath5}activeUser">活跃用户</a></li>
		</ul>
		
   </li> --%>
</ul>
<script>
	var type = "${adminType}";
	var name = "${username}";
	if (type == "0") {
		$("#spareMoble").hide();
	} else if (type == "1") {
		$("#spareAll").hide();
		$("#spareAsAll").hide();
		$("#deviceAll").hide();
		if(name=="CMCC")
			{
			$("#spareMoble").hide();
			}
		
	} else {
		$("#spareMoble").hide();
		$("#spareAll").hide();
		$("#spareAsAll").hide();
		$("#deviceAll").hide();

	}
</script>











