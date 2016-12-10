
//--------------------------------点击空白处；
//$("body").bind(
//		'click',
//		function() {
//			
//			if(selectDevice=="false"||selectDiverDate=="false"||selectArea=="false"||selectDate=="false"||selectDate1=="false")
//				{
//				alert();
//				}
//			
//			
//		});
$(".user-operation1").bind('click', function() {
	layer.open({
		  type: 2,
		  area: ['350px', '400px'],
		  fix: false, //不固定
		  maxmin: true,
		  content: 'video.jsp'
		});
});
$("#menu4").bind('click', function() {
	
		
});



//------------------------------------------------------全局变量；
var selectDevice = "true";
var selectArea = "true";
var selectDate = "true";
// 地区时间标示；
var selectDate1 = "true";

//----------------------------------用户界面时间变量；
var selectDiverDate = "true";

//------------------------------------------------------时间函数；



// ---------------------------------------------------地区异步加载
function findsubcity(parentselid, select_showarea,city3) {
	var cityid = $("#" + parentselid + " option:selected").val();
	var cityName=$("#" + parentselid + " option:selected").text();
	
	$.ajax({
		type : 'GET',
		url : "../controller/code_region?code=" + cityid,
		dataType : 'json',
		cache : 'ture',
		success : function(data) {
			$("#" + select_showarea + " option").remove();
			$("#" + city3 + " option").remove();
			
			var option1 = "<option value='" + 1 + "'>" + "请选择市" + "</option>";
			$("#" + select_showarea).append(option1);

			var option2 = "<option value='" + 1 + "'>" + "请选择县" + "</option>";
			$("#" + city3).append(option2);
			
			$.each(data, function(index, entry) {
				
				var option = "<option value='" + entry['c_code'] + "'>"
						+ entry['c_city'] + "</option>";
               
				/*if(entry['c_city']!=cityName)
				{*/
					$("#" + select_showarea).append(option);	
				/*}*/
				
			
			});

		}
	})

}
function findsubcity1(parentselid, select_showarea) {

	var cityid = $("#" + parentselid + " option:selected").text();
	var cityName=$("#" + parentselid + " option:selected").text();
	
	$.post("../controller/code_region1", {
		code : cityid
	}, function(result) {
		$("#" + select_showarea + " option").remove();
/*		var option1 = "<option value='" + 1 + "'>" + "请选择县" + "</option>";
		$("#" + select_showarea).append(option1);*/
		$.each(result, function(index, entry) {
			var option = "<option value='" + entry['c_code'] + "'>"
					+ entry['c_county'] + "</option>";
			if(entry['c_county']!=cityName)
			{
				$("#" + select_showarea).append(option);
			}
			
			
		});
	});
}
















// -------------------------------------------------------------------------------自定义js函数
var BaseUtility = {
		//----------------------------------------------------------------地区过滤数据；
		filterAreaData:function(data){
			var filterData = new Array(); // 定义一数组
			var filterData1 = new Array(); // 定义一数组
			var filterData2 = new Array(); // 定义一数组
			
			var filterData3 = new Array(); // 鸡行地图；
			var filterData4 = new Array(); // 定义一数组
		/*	var jsonData = {"name5":'闲置期',"name1" : '播种期'};*/		
			var j=0;
		
			for(var i=0;i<data.length;i++)
				{
				if(data[i].number>0){
				    filterData[j] =data[i];
					j++;		
				}
				var jsonData1 = {"name":data[i].city,"value":data[i].number};
				filterData3[i]=jsonData1;
				
				
				}	
			for(var k=0;k<filterData.length;k++)
				{
		
				var jsonData = {"value":filterData[k].number,"name":filterData[k].city};
				filterData1[k]=jsonData;
				filterData2[k]=filterData[k].city;
				
				}
			filterData4[0]=filterData2;
			filterData4[1]=filterData1;
			filterData4[2]=filterData3;
			return filterData4;
			
		},
				
	// -----------------------------------------------------删除样式；
	deleteCss : function() {

		$(".time1").css("overflow", "hidden");
		$(".time1 .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".time1 .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".time1 .preferences-head").css({
			"color" : ""
		});
		$(".time1 .preferences-head::after").css({
			"border-color" : ""
		});
		selectDate = "true"

		$(".area").css("overflow", "hidden");
		$(".area .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".area .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".area .preferences-head").css({
			"color" : ""
		});
		$(".area .preferences-head::after").css({
			"border-color" : ""
		});
		selectArea = "true";

		$(".activeusers").css("overflow", "hidden");
		$(".activeusers .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".activeusers .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".activeusers .preferences-head").css({
			"color" : ""
		});
		$(".activeusers .preferences-head::after").css({
			"border-color" : ""
		});
		selectDevice = "true"

		$(".time2").css("overflow", "hidden");
		$(".time2 .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".time2 .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".time2 .preferences-head").css({
			"color" : ""
		});
		$(".time2 .preferences-head::after").css({
			"border-color" : ""
		});
		selectDate1 = "true"
	},
	//----------------------------------------------删除用户界面样式
	deleteCarCss : function() {

		$(".time-car-diver").css("overflow", "hidden");
		$(".time-car-diver .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".time-car-diver .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".time-car-diver .preferences-head").css({
			"color" : ""
		});
		$(".time-car-diver .preferences-head::after").css({
			"border-color" : ""
		});
		selectDiverDate = "true"

		$(".area").css("overflow", "hidden");
		$(".area .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".area .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".area .preferences-head").css({
			"color" : ""
		});
		$(".area .preferences-head::after").css({
			"border-color" : ""
		});
		selectArea = "true";

		$(".activeusers").css("overflow", "hidden");
		$(".activeusers .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".activeusers .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".activeusers .preferences-head").css({
			"color" : ""
		});
		$(".activeusers .preferences-head::after").css({
			"border-color" : ""
		});
		selectDevice = "true"

		$(".time2").css("overflow", "hidden");
		$(".time2 .preferences-box").css({
			"overflow" : "hidden",
			"border-top-color" : "",
			"background" : "",
			"box-shadow" : ""
		});
		$(".time2 .preferences-bodyer").css({
			"background" : "",
			"box-shadow" : ""
		});
		$(".time2 .preferences-head").css({
			"color" : ""
		});
		$(".time2 .preferences-head::after").css({
			"border-color" : ""
		});
		selectDate1 = "true"
	},
	
	

	// 测试
	str_test : function() {
		alert("-------------hhhhhhhhhhhhhhhhhhhhhh--------------");
	},
	// js里 提交post请求，并跳转页面；
	homePagePost : function(URL, PARAMS) {
		var temp = document.createElement("form");
		temp.action = URL;
		temp.method = "post";
		temp.style.display = "none";
		for ( var x in PARAMS) {
			var opt = document.createElement("textarea");
			opt.name = x;
			opt.value = PARAMS[x];
			// alert(opt.name)
			temp.appendChild(opt);
		}
		document.body.appendChild(temp);
		temp.submit();
		return temp;
	},
	// 计算时间间隔差；
	baseDate : function(nowDate, pastDate) {
		return (nowDate.getTime() - pastDate.getTime()) / (24 * 60 * 60 * 1000);
	},

	// 返回时间差数组
	InitDate : function() {
		var date = $('.headDate').text();
		var strs = new Array(); // 定义一数组
		var strs1 = new Array(); // 定义一数组
		strs = date.split("-"); // 字符分割
		var now;
		var date;
		// 判断浏览器类型
		var mb = BaseUtility.myBrowser();
		if (mb == "Firefox") {
			var strsDate = strs[1].split(".");
			var strsDate0 = strs[0].split(".");
			// alert(strsDate[0]+"---"+strsDate[1]+"---"+strsDate[2])

			now = new Date(strsDate[0], strsDate[1] - 1, strsDate[2], "", "",
					"");
			date = new Date(strsDate0[0], strsDate0[1] - 1, strsDate0[2], "",
					"", "");
		} else {
			now = new Date(strs[1]);
			date = new Date(strs[0]);
		}

		// 构造两个日期，分别是系统时间和2013/04/08 12:43:45

		var now1 = now;

		// 调用日期差方法，求得参数日期与系统时间相差的天数

		var diff = BaseUtility.baseDate(now, date);
		for (var i = diff; i >= 0; i--) {
			var year = now1.getFullYear();
			var month = now1.getMonth() + 1; // js从0开始取
			var date = now1.getDate();
			strs1[i] = year + "-" + month + "-" + date;
			
			now1.setDate(now1.getDate() - 1);
		}
		
		return strs1;
	},
//---------------------------------------------------------------分离日期
	InitDate1:function(){
		var date = $('.headDate').text();
		var strs = new Array(); // 定义一数组
		strs = date.split("-"); // 字符分割
		return strs;
	},
	
	
	

	// 把时间 从long类型转化为字符串类型

	longConvertDate : function(time) {
	
		var now = new Date();
		now.setTime(time);
		var year = now.getFullYear();
		var month = (now.getMonth()+1).toString();
		var day = (now.getDate()).toString();
		var hours = (now.getHours()).toString();
		var minutes = (now.getMinutes()).toString();
		var seconds = (now.getSeconds()).toString();
       
		
		if (month.length == 1) {
			month = "0" + month;
		}
		if (day.length == 1) {
			day = "0" + day;
		}
		if (hours == 0) {
			hours = hours + "0";

		}
		if (minutes == 0) {
			minutes = minutes + "0";
		}
		if (seconds == 0) {
			seconds = seconds + "0";
		}

		return year + "-" + month + "-" + day + " " + hours + ":" + minutes
				+ ":" + seconds;
	},
	// ------------------------------------------------------判断是哪一种浏览器；
	myBrowser : function() {
		var userAgent = navigator.userAgent; // 取得浏览器的userAgent字符串
		var isOpera = userAgent.indexOf("Opera") > -1;
		if (isOpera) {
			return "Opera"
		}
		; // 判断是否Opera浏览器
		if (userAgent.indexOf("Firefox") > -1) {
			return "Firefox";
		} // 判断是否Firefox浏览器
		if (userAgent.indexOf("Chrome") > -1) {
			return "Chrome";
		}
		if (userAgent.indexOf("Safari") > -1) {
			return "Safari";
		} // 判断是否Safari浏览器
		if (userAgent.indexOf("compatible") > -1
				&& userAgent.indexOf("MSIE") > -1 && !isOpera) {
			return "IE";
		}
		; // 判断是否IE浏览器
	}
};

// ----------------------------------------------------------地区选择
$(".fl").bind('click', function() {
	var city1 = $("#city1 option:selected").text();
	var city2 = $("#city2 option:selected").text();
	var city3 = $("#city3 option:selected").text();

	var cityCode1 = $("#city1 option:selected").attr("value");
	var cityCode2 = $("#city2 option:selected").attr("value");
	var cityCode3 = $("#city3 option:selected").attr("value");

	var city4 = city1 + "-" + city2 + "-" + city3;

	var cityCode4 = cityCode1 + cityCode2 + cityCode3;

	if (city1 == "全国各个地区") {
		$('.model6').attr("value", cityCode1);
		$('.model6').html(city1);
	} else {

		$('.model6').attr("value", cityCode4);
		$('.model6').html(city4);
	}

	BaseUtility.deleteCss();

});

// ---------------------------------------------------型号选择；

$(".model").bind('click', function() {
	var model = $(this).text();
	var a = $(this).attr("value");

	$('.model1').html(model);

	$('.model1').attr("value", a);
	BaseUtility.deleteCss();

});
// -----------------------------------------------------日期选择 1
$(".fl2").bind('click', function() {

	var city1 = $("#year1 option:selected").val();
	var city2 = $("#month1 option:selected").val();
	var city3 = $("#day1 option:selected").val();
	var city4 = city1 + "." + city2 + "." + city3;
	var city5 = $("#year2 option:selected").val();
	var city6 = $("#month2 option:selected").val();
	var city7 = $("#day2 option:selected").val();
	var city8 = city5 + "." + city6 + "." + city7;
	$('.headDate').html(city4 + "-" + city8);
	BaseUtility.deleteCss();
});

// --------------------------------------------------日期选择2

$(".fl22").bind('click', function() {

	var city1 = $("#year11 option:selected").val();
	var city2 = $("#month11 option:selected").val();
	var city3 = $("#day11 option:selected").val();
	var city4 = city1 + "." + city2 + "." + city3;

	var city5 = $("#year22 option:selected").val();
	var city6 = $("#month22 option:selected").val();
	var city7 = $("#day22 option:selected").val();
	var city8 = city5 + "." + city6 + "." + city7;
	$('.headDate1').html(city4 + "-" + city8);
	
	$('.headDate1-video').html(city4 + "-" + city8);
	
	BaseUtility.deleteCss();
});

//-------------------------------------------用户界面时间确定事件；
//-----------------------------------------------------日期选择 1
$(".confirm-car-diver").bind('click', function() {

//	var city1 = $("#year1 option:selected").val();
//	var city2 = $("#month1 option:selected").val();
//	var city3 = $("#day1 option:selected").val();
//	var city4 = city1 + "." + city2 + "." + city3;
	
	var city5 = $("#year-car2 option:selected").val();
	var city6 = $("#month-car2 option:selected").val();
	var city7 = $("#day-car2 option:selected").val();
	var city8 = city5 + "." + city6 + "." + city7;	
	
	//$('.headDate-car-grade').html(city4 + "-" + city8);
	//now1.setDate(now1.getDate() - 1);
	
	
	 var date=null;
	 
	 var mb = BaseUtility.myBrowser();
		if (mb == "Firefox") {
			
			// alert(strsDate[0]+"---"+strsDate[1]+"---"+strsDate[2])

			date = new Date(city5, city6, city7, "", "","");
			
		} else {
			
			date = new Date(city8);
		}
	 var date1 =new Date();
	   date.setDate(date.getDate() - 7);
	   var year = date.getFullYear();
		var month = (date.getMonth()).toString();
		var day = (date.getDate()).toString();
	   var city4=year + "." + month + "." + day;
	   
	   $('.headDate-car-grade').html(city4 + "-" + city8)
	BaseUtility.deleteCarCss();
});








// ------------------------------------------------------下拉框取消效果；
$(".cancel").bind('click', function() {

	BaseUtility.deleteCss();

	
});







// -------------------------------------------------显示下拉框;
// ----------------------设备
$(".all-device")
		.bind(
				'click',
				function() {
					if (selectDevice == "true") {
						$(".activeusers").css("overflow", "visible");

						$(".activeusers .preferences-box")
								.css(
										{
											"overflow" : "visible",
											"border-top-color" : "#1463ce",
											"background" : "#ffffff",
											/*"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px rgba(0, 0, 0, 0.2),0 0px 3px -6px transparent, 3px 0 6px -3px rgba(0, 0, 0, 0.2)"*/
										});
					$(".activeusers .preferences-bodyer")
								.css(
										{
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px transparent, 0 3px 6px -3px rgba(0, 0, 0, 0.2), 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});
					/*
						$(".activeusers .preferences-head").css({
							"color" : "#1463ce"
						});
							*/
						$(".activeusers .preferences-head::after")
								.css(
										{
											"border-color" : "#1463ce transparent transparent transparent"
										});
					
						
						selectDevice = "false"

						$(".time1").css("overflow", "hidden");
						$(".time1 .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".time1 .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".time1 .preferences-head").css({
							"color" : ""
						});
						$(".time1 .preferences-head::after").css({
							"border-color" : ""
						});
						selectDate = "true"

						$(".area").css("overflow", "hidden");
						$(".area .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-head").css({
							"color" : ""
						});
						$(".area .preferences-head::after").css({
							"border-color" : ""
						});
						selectArea = "true";

					} else {
						$(".activeusers").css("overflow", "hidden");
						$(".activeusers .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});

						$(".activeusers .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});

						$(".activeusers .preferences-head").css({
							"color" : ""
						});
						$(".activeusers .preferences-head::after").css({
							"border-color" : ""
						});
						selectDevice = "true"
					}

				});
// ----------------------时间
$(".all-date")
		.bind(
				'click',
				function() {
					if (selectDate == "true") {
						$(".time1").css("overflow", "visible");

						$(".time1 .preferences-box")
								.css(
										{
											"overflow" : "visible",
											"border-top-color" : "#1463ce",
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px rgba(0, 0, 0, 0.2),0 0px 3px -6px transparent, 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});
						$(".time1 .preferences-bodyer")
								.css(
										{
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px transparent, 0 3px 6px -3px rgba(0, 0, 0, 0.2), 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});

				/*		$(".time1 .preferences-head").css({
							"color" : "#1463ce"
						});*/
						$(".time1 .preferences-head::after")
								.css(
										{
											"border-color" : "#1463ce transparent transparent transparent"
										});
						selectDate = "false"

						$(".activeusers").css("overflow", "hidden");
						$(".activeusers .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});

						$(".activeusers .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});

						$(".activeusers .preferences-head").css({
							"color" : ""
						});
						$(".activeusers .preferences-head::after").css({
							"border-color" : ""
						});
						selectDevice = "true"

						$(".area").css("overflow", "hidden");
						$(".area .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-head").css({
							"color" : ""
						});
						$(".area .preferences-head::after").css({
							"border-color" : ""
						});
						selectArea = "true";

					} else {
						$(".time1").css("overflow", "hidden");
						$(".time1 .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".time1 .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".time1 .preferences-head").css({
							"color" : ""
						});
						$(".time1 .preferences-head::after").css({
							"border-color" : ""
						});
						selectDate = "true"
					}
				});

// ---------------------地区
$(".all-area")
		.bind(
				'click',
				function() {
					if (selectArea == "true") {
						$(".area").css("overflow", "visible");
						$(".area .preferences-box")
								.css(
										{
											"overflow" : "visible",
											"border-top-color" : "#1463ce",
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px rgba(0, 0, 0, 0.2),0 0px 3px -6px transparent, 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});
						$(".area .preferences-bodyer")
								.css(
										{
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px transparent, 0 3px 6px -3px rgba(0, 0, 0, 0.2), 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});
				/*		$(".area .preferences-head").css({
							"color" : "#1463ce"
						});*/
						$(".area .preferences-head::after")
								.css(
										{
											"border-color" : "#1463ce transparent transparent transparent"
										});
						selectArea = "false";

						$(".time").css("overflow", "hidden");
						$(".time .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".time .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".time .preferences-head").css({
							"color" : ""
						});
						$(".time .preferences-head::after").css({
							"border-color" : ""
						});
						selectDate = "true"

						$(".activeusers").css("overflow", "hidden");
						$(".activeusers .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".activeusers .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".activeusers .preferences-head").css({
							"color" : ""
						});
						$(".activeusers .preferences-head::after").css({
							"border-color" : ""
						});
						selectDevice = "true"
					} else {
						$(".area").css("overflow", "hidden");
						$(".area .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-head").css({
							"color" : ""
						});
						$(".area .preferences-head::after").css({
							"border-color" : ""
						});
						selectArea = "true";
					}
				});

// -----------------------------------------------------地区时间；
$(".all-date1")
		.bind(
				'click',
				function() {
					if (selectDate1 == "true") {
						$(".time2").css("overflow", "visible");

						$(".time2 .preferences-box")
								.css(
										{
											"overflow" : "visible",
											"border-top-color" : "#1463ce",
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px rgba(0, 0, 0, 0.2),0 0px 3px -6px transparent, 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});
						$(".time2 .preferences-bodyer")
								.css(
										{
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px transparent, 0 3px 6px -3px rgba(0, 0, 0, 0.2), 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});

						$(".time2 .preferences-head").css({
							"color" : "#1463ce"
						});
						$(".time2 .preferences-head::after")
								.css(
										{
											"border-color" : "#1463ce transparent transparent transparent"
										});
						selectDate1 = "false"

					} else {
						$(".time2").css("overflow", "hidden");
						$(".time2 .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".time2 .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".time2 .preferences-head").css({
							"color" : ""
						});
						$(".time2 .preferences-head::after").css({
							"border-color" : ""
						});
						selectDate1 = "true"
					}
				});




//------------------------------------------------------驾驶行为
//----------------------时间
$(".headDate-car-grade").bind(
				'click',
				function() {
					if (selectDiverDate == "true") {
						$(".time-car-diver").css("overflow", "visible");

						$(".time-car-diver .preferences-box")
								.css(
										{
											"overflow" : "visible",
											"border-top-color" : "#1463ce",
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px rgba(0, 0, 0, 0.2),0 0px 3px -6px transparent, 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});
						$(".time-car-diver .preferences-bodyer")
								.css(
										{
											"background" : "#ffffff",
											"box-shadow" : "-3px 0 6px -3px rgba(0, 0, 0, 0.2), 0 0 3px -3px transparent, 0 3px 6px -3px rgba(0, 0, 0, 0.2), 3px 0 6px -3px rgba(0, 0, 0, 0.2)"
										});

						$(".time-car-diver .preferences-head::after")
								.css(
										{
											"border-color" : "#1463ce transparent transparent transparent"
										});
						selectDiverDate = "false"

						$(".activeusers").css("overflow", "hidden");
						$(".activeusers .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});

						$(".activeusers .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});

						$(".activeusers .preferences-head").css({
							"color" : ""
						});
						$(".activeusers .preferences-head::after").css({
							"border-color" : ""
						});
						selectDevice = "true"

						$(".area").css("overflow", "hidden");
						$(".area .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".area .preferences-head").css({
							"color" : ""
						});
						$(".area .preferences-head::after").css({
							"border-color" : ""
						});
						selectArea = "true";

					} else {
						$(".time-car-diver").css("overflow", "hidden");
						$(".time-car-diver .preferences-box").css({
							"overflow" : "hidden",
							"border-top-color" : "",
							"background" : "",
							"box-shadow" : ""
						});
						$(".time-car-diver .preferences-bodyer").css({
							"background" : "",
							"box-shadow" : ""
						});
						$(".time-car-diver .preferences-head").css({
							"color" : ""
						});
						$(".time-car-diver .preferences-head::after").css({
							"border-color" : ""
						});
						selectDiverDate = "true"
					}
				});











// -----------------------------------------------------动态模态框；
/*
 * $("#dynamic-dialog").bind('click',function(){
 * $("#dynamic-dialog").removeClass("dialog");
 * 
 * });
 */

