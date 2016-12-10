$(function(){
    
	var url = "http://192.168.10.37:8080/huangdemo/";
	
	//获取分组数据
	$.post(url + "controller/showGroup", function(data){
		console.log(data);
		if(data.code == "0"){
			showData(data.result, "#tableObjView", "#tableObj");	
		}
    });
	
	//显示分组数据
	function showData(data, tmpl, target){
		var gettpl = $(tmpl).html();
		
		laytpl(gettpl).render(data, function(html){
	  		$(target).html(html)
		});
	}
	
	
	//新增分组
	var addFenzuGroupEle = $("#addNewFenzuModal input[type=text]");
	
	$("#addNewFenzu").click(function(){
		$("#addNewFenzuModal .alert").hide();
		$("#addNewFenzuModal").modal();
	});
	
	$("#addNewFenzuModal").on("hidden.bs.modal", function(){
		addFenzuGroupEle.val("");
		$("#addNewFenzuModal .alert").hide();
	});
	
	$("#addNewFenzuModal .saveBtn").click(function(){
		var value = addFenzuGroupEle.val().trim();
		
		if(value === ""){
			$("#addNewFenzuModal .alert").show();
			return;
		}
		
		$.post(url + "controller/addGroup", {
			groupName: value
		}, function(data){
			console.log(data);
			var resultHtml = '<tr data-n_id="' + data.result[0]["n_id"] + '" data-c_group_name="' + data.result[0]["c_group_name"] + '">' + '<td><input type="checkbox"></td><td> ' + data.result[0]["c_group_name"] + '</td></tr>'; 
			$(resultHtml).appendTo($("#tableObj"));
			addFenzuGroupEle.val("");
			$("#addNewFenzuModal").modal("hide");
		});
	});

	
	
	//选择要删除或者修改哪个分组数据
	$("#tableObj" ).on("click", "tr", function(){
		$("#tableObj input[type=checkbox]").removeAttr("checked");
		$(this).find("input[type=checkbox]").prop("checked", true);
		
		changeFenzuObj.el = $(this);
		changeFenzuObj.n_id = $(this).data("n_id");
		changeFenzuObj.c_group_name = $(this).data("c_group_name");
	});
	
	
	var changeFenzuObj = {
		el: null,
		n_id: null,
		c_group_name: null
	};
	
	
	//删除分组
	$("#deleteFenzu").click(function(){
		if(changeFenzuObj.n_id == null){
			alert("请选择一个分组");
			return;
		}
		$("#deleteFenzuModalText").html(changeFenzuObj.c_group_name);
		$("#deleteFenzuModal").modal();
	});
	
	
	$("#deleteFenzuModal .saveBtn").click(function(){
		$.post(url + "controller/deleteGroup", {groupid: changeFenzuObj.n_id}, function(data){
			console.log(data);
			if(data.code == "0"){
				changeFenzuObj.el.remove();
				changeFenzuObj = {
					el: null,
					n_id: null,
					c_group_name: null
				};
				$("#deleteFenzuModal").modal("hide");
			}
		});
	});
	
	
	//修改分组
	$("#reviseFenzu").click(function(){
		if(changeFenzuObj.n_id == null){
			alert("请选择一个分组");
			return;
		}
		$("#reviseFenzuModalText").val(changeFenzuObj.c_group_name);
		$("#reviseFenzuModal").modal();
	});
	
	$("#reviseFenzuModal").on("hidden.bs.modal", function(){
		$("#reviseFenzuModalText").val("");
		$("#reviseFenzuModal .alert").hide();
	});
	
	$("#reviseFenzuModal .saveBtn").click(function(){
		var value = $("#reviseFenzuModalText").val().trim();
		
		if(value === ""){
			$("#reviseFenzuModal .alert").show();
			return;
		}
		
		$.post(url + "controller/updateGroup", {
			groupid: changeFenzuObj.n_id,
			groupName: value
		}, function(data){
			console.log(data);
			if(data.code == "0"){
				changeFenzuObj.el.find("td").eq(1).html(value);
				$("#reviseFenzuModalText").val("");
				$("#reviseFenzuModal").modal("hide");
				changeFenzuObj.c_group_name = value;
			}
		});
	});
	
});