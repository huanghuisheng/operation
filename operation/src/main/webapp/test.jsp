<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String cntextPath = request.getContextPath();
	if (cntextPath.equalsIgnoreCase("/")) {
		cntextPath = "";
	}
	if (cntextPath.endsWith("/")) {
		cntextPath = cntextPath.substring(0, cntextPath.length() - 1);
	}
	String contextPath = cntextPath;
	request.setAttribute("contextPath", contextPath);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${contextPath}/css/bootstrap.css">
<link rel="stylesheet" href="${contextPath}/css/bootstrap-table.css">
<link rel="stylesheet" href="${contextPath}/css/clw4G.css">
<link rel="stylesheet" href="${contextPath}/css/20161110.css">
<script src="${contextPath}/js/jquery-1.11.3.js"></script>
<script src="${contextPath}/js/bootstrap.js"></script>
<script src="${contextPath}/js/bootstrap-table.js"></script>
<script src="${contextPath}/js/echarts.js"></script>
<script src="${contextPath}/js/base.js"></script>
<script src="${contextPath}/js/laytpl.js"></script>
<script src="${contextPath}/js/ajaxfileupload.js"></script>
<script
	src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>
</head>
<body>
<div class="row">
  <div class="col-sm-6 col-md-6">
  
<div class="panel-group test01" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        Collapsible Group Item #3
        </a>
      </h4>
    </div>
  </div>
</div>	

<div class="panel-group test01" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        Collapsible Group Item #3
        </a>
      </h4>
    </div>
  </div>
</div>
<div class="panel-group test01" id="accordion" role="tablist" aria-multiselectable="true">
  <div class="panel panel-default">
    <div class="panel-heading" role="tab" id="headingOne">
      <h4 class="panel-title">
        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
        Collapsible Group Item #3
        </a>
      </h4>
    </div>
  </div>
</div>


</div>
</div>









</body>
</html>
<script type="text/javascript">
	$('#myTab a').click(function(e) {
		e.preventDefault()
		$(this).tab('show')
	});



	
	$('#myButton').on('click', function() {

		var $btn = $(this).button('loading')
		// business logic...
				alert();
		$btn.button('reset')
	});
	
	
	
</script>






