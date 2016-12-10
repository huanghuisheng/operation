<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<ul class="nav navbar-nav">
					<li><a href="${contextPath1}deviceControl">设备监控</a></li>
					<li id="spareMoble"><a href="${contextPath3}spareMobleAll">备用机管理</a></li>
					<li id="spareAll"><a href="${contextPath3}spareAll">备用机管理</a></li>
					<li id="spareAsAll"><a href="${contextPath4}spareAsAll">售后管理</a></li>
	    </ul>


<script>
var type="${adminType}";


if (type == "0") {
	$("#spareMoble").hide();
} else if(type == "1") {
	$("#spareAll").hide();
	$("#spareAsAll").hide();
}else
	{
	$("#spareMoble").hide();
	$("#spareAll").hide();
	$("#spareAsAll").hide();
	}


</script>











