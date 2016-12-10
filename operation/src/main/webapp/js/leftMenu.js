$(function(){

	//获取分组数据
	$.post("../controller/showGroup", function(data){
		console.log(data);
		if(data.code == "0"){
			
			//显示左边分组情况；
			showData(data.result, "#leftMenu", "#admin-group");
		}
    });
	
	//显示分组数据
	function showData(data, tmpl, target){
		var gettpl = $(tmpl).html();
		laytpl(gettpl).render(data, function(html){
	  		$(target).html(html)
		});
	}

	
});
