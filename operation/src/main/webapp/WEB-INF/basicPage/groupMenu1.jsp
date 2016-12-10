<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


		<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" aria-expanded="false">个人中心<span
							class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li id="personalCenter1"><a href="${contextPath2}firstAccoutControllGroup">进入个人中心</a></li>
							<li id="personalCenter2"><a href="${contextPath2}secondDeviceClient">进入个人中心</a></li>
							<li><a id="user_dropout">退出登录</a></li>
						</ul>
						
						</li>
	   </ul>


<script>
//-----------------------获取权限值和账号信息
var role="${adminRole}";
var type="${adminType}";
if (type == "2") {
	$("#personalCenter1").hide();
} else {
	$("#personalCenter2").hide();	
}


</script>











