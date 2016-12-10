<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<form class="navbar-form navbar-right" role="search"
	action="${contextPath}/controller/search" method="post">
	<div class="form-group">
		<input type="text" class="form-control" placeholder="Search"
			id="device-search" name="search" autocomplete="off">
		<button type="button" class="btn btn-default" id="device-search1">搜索</button>
		<div class="list-group" id="first-search-fuzzy">
			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"
				id="first-search-fuzzy1">
				<li role="presentation"><a role="menuitem" tabindex="-1">Java</a>
				</li>
			</ul>
		</div>
	</div>
</form>

<script id="firstsearchGroup" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
                <li  role="presentation" data-n_id={{d[i].n_id}} data-c_imei={{d[i].c_imei}} >
				<a role="menuitem" tabindex="-1" >{{d[i].c_imei}}</a>
				</li> 
        {{# } }}
</script>

<script>
function showData(data, tmpl, target){
	var gettpl = $(tmpl).html();
	laytpl(gettpl).render(data, function(html){
  		$(target).html(html)
	});
} 
	$("#device-search1").click(function(){
		var value = $("#device-search").val();	
		var role="${adminRole}";
		 $.post("${contextPath}/controller/search", 
				 {
			 search:value,
				 },
				 function(data){
			if(data.state=="1"){
				alert("没有此imei号");
			}else				
			{
			    if(role=="1"){
			    	window.location.href="${contextPath1}singleDeviceAll?c_imei="+value;	
			    }else{
			    	window.location.href="${contextPath1}singleDevice?c_imei="+value;
			    }
			}
		    });		
	})
	//----------------------------------实时监听searchimei的变化

	$('#device-search').bind(
			'input propertychange',
			function() {
				var data = $(this).val();
				//实时模糊查询
				//controller/fuzzySearch
				if (data.length > 0) {
					$.post("${contextPath}/controller/firstFuzzyAllSearch", {
						search : data,
					}, function(data) {
						if (data.state == "0") {
							showData(data.result, "#firstsearchGroup","#first-search-fuzzy1");
							$('#first-search-fuzzy').show();
							$('#first-search-fuzzy1').show();
						} else {
							showData(data.result, "#firstsearchGroup",
									"#first-search-fuzzy1");
							$('#first-search-fuzzy').hide();
							$('#first-search-fuzzy1').hide();
						}

					});
				} else {
					$('#first-search-fuzzy').hide();
					$('#first-search-fuzzy1').hide();
				}
			});

	//模糊查询点击事件；
	$("#first-search-fuzzy ul").on("click", "li", function() {
		var imei = $(this).data("c_imei");
		$("#device-search").val(imei);
		$('#first-search-fuzzy').hide();
		$('#first-search-fuzzy1').hide();
	});
	//-------------------------------点击空白处
	$("body").bind('click', function() {
		$('#first-search-fuzzy').hide();
		$('#first-search-fuzzy1').hide();
	});
</script>











