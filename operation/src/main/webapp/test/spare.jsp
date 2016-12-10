<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>中国移动4G车联网</title>
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
    
</head>
<body>
	<nav class="navbar navbar-inverse" role="navigation">
    	<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
			  	</button>
			  	<a class="navbar-brand" href="#">
					<img id="logo" src="${contextPath}/images/obd_logo.png">
				</a>
			</div>
        	<div id="navbar" class="navbar-collapse collapse">
         		<ul class="nav navbar-nav">
			        <li><a href="${contextPath1}deviceControl">设备监控</a></li>
					<li><a href="${contextPath3}spareMobleAll">备用机管理</a></li>
	  	 		</ul>
          		<ul class="nav navbar-nav navbar-right">
            		<li class="dropdown">
              			<a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">个人中心<span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
							<li id="personalCenter1"><a href="${contextPath2}firstAccoutControllGroup">进入个人中心</a></li>
							<li id="personalCenter2"><a href="${contextPath2}secondDeviceClient">进入个人中心</a></li>
							<li><a id="user_dropout">退出登录</a></li>
						</ul>
            		</li>
          		</ul>
			  	<form class="navbar-form navbar-right" role="search">
					<div class="form-group">
				  		<input type="text" class="form-control" placeholder="Search">
				  		<button type="submit" class="btn btn-default">搜索</button>
					</div>
			  	</form>
        	</div>
    	</div>
    </nav>
    
    <div class="container-fluid">
    	<div class="row">
    		<div class="col-sm-6 col-md-6">
    			<div class="qgfh-outbox">
    				<div class="qgfh-inbox">
    					<div id="main" style="width: 100%; height: 100%;"></div>
    				</div>
    			</div>
			</div>
    		<div class="col-sm-6 col-md-6">
    			<div class="qgfh-outbox">
    				<div class="qgfh-inbox">
    					<div id="main2" style="width: 100%; height: 100%;"></div>
    				</div>
    			</div>
			</div>
    	</div>
    	
        	<script>
    	//获取跳转链接参数；
    	var mapName;
    	var regionCode;
    		//---------------获取链接参数	
	   function GetQueryString(key){
	        var reg = new RegExp("(^|&)"+key+"=([^&]*)(&|$)");
	        var result = window.location.search.substr(1).match(reg);
	        return result?decodeURIComponent(result[2]):null;
	      }
    	
    	mapName=GetQueryString("mapName");
    	regionCode=GetQueryString("regionCode");
    	regionCode=regionCode.substring(0,2);
		// 基于准备好的dom，初始化echarts实例
        var myChart = echarts.init(document.getElementById('main'));
        // spareShowMap
	 	var data1=[];
		var data2=[];
		var data3=[];
		var data4=[];
	     $.post("${contextPath}/controller/spareShowProvinceMap", {
			code : regionCode
		}, function(result) {
			if(result.state=="0")
				{
				var data =result.result;
				for(var i=0;i<data.length;i++)
					{
					var a=data[i].data[0].sendNumber;
					a=a*0.15;
					var jsonData1 = {
							"name" : data[i].city,
							"value" : data[i].data[0].sendNumber
						};
					var jsonData2 = {
							"name" : data[i].city,
							"value" : data[i].data[0].installNumber
						};
					var jsonData3 = {
							"name" : data[i].city,
							"value" : data[i].data[0].activeNumber
						};
					var jsonData4 = {
							"name" : data[i].city,
							"value" : a
						};
				     data1[i]=jsonData1;
					 data2[i]=jsonData2;
					 data3[i]=jsonData3;
					 data4[i]=jsonData4;
					}
				}
			$.get('${contextPath}/js/map/' + mapName + '.json', function(mapJson){
				echarts.registerMap(mapName, mapJson);
				myChart.clear();
				var option = {
						tooltip: {
							trigger: 'item',
							formatter: function(params) {  
								  var res = params.name+'<br/>';
								  var myseries = option.series;  
								  for (var i = 0; i < myseries.length; i++) {  
									  if(myseries[i].name){
										  res+= myseries[i].name;  
										  for(var j=0;j<myseries[i].data.length;j++){  
											  if(myseries[i].data[j].name==params.name){  
												res += ' : '+myseries[i].data[j].value+'</br>';  
											  }
										  }
									  }
								  }  
								  return res;  
							}  
						},
						series: [
									{
										name: '已发货数量',
										type: 'map',
										mapType: mapName,
										roam: false,
										label: {
											normal: {
												show: true
											},
											emphasis: {
												show: true
											}
										},
										data:data1
									},
									{
										name: '已激活数量',
										type: 'map',
										mapType: mapName,
										label: {
											normal: {
												show: true
											},
											emphasis: {
												show: true
											}
										},
										data:data3
									},
									{
										name: '备用机数量',
										type: 'map',
										mapType: mapName,
										label: {
											normal: {
												show: true
											},
											emphasis: {
												show: true
											}
										},
										data:data4
									},
									{
										name: '已安装数量',
										type: 'map',
										mapType: mapName,
										label: {
											normal: {
												show: true
											},
											emphasis: {
												show: true
											}
										},
										data:data2
									}
								]
			};
				myChart.setOption(option);
			});
		});
			
			//统计数据；
        $.post("${contextPath}/controller/spareShow", {
				code : regionCode
			}, function(result) {
				var data11=new Array();
				var data2=new Array();
				 data2[0]="null";
				 data3=new Array();
				 data3[0]="null";
				 data3[1]="null";
				 data4=new Array();
				 data4[0]="null";
				 data4[1]="null";
				 data4[2]="null";
				 var data1;
				if(result.state=="0")
					{
					var data =result.result;
					 data1=data[0].sendNumber;
					 data11[0]=data1*0.15;
					 data2[1]=data[0].installNumber;
					 data3[2]=data[0].activeNumber;
					 data4[3]=data[0].bindingNumber;
					}
				var date=new Date();
				var year = date.getFullYear();
				var month = date.getMonth() + 1; // js从0开始取
				var date = date.getDate();
				var time = year + "-" + month + "-" + date;
				
				var option2 = {
						title: {
							text: '已发货数量：'+data1+'台',
							subtext: '数据截至时间：'+time,
							left: 'center'
						},
						grid: {
							left: '3%',
							right: '4%',
							bottom: '3%',
							containLabel: true
						},
						xAxis:  {
							type: 'category',
							data: ['备用机','已安装','已激活','微信绑定']
						},
						yAxis: {
							type: 'value'
						},
						series: [
							{
								name: '备用机',
								type: 'bar',
								stack: '总量',
								label: {
									normal: {
										show: true,
										position: 'top'
									}
								},
								data: data11,
							},
							{
								name: '已安装',
								type: 'bar',
								stack: '总量',
								label: {
									normal: {
										show: true,
										position: 'top'
									}
								},
								data: data2
							},
							{
								name: '已激活',
								type: 'bar',
								stack: '总量',
								label: {
									normal: {
										show: true,
										position: 'top'
									}
								},
								data: data3
							},
							{
								name: '微信绑定',
								type: 'bar',
								stack: '总量',
								label: {
									normal: {
										show: true,
										position: 'top'
									}
								},
								data: data4
							}
						]
					};
					var myChart2 = echarts.init(document.getElementById('main2'));
					myChart2.setOption(option2);
			});
	</script>
	
	
	
    
		<div class="row">
        	<div class="col-sm-12 col-md-12 main qgfhsq qgfhsq-box">
    
				<div class="bs-tabs">
				
					<ul id="myTab" class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a  href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">全国备用机统计</a></li>
						<li role="presentation" class=""><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">全国发货申请统计</a></li>
					</ul>
					<div id="myTabContent" class="tab-content">
						<div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
							<div class="panel panel-default">
								<div class="panel-heading clearfix">
									<form class="navbar-form navbar-left" role="search">
										<div class="form-group">
											<input type="text" class="form-control" placeholder="Search" id="chang-search">
										</div>
									</form>
									<button id="btn-search" class="btn btn-primary">搜索</button>
									<button id="testChange" class="btn btn-default">更换备用机</button>
									<button id="btn-spareExport" class="btn btn-default">
									<a href="${contextPath}/controller/spareExport">导出</a>
									
									</button>
								</div>
								<!--全国备用机统计表格模板-->
								<table  id="qgbyjtjTable"></table>
							</div>
						</div>
						
						<div role="tabpanel" class="tab-pane fade" id="profile" aria-labelledby="profile-tab">
							<div class="panel panel-default">
								<div class="panel-heading clearfix">
									<button id="testAdd" class="btn btn-default">添加</button>
								</div>
								<!--全国发货申请统计模板-->
								<table id="qgfhsqtjTable"></table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--更换备用机模态弹窗-->
	<div class="modal fade" id="ghbyj" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">更换备用机</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-3 control-label">分公司地区</label>
							<div class="col-sm-9">
								<div class="row">
								 <div class="col-sm-4">
									 <select name="city11" id="city11" class="form-control"
						             onChange="findsubcity('city11','city22')">
									<!-- 	<option value="11">北京市</option>
										<option value="12">天津市</option> -->
										<option >请选择省</option>
										<option value="13">河北省</option>
										<option value="14">山西省</option>
										<option value="15">内蒙古自治区</option>
										<option value="21">辽宁省</option>
										<option value="22">吉林省</option>
										<option value="23">黑龙江省</option>
										<option value="31">上海市</option>
										<option value="32">江苏省</option>
										<option value="33">浙江省</option>
										<option value="34">安徽省</option>
										<option value="35">福建省</option>
										<option value="36">江西省</option>
										<option value="37">山东省</option>
										<option value="41">河南省</option>
										<option value="42">湖北省</option>
										<option value="43">湖南省</option>
										<option value="44">广东省</option>
										<option value="45">广西壮族自治区</option>
										<option value="46">海南省</option>
										<option value="50">重庆市</option>
										<option value="51">四川省</option>
										<option value="52">贵州省</option>
										<option value="53">云南省</option>
										<option value="54">西藏自治区</option>
										<option value="61">陕西省</option>
										<option value="62">甘肃省</option>
										<option value="63">青海省</option>
										<option value="64">宁夏回族自治区</option>
										<option value="65">新疆维吾尔自治区</option>
										<option value="71">台湾省</option>
										<option value="81">香港特别行政区</option>
										<option value="82">澳门特别行政区</option>
										</select>
									</div>
									<div class="col-sm-4">
										<select class="form-control" name="city22" id="city22"
											onChange="findsubcity1('city22','city33')">
						                    <option value="">请选择市</option>
										</select>
									</div>
									<div class="col-sm-4" >
										<select class="form-control" name="city33" id="city33">
										<option value="">请选择区/县</option>
										</select>
									</div>
								</div>
							</div>
					  	</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" >备用机产品型号</label>
							<div class="col-sm-9">
								<select class="form-control" id="change-model">
									<option value="R611">R611</option>
								</select>
							</div>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">备用机IMEI</label>
							<div class="col-sm-9 qgfhsq-position">
								<input type="text" class="form-control" placeholder="" id="change-imei">
							</div>
					  	</div>

					  	<div class="form-group">
							<label class="col-sm-3 control-label">替换机器IMEI</label>
							<div class="col-sm-9 qgfhsq-position">
								<input type="text" class="form-control" placeholder="" id="respace-imei">
							</div>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">备注信息</label>
							<div class="col-sm-9">
								<input type="text" class="form-control"placeholder="" id="change-remark">
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button"  id="change-Btn" class="btn btn-primary change-Btn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	<!--更换备用机模态弹窗-->
		<!--更换备用机模态弹窗-->
	<div class="modal fade" id="ghbyj1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">更换备用机</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-3 control-label">分公司地区</label>
							<div class="col-sm-9">
								<div class="row">
								 <div class="col-sm-4">
									 <select name="city111" id="city111" class="form-control"
						             onChange="findsubcity('city111','city222')">
										<!-- <option value="11">北京市</option>
										<option value="12">天津市</option> -->
										<option >请选择省</option>
										<option value="13">河北省</option>
										<option value="14">山西省</option>
										<option value="15">内蒙古自治区</option>
										<option value="21">辽宁省</option>
										<option value="22">吉林省</option>
										<option value="23">黑龙江省</option>
										<option value="31">上海市</option>
										<option value="32">江苏省</option>
										<option value="33">浙江省</option>
										<option value="34">安徽省</option>
										<option value="35">福建省</option>
										<option value="36">江西省</option>
										<option value="37">山东省</option>
										<option value="41">河南省</option>
										<option value="42">湖北省</option>
										<option value="43">湖南省</option>
										<option value="44">广东省</option>
										<option value="45">广西壮族自治区</option>
										<option value="46">海南省</option>
										<option value="50">重庆市</option>
										<option value="51">四川省</option>
										<option value="52">贵州省</option>
										<option value="53">云南省</option>
										<option value="54">西藏自治区</option>
										<option value="61">陕西省</option>
										<option value="62">甘肃省</option>
										<option value="63">青海省</option>
										<option value="64">宁夏回族自治区</option>
										<option value="65">新疆维吾尔自治区</option>
										<option value="71">台湾省</option>
										<option value="81">香港特别行政区</option>
										<option value="82">澳门特别行政区</option>
										</select>
									</div>
									<div class="col-sm-4">
										<select class="form-control" name="city222" id="city222"
											onChange="findsubcity1('city222','city333')">
						                    <option value="">请选择市</option>
										</select>
									</div>
									<div class="col-sm-4" >
										<select class="form-control" name="city333" id="city333">
										<option value="">请选择区/县</option>
										</select>
									</div>
								</div>
							</div>
					  	</div>
						<div class="form-group">
							<label class="col-sm-3 control-label" >备用机产品型号</label>
							<div class="col-sm-9">
								<select class="form-control" id="change-model1">
									<option value="R611">R611</option>
								</select>
							</div>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">备用机IMEI</label>
							<div class="col-sm-9 qgfhsq-position">
								<input type="text" class="form-control" placeholder="" id="change-imei1">
										<div class="list-group" id="first-search-fuzzy">
										<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1" id="first-search-fuzzy3">
											<li role="presentation"><a role="menuitem" tabindex="-1">Java</a>
											</li>
										</ul>
									   </div>
							</div>
					  	</div>

					  	<div class="form-group">
							<label class="col-sm-3 control-label">替换机器IMEI</label>
							<div class="col-sm-9 qgfhsq-position">
								<input type="text" class="form-control" placeholder="" id="respace-imei1">
							</div>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">备注信息</label>
							<div class="col-sm-9">
								<input type="text" class="form-control"placeholder="" id="change-remark1">
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button"  id="change-Btn1" class="btn btn-primary change-Btn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
<!--发货确认模态弹窗-->
	<div class="modal fade" id="fhqr" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">发货确认</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-3 control-label">分公司地区</label>
							<div class="col-sm-8">
								<div class="row">
								<div class="col-sm-4">
									 <select name="city1" id="city1" class="form-control"
						              onChange="findsubcity('city1','city2')">
										<!-- <option value="11">北京市</option>
										<option value="12">天津市</option> -->
										<option >请选择省</option>
										<option value="13">河北省</option>
										<option value="14">山西省</option>
										<option value="15">内蒙古自治区</option>
										<option value="21">辽宁省</option>
										<option value="22">吉林省</option>
										<option value="23">黑龙江省</option>
										<option value="31">上海市</option>
										<option value="32">江苏省</option>
										<option value="33">浙江省</option>
										<option value="34">安徽省</option>
										<option value="35">福建省</option>
										<option value="36">江西省</option>
										<option value="37">山东省</option>
										<option value="41">河南省</option>
										<option value="42">湖北省</option>
										<option value="43">湖南省</option>
										<option value="44">广东省</option>
										<option value="45">广西壮族自治区</option>
										<option value="46">海南省</option>
										<option value="50">重庆市</option>
										<option value="51">四川省</option>
										<option value="52">贵州省</option>
										<option value="53">云南省</option>
										<option value="54">西藏自治区</option>
										<option value="61">陕西省</option>
										<option value="62">甘肃省</option>
										<option value="63">青海省</option>
										<option value="64">宁夏回族自治区</option>
										<option value="65">新疆维吾尔自治区</option>
										<option value="71">台湾省</option>
										<option value="81">香港特别行政区</option>
										<option value="82">澳门特别行政区</option>
										</select>
									</div>
									<div class="col-sm-4">
										<select class="form-control" name="city2" id="city2"
											onChange="findsubcity1('city2','city3')">
						                    <option value="volvo">请选择市</option>
										</select>
									</div>
									<div class="col-sm-4" >
										<select class="form-control" name="city3" id="city3">
										
										<option value="volvo">请选择区/县</option>
										</select>
									</div>
								</div>
								
							</div>
					  	</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">具体地址</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="send-address">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">发货数量</label>
							<div class="col-sm-8">
								<input type="text" class="form-control"  id="send-number" >
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	
					  	
					  	
					  	<div class="form-group">
							<label class="col-sm-3 control-label">发货产品型号</label>
							<div class="col-sm-8">
								<select class="form-control" id="send-model">
									<option value="R611">R611</option>
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">机器类型</label>
							<div class="col-sm-8">
								<div style="margin-right: 10px;" class="radio pull-left">
									<label>
								  		<input type="radio" name="test"  value="0" checked="">
								  		正常发货
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="test"  value="1" checked="true">
								  		备用机
									</label>
								</div>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">快递单号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="send-expressId">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label" id="upload-state">导入IMEI号</label>
							<div class="col-sm-8">
								<input type="file" name="file" id="exampleInputFile">
								<p class="help-block"><a href="${contextPath}/controller/sendFileDownload">下载文件模板</a></p>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否收货</label>
							<div class="col-sm-9">
								<div style="margin-right: 10px;" class="radio2 pull-left">
									<label>
								  		<input type="radio" name="test1"  value="1">
								  		是
									</label>
								</div>
								<div class="radio2 pull-left">
									<label>
								  		<input type="radio" name="test1"  value="0" checked="true">
								  		否
									</label>
								</div>
								  
								
								
								
								
								<div style="clear: both;"></div>
								<p class="help-block">收到货后，导入的IMEI号才会显示在系统里</p>
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" id ="send-confirm" class="btn btn-primary saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	<!--添加发货确认模态弹窗-->
	<div class="modal fade" id="fhqr1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">发货确认</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-3 control-label">分公司地区</label>
							<div class="col-sm-8">
								<div class="row">
								<div class="col-sm-4">
									 <select name="add-city1" id="add-city1" class="form-control"
						onChange="findsubcity('add-city1','add-city2')">
								<!-- 		<option value="11">北京市</option>
										<option value="12">天津市</option> -->
										<option >请选择省</option>
										<option value="13">河北省</option>
										<option value="14">山西省</option>
										<option value="15">内蒙古自治区</option>
										<option value="21">辽宁省</option>
										<option value="22">吉林省</option>
										<option value="23">黑龙江省</option>
										<option value="31">上海市</option>
										<option value="32">江苏省</option>
										<option value="33">浙江省</option>
										<option value="34">安徽省</option>
										<option value="35">福建省</option>
										<option value="36">江西省</option>
										<option value="37">山东省</option>
										<option value="41">河南省</option>
										<option value="42">湖北省</option>
										<option value="43">湖南省</option>
										<option value="44">广东省</option>
										<option value="45">广西壮族自治区</option>
										<option value="46">海南省</option>
										<option value="50">重庆市</option>
										<option value="51">四川省</option>
										<option value="52">贵州省</option>
										<option value="53">云南省</option>
										<option value="54">西藏自治区</option>
										<option value="61">陕西省</option>
										<option value="62">甘肃省</option>
										<option value="63">青海省</option>
										<option value="64">宁夏回族自治区</option>
										<option value="65">新疆维吾尔自治区</option>
										<option value="71">台湾省</option>
										<option value="81">香港特别行政区</option>
										<option value="82">澳门特别行政区</option>
										</select>
									</div>
									<div class="col-sm-4">
										<select class="form-control" name="add-city2" id="add-city2"
											onChange="findsubcity1('add-city2','add-city3')">
						                    <option value="volvo">请选择市</option>
										</select>
									</div>
									<div class="col-sm-4" >
										<select class="form-control" name="add-city3" id="add-city3">
										<option value="volvo">请选择区/县</option>
										</select>
									</div>
								</div>
								
							</div>
					  	</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">具体地址</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="add-send-address">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
						
						
						<div class="form-group">
							<label class="col-sm-3 control-label">收货人</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="add-send-receiver">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	
					  	<div class="form-group">
							<label class="col-sm-3 control-label">发货数量</label>
							<div class="col-sm-8">
								<input type="text" class="form-control"  id="add-send-number" >
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">发货产品型号</label>
							<div class="col-sm-8">
								<select class="form-control" id="add-send-model">
									<option value="R611">R611</option>
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">机器类型</label>
							<div class="col-sm-8">
								<div style="margin-right: 10px;" class="radio pull-left">
									<label>
								  		<input type="radio" name="add-test1"  value="0" checked="">
								  		正常发货
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="add-test1"  value="1" checked="true">
								  		备用机
									</label>
								</div>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">快递单号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="add-send-expressId">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label" id="add-upload-state">导入IMEI号</label>
							<div class="col-sm-8">
								<input type="file" name="file1" id="add-exampleInputFile">
								<p class="help-block"><a href="${contextPath}/controller/sendFileDownload">下载文件模板</a></p>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否收货</label>
							<div class="col-sm-9">
								<div style="margin-right: 10px;" class="radio1 pull-left">
									<label>
								  		<input type="radio" name="add-test2"  value="1">
								  		是
									</label>
								</div>
								<div class="radio1 pull-left">
									<label>
								  		<input type="radio" name="add-test2"  value="0" checked="true">
								  		否
									</label>
								</div>
								<div style="clear: both;"></div>
								<p class="help-block">收到货后，导入的IMEI号才会显示在系统里</p>
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" id ="add-send-confirm" class="btn btn-primary saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<script id="firstsearchGroup" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
                <li  role="presentation" data-n_id={{d[i].n_id}} data-c_spare_imei={{d[i].c_spare_imei}} >
				<a role="menuitem" tabindex="-1" >{{d[i].c_spare_imei}}</a>
				</li> 
        {{# } }}
</script>
	<!--发货申请模态弹窗-->
	<script>
	var changeId=null;
	var flag=true;
	var regionAll=null;
	//导出数据；
	$("#btn-spareExport").click(function(){
		location.href="${contextPath}/controller/spareExport";  
	});
	//交换机信息查询；
	$("#btn-search").click(function(){
		var imei=$("#chang-search").val();
		$.post("${contextPath}/controller/searchSpare", {
			spareImei : imei,
			code:regionCode
		}, function(data) {
			if (data.state == "1") {
				alert("没有此imei号");
			} else {
				$('#qgbyjtjTable').bootstrapTable('load', data);
			}
			
			
			
		});
		
		
	});
	
	

	//修改交换表；
	$("#change-Btn").click(function(){
		   var model = $("#change-model option:selected").text();
		   var changeImei=$("#change-imei").val();
		   var respaceImei=$("#respace-imei").val();
		   var remark=$("#change-remark").val();
			   
			var obj = {};
			obj['respaceImei'] = respaceImei;
			obj['model'] = model;
			obj['remark'] = remark;
			obj['spareChangId'] = changeId;
			
	  		$.ajax({
		        url: '${contextPath}/controller/spareChangEdit',
		        method: 'post',
		        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
		        data: JSON.stringify(obj), // 以json字符串方式传递
		        success: function(data) {
		            if(data.state!="0")
		            {
		            	alert("修改失败，参数填写错误");	
		            }else
	            	{
	            	alert("替换申请成功");	
	            	$('#qgbyjtjTable').bootstrapTable('refresh', {
						silent : true
					});
	            	}
		            $("#ghbyj").modal("hide");
		        },
		    });   
	});
	function showData(data, tmpl, target){
		var gettpl = $(tmpl).html();
		laytpl(gettpl).render(data, function(html){
	  		$(target).html(html)
		});
	} 
	//监听备用机imei变化；
		$('#change-imei1').bind('input propertychange',function() {
				var data = $(this).val();
				var cityCode1=    $("#city111 option:selected").attr("value");
				var cityCode2=    $("#city222 option:selected").attr("value");
				var cityCode3=    $("#city333 option:selected").attr("value");
				var region=cityCode1+cityCode2+cityCode3;
				regionAll=region;
				//实时模糊查询
				if (data.length > 0) {
					$.post("${contextPath}/controller/fuzzySearchSpareChang", {
						spareImei : data,
						region:region,
					}, function(data) {
						if (data.state == "0") {
							showData(data.result, "#firstsearchGroup","#first-search-fuzzy3");
							$('#first-search-fuzzy').show();
							$('#first-search-fuzzy3').show();
						} else {
							showData(data.result, "#firstsearchGroup",
									"#first-search-fuzzy3");
							$('#first-search-fuzzy').hide();
							$('#first-search-fuzzy3').hide();
						}

					});
				} else {
					$('#first-search-fuzzy').hide();
					$('#first-search-fuzzy3').hide();
				}
			});
		//模糊查询点击事件；
		$("#first-search-fuzzy ul").on("click", "li", function() {
			var imei = $(this).data("c_spare_imei");
			var changId1= $(this).data("n_id");
			$("#change-imei1").val(imei);
			changeId=changId1;
			$('#first-search-fuzzy').hide();
			$('#first-search-fuzzy3').hide();
		});
		//-------------------------------点击空白处
		$("body").bind('click', function() {
			$('#first-search-fuzzy').hide();
			$('#first-search-fuzzy3').hide();
		});
	//修改交换表；
	$("#change-Btn1").click(function(){
		   var model = $("#change-model1 option:selected").text();
		   var changeImei=$("#change-imei1").val();
		   var respaceImei=$("#respace-imei1").val();
		   var remark=$("#change-remark1").val();
			   
			var obj = {};
			obj['respaceImei'] = respaceImei;
			obj['model'] = model;
			obj['remark'] = remark;
			obj['spareChangId'] = changeId;
			
	  		$.ajax({
		        url: '${contextPath}/controller/spareChangEdit',
		        method: 'post',
		        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
		        data: JSON.stringify(obj), // 以json字符串方式传递
		        success: function(data) {
		            if(data.state!="0")
		            {
		            	alert("修改失败，参数填写错误");	
		            }else
	            	{
	            	alert("替换申请成功");	
	            	$('#qgbyjtjTable').bootstrapTable('refresh', {
						silent : true
					});
	            	}
		            $("#ghbyj1").modal("hide");
		        },
		    });   
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	//发货申请；
		$("#send-btn").click(function(){
	 		   var city1 = $("#city1 option:selected").text();
			   var city2 = $("#city2 option:selected").text();
			   var city3 = $("#city3 option:selected").text();
			   
			   var cityCode1=    $("#city1 option:selected").attr("value");
			   var cityCode2=    $("#city2 option:selected").attr("value");
			   var cityCode3=    $("#city3 option:selected").attr("value");
			   var area=city1+"-"+city2+"-"+city3;
			   var region=cityCode1+cityCode2+cityCode3;
			   var address=$("#send-address").val();
			   var receiver=$("#send-receiver").val();
			   var number =$("#send-number").val();
			   var model = $("#send-model option:selected").text();
			   var sendType = $('.radio  input[name="test"]:checked ').val();
				var obj = {};
				obj['area'] = area;
				obj['region'] = region;
				obj['address'] = address;
				obj['receiver'] = receiver;
				obj['number'] = number;
				obj['model'] = model;
				obj['sendType'] = sendType;
		  		$.ajax({
			        url: '${contextPath}/controller/sendApplication',
			        method: 'post',
			        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
			        data: JSON.stringify(obj), // 以json字符串方式传递
			        success: function(data) {
			            if(data.state!="0")
			            {
			            	alert("申请失败，参数填写错误");	
			            }else
		            	{
		            	alert("发货申请成功");	
		            	$('#qgfhsqtjTable').bootstrapTable('refresh', {
							silent : true
						});
		            	}
			            $("#fhsq").modal("hide");
			        },
			    });  
				
			});
	
		$(function(){
		
			$("#testAdd").click(function(){
				$("#fhsq").modal();
			});
			
			//全局交换信息；
			$("#testChange").click(function(){
				$("#ghbyj1").modal();
			});
			
			
			
			
			
			
		//交换机	
		
			$('#qgbyjtjTable').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/spareChangMsg",
				height : 400,
				pagination : true,
				sidePagination : "server",//服务器分页     	    
				pageSize : 10,
				pageNumber : 1,
				pageList : [ 10 ],
				queryParams : getParams,
				clickToSelect : true,//选择行即选择checkbox  
				singleSelect : true,//仅允许单选  
				columns: [
					{
						field: 'n_id',
						visible:false,
					},{
						field: 't_time',
						title: '时间',
						class: 'update-icon',
						formatter: timeFormatter
					}, 
					{
						field: 'c_area',
						title: '地区'
					}, 
					{
						field: 'c_spare_imei',
						title: '备用机IMEI号'
					},
					{
						field: 'c_respace_imei',
						title: '替换机器IMEI号'
					},
					{
						field: 'c_model',
						title: '备用机产品型号'
					},
					{
						field: 'c_remark',
						title: '备注信息'
					},
					{
						field: 'handle',
						title: '操作',
						events:'actionEvents',
						formatter: operateFormatter1
					}
				],
			});
			function timeFormatter(value, row, index){
				if(value!=null){
					value=BaseUtility.longConvertDate(value);	
				}
				return value;
			}
			function operateFormatter1(value, row, index){
				return [
					'<div class="glyphicon-box"><span class="glyphicon glyphicon-edit  glyphicon-edit1 " href="javascript:void(0)"></span></div>',
					'<div class="glyphicon-box glmoreinfo"><span class="glyphicon glyphicon-info-sign glyphicon-info-sign2" id=change'+row.n_id+'></span></div>'
				].join('');
			}
			$('#qgbyjtjTable').on('page-change.bs.table', function(){
				addPopover();
			});
          //发送申请；
			$('#qgfhsqtjTable').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/spareSendMsg",
				height : 400,
				pagination : true,
				sidePagination : "server",//服务器分页     	    
				pageSize : 10,
				pageNumber : 1,
				pageList : [ 10 ],
				queryParams : getParams,
				clickToSelect : true,//选择行即选择checkbox  
				singleSelect : true,//仅允许单选  
				columns: [
							{
								field: 'n_id',
								visible:false,
							},
							{
								field: 't_send_time',
								title: '时间',
								formatter: timeFormatter
							}, 
							{
								field: 'c_address',
								title: '收货地址'
							}, 
							{
								field: 'c_number',
								title: '发货数量'
							},
							{
								field: 'c_receiver',
								title: '收货人'
							},
							{
								field: 'c_express_message',
								title: '快递信息'
							},
							{
								field: 'c_model',
								title: '发货产品型号'
							},
							{
								field: 'c_send_type',
								title: '机器类型'
							},
							{
								field: 'c_apply_state',
								title: '处理状态',
								formatter: applyFormatter,
							},
							{
								field: 'handle',
								title: '操作',
								events:'actionEvents',
								formatter: operateFormatter
							}],

			});
			function operateFormatter(value, row, index){
				return [
					'<div class="glyphicon-box"><span class="glyphicon glyphicon-edit  glyphicon-edit2" href="javascript:void(0)"></span></div>',
					'<div class="glyphicon-box glmoreinfo"><span class="glyphicon glyphicon-info-sign glyphicon-info-sign1" id='+row.n_id+'></span></div>'
				].join('');
			}
			window.actionEvents  = {
				'click .glyphicon-edit2': function (e, value, row, index) {
					console.log(row);
					//显示申请模态框；
					 $("#fhsq").modal();
					  $("#send-address").val(row.c_address);
					  $("#send-receiver").val(row.c_receiver);
					  $("#send-number").val(row.c_number);
					  $('.radio input[name="test"]:checked').val(c_send_type);
				},
				'click .glyphicon-edit1': function (e, value, row, index) {
					$("#ghbyj").modal();
					 changeId=row.n_id;
					 alert(changeId);
					  $("#change-model").val(row.c_model);
					  $("#change-imei").val(row.c_spare_imei);
					  $("#respace-imei").val(row.c_respace_imei);
					  $("#change-remark").val(row.c_remark);	  
				},
				//显示日志;
				'mouseover .glyphicon-info-sign1': function (e, value, row, index) {
						var obj = {};
						obj['flag'] = "0";
						obj['recordId']=row.n_id;
				  		$.ajax({
					        url: '${contextPath}/controller/spareShowLog',
					        method: 'post',
					        async : false,
					        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
					        data: JSON.stringify(obj), // 以json字符串方式传递
					        success: function(data) {
					        //	{"result":[{"c_content":"添加发货申请","n_id":331,"c_type":null,"t_create_time":"2016-11-17 08:45:20","c_flag":"00","c_spare_id":"40","c_name":"huang1"},
					        //  {"c_content":"修改发货申请","n_id":333,"c_type":null,"t_create_time":"2016-11-17 08:46:55","c_flag":"00","c_spare_id":"40","c_name":"huang1"}],"state":"0","msg":"查询成功"}     
					        if(data.state=="0")
					        	{
					        	var result=data.result;
					 			$('#'+row.n_id).popover({
									container: 'body',
									placement: 'left',
									html: true,
									content: function(){
										var html=null;
										for(var i=0;i<result.length;i++)
											{
											if(html==null){
												html='<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';	
											}else
												{
												html=html+'<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';
												}
											}
										return html;
									}
								});  
					        	}
					        },
					    }); 
				},
				'mouseover .glyphicon-info-sign2': function (e, value, row, index) {
					var obj = {};
					obj['flag'] = "1";
					obj['recordId']=row.n_id;
			  		$.ajax({
				        url: '${contextPath}/controller/spareShowLog',
				        method: 'post',
				        async : false,
				        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
				        data: JSON.stringify(obj), // 以json字符串方式传递
				        success: function(data) {
				       
				        if(data.state=="0")
				        	{
				        	var result=data.result;
				 			$('#change'+row.n_id).popover({
								container: 'body',
								placement: 'left',
								html: true,
								content: function(){
									var html=null;
									for(var i=0;i<result.length;i++)
										{
										if(html==null){
											html='<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';	
										}else
											{
											html=html+'<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';
											}
										}
									
									return html;
								}
							});  
				        	}
				        },
				    }); 
			},
				
				
				
				
				
				
				
			};
			function applyFormatter(value, row, index){
				if(value=="0")
					{
					value="未处理";
					}else{
					value="已处理";	
					}
				return value;
			}
				
				
				
			function getParams(params) {
				return {
					region:regionCode,
 					offset : params.offset,
					sort : params.sort,
					order : params.order 
				};
			}			
			function addPopover(){
				$('.glmoreinfo').popover({
					container: 'body',
					trigger: 'hover',
					placement: 'left',
					html: true,
					content: function(){
						return '<p>dasdasdasdasd</p>';
					}
				});
			}
			addPopover();

			
		});
	</script>
</body>
</html>