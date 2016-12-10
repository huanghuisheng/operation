<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<jsp:include page="/WEB-INF/basicPage/footer.jsp">
	<jsp:param name="title" value="运营后台" />
</jsp:include>
<script src="js/jquery.shCircleLoader.js"></script>
<style type="text/css">
.dialog {
    position: fixed;
    _position: absolute;
    width: 100%;
    height: 100%;
    left: 0;
    top: 0;
    z-index: 199998;
    opacity: .3;
    filter: alpha(opacity=50);
    background: #000000;
    display: block;
}
.loading {
   
    width: 150px;
    height: 150px;
    margin-left: auto;
	margin-right: auto;
	margin-top:300px;
	
    
}

</style>
	
	
	
	
  </head>
  
  <body>
    ===================================This is my second JSP page. <br>
    <div class="dynamic-dialog  dialog" id="dynamic-dialog">
    </div>
     <div class="loading"></div>
  </body>
  
</html>


<script type="text/javascript">



$(function() {
	$('.loading').shCircleLoader({
	    //options
	});
	
	
	
	
});




$("#dynamic-dialog").bind('click',function(){	
	$("#dynamic-dialog").removeClass("dialog");
	
});
 
</script>


    <!-- 初始化 -->

	$("#dynamic-dialog").addClass("dialog");
		
		$("#loading").addClass("loading");
		
		$('.loading').shCircleLoader({
		    //options
		});
		
		
	
		<!-- 初始化结束 -->	
	 $("#dynamic-dialog").removeClass("dialog");
	
       $("#loading").removeClass("loading");
       
       $('#loading').shCircleLoader('destroy');	
		
		
		

















