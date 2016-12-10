<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="renderer" content="webkit">
    <title>中国移动4G车联网</title>
    <link rel="stylesheet" href="${contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${contextPath}/css/clw4G.css">
    <script src="${contextPath}/js/jquery-1.11.3.js"></script>
    <script src="${contextPath}/js/bootstrap.js"></script>
    <script src="${contextPath}/js/echarts.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=UcHh2XZnKNyGO26ywbqtELFFhZAaurr9"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/library/InfoBox/1.2/src/InfoBox.js"></script>
    <script src="${contextPath}/js/laytpl.js"></script>
    <script src="${contextPath}/js/layer.js"></script>
    <script src="${contextPath}/js/base.js"></script>
    <script src="${contextPath}/js/jquery.shCircleLoader.js"></script>
    <script src="${contextPath}/js/transform.js"></script>
    <script src="${contextPath}/js/base.js"></script> 
     
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
               <jsp:include page="/WEB-INF/basicPage/deviceMenu.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>
               
                <jsp:include page="/WEB-INF/basicPage/groupMenu1.jsp">
					<jsp:param name="title" value="登录页面" />
				</jsp:include>
		     
			     <jsp:include page="/WEB-INF/basicPage/firstSearch.jsp">
	             <jsp:param name="title" value="登录页面"/> 
	            </jsp:include>		
        	</div>
    	</div>
    </nav>
	
	<div class="container-fluid">
		<div class="row">
		
			
        	
        	<div class="col-sm-12 col-md-12  main">
        	
        		<div class="panel panel-primary imeiDetailsInfo">
					<div class="panel-heading">
						<h3 class="panel-title">IMEI：<label id="imei"></label> 
						<span class="lead">综合评分：<label id="grade"></label></span>
						<span class="lead">用户身份判断：<label id="identity"></label></span>
						</h3>
				  	</div>
				  	<div class="panel-body">
						<div class="row">
							<div class="col-xs-12 col-sm-4 col-md-4">昵称：<label id="user-name"></label></div>
							<div class="col-xs-12 col-sm-4 col-md-4">设备名称：<label >智能后视镜，v 1.2.</label></div>
							<div class="col-xs-12 col-sm-4 col-md-4">激活时间：<label id="createtime"></label></div>
						</div>
						<h4>实时位置：</h4>
						<div class="row">
							<div class="col-xs-12 col-sm-4 col-md-4">在线状态：<label id="device-state"></label></div>
					<!-- 	 	<div class="col-xs-12 col-sm-4 col-md-4">车辆行驶速度：<label id="ddvice-speed"></label></div> -->
							<div class="col-xs-12 col-sm-4 col-md-4">位置：<label id="device-address"></label></div>
						</div>
						<h4>驾驶行为总数据</h4>
						<div class="row">
							<div class="col-xs-12 col-sm-4 col-md-4">行驶总时间：<label id="sum-time"></label>h</div>
							<div class="col-xs-12 col-sm-4 col-md-4">行驶总里程：<label id="sum-trave"></label>km</div>
						    <div class="col-xs-12 col-sm-4 col-md-4">疲劳驾驶总次数：<label id="fatigue"></label></div>
						</div>
						<div class="row">
						<div class="col-xs-12 col-sm-4 col-md-4">碰撞总次数：<label id="collide"></label></div>
						<div class="col-xs-12 col-sm-4 col-md-4">急转弯总次数：<label id="turn"></label></div>
						</div>
						<div class="row">
							<div class="col-xs-12 col-sm-4 col-md-4">急加速总次数：<label id="speed_up"></label></div>
							<div class="col-xs-12 col-sm-4 col-md-4">急减速（刹车）总次数：<label id="speed_down"></label></div>
						</div>
				  	</div>
				</div>
      	
      	
      			<div class="panel panel-default imeiSingle">
					<div class="panel-heading">驾驶行为分析
					 <div class="fnTips">
					   <i class="glyphicon glyphicon-question-sign"></i>
					   <div class="fnTipsInfo">了解用户每天驾驶行为的具体数据和变化</div>
					</div>
					</div>
					<div class="panel-body">
					
						<div class="modalDropdownSelectBox clearfix">
							<div class="dropdown pull-right" id="driverbehavior">
                              	<button class="btn btn-default dropdown-toggle" type="button"  id="driverbehaviortime">
									&nbsp;2016.06.25~2016.07.01
									<span class="caret"></span>
								</button> 								
 								<ul class="dropdown-menu timeSelect" role="menu" id="timeSelect">
									<li class="clearfix" role="presentation">
										<p class="pull-left">开始：</p>
										<select class="form-control pull-left year1" name="driverbehaviortime-year1" id="driverbehaviortime-year1">
											<option value="2016">2016年</option>
											<option value="2015">2015年</option>
											<option value="2014">2014年</option>
										</select>
										<select class="form-control pull-left month1 " name="driverbehaviortime-month1" id="driverbehaviortime-month1" >
											<option value="12">12月</option>
											<option value="11">11月</option>
											<option value="10">10月</option>
											<option value="9">9月</option>
											<option value="8">8月</option>
											<option value="7">7月</option>
											<option value="6">6月</option>
											<option value="5">5月</option>
											<option value="4">4月</option>
											<option value="3">3月</option>
											<option value="2">2月</option>
											<option value="1">1月</option>
										</select>
										<select class="form-control pull-left day1" name="driverbehaviortime-day1" id="driverbehaviortime-day1">
											<option value="31">31日</option>
											<option value="30">30日</option>
											<option value="29">29日</option>
											<option value="28">28日</option>
											<option value="27">27日</option>
											<option value="26">26日</option>
											<option value="25">25日</option>
											<option value="24">24日</option>
											<option value="23">23日</option>
											<option value="22">22日</option>
											<option value="21">21日</option>
											<option value="20">20日</option>
											<option value="19">19日</option>
											<option value="18">18日</option>
											<option value="17">17日</option>
											<option value="16">16日</option>
											<option value="15">15日</option>
											<option value="14">14日</option>
											<option value="13">13日</option>
											<option value="12">12日</option>
											<option value="11">11日</option>
											<option value="10">10日</option>
											<option value="09">09日</option>
											<option value="08">08日</option>
											<option value="07">07日</option>
											<option value="06">06日</option>
											<option value="05">05日</option>
											<option value="04">04日</option>
											<option value="03">03日</option>
											<option value="02">02日</option>
											<option value="01">01日</option>
										</select>
									</li>
									<li class="clearfix" role="presentation">
										<p class="pull-left">结束：</p>
										<select class="form-control pull-left year2"  name="driverbehaviortime-year2" id="driverbehaviortime-year2">
											<option value="2016">2016年</option>
											<option value="2015">2015年</option>
											<option value="2014">2014年</option>
										</select>
										<select class="form-control pull-left month2"  name="driverbehaviortime-month2" id="driverbehaviortime-month2">
											<option value="12">12月</option>
											<option value="11">11月</option>
											<option value="10">10月</option>
											<option value="9">9月</option>
											<option value="8">8月</option>
											<option value="7">7月</option>
											<option value="6">6月</option>
											<option value="5">5月</option>
											<option value="4">4月</option>
											<option value="3">3月</option>
											<option value="2">2月</option>
											<option value="1">1月</option>
										</select>
										<select class="form-control pull-left day2"  name="driverbehaviortime-day2" id="driverbehaviortime-day2">
											<option value="31">31日</option>
											<option value="30">30日</option>
											<option value="29">29日</option>
											<option value="28">28日</option>
											<option value="27">27日</option>
											<option value="26">26日</option>
											<option value="25">25日</option>
											<option value="24">24日</option>
											<option value="23">23日</option>
											<option value="22">22日</option>
											<option value="21">21日</option>
											<option value="20">20日</option>
											<option value="19">19日</option>
											<option value="18">18日</option>
											<option value="17">17日</option>
											<option value="16">16日</option>
											<option value="15">15日</option>
											<option value="14">14日</option>
											<option value="13">13日</option>
											<option value="12">12日</option>
											<option value="11">11日</option>
											<option value="10">10日</option>
											<option value="09">09日</option>
											<option value="08">08日</option>
											<option value="07">07日</option>
											<option value="06">06日</option>
											<option value="05">05日</option>
											<option value="04">04日</option>
											<option value="03">03日</option>
											<option value="02">02日</option>
											<option value="01">01日</option>
										</select>
									</li>
									<li class="clearfix" role="presentation">
										<button type="button" class="btn btn-primary" id="driverbehaviortime-confirm">确定</button>
										<button type="button" class="btn btn-default" id="cancel">取消</button>
									</li>
								</ul> 
							</div>
						</div>
						
						<div class="echartsBox">
							<div id="eccharts1" class="echartsBody">
								
							</div>
						</div>
						
					</div>
				</div>
      	
       			<div class="panel panel-default imeiSingle">
					<div class="panel-heading">单个驾驶行为分析
					 <div class="fnTips">
					   <i class="glyphicon glyphicon-question-sign"></i>
					   <div class="fnTipsInfo">了解用户某个驾驶行为出现的频率和变化</div>
					 </div>
					</div>
					<div class="panel-body">
						<div class="modalDropdownSelectBox clearfix">
						<div class="dropdown pull-left  syyhzfSelect" >
							<button class="btn btn-default dropdown-toggle device-singledriverbehavior-button1" type="button "  id="dropdownMenu1" data-toggle="dropdown" value="collide">碰撞次数<span class="caret"></span>
							</button>
							 <ul class="dropdown-menu" role="menu" id="dropdown-menu1" aria-labelledby="dropdownMenu1">
								<li role="presentation"  class="singledriverbehavior-presentation" value="collide"><a role="menuitem" tabindex="-1" >碰撞次数</a></li>
								<li role="presentation"  class="singledriverbehavior-presentation" value="turn" ><a role="menuitem" tabindex="-1" >急转弯次数</a></li>
								<li role="presentation"  class="singledriverbehavior-presentation" value="speed_down"><a role="menuitem" tabindex="-1" >急加速次数</a></li>
								<li role="presentation"  class="singledriverbehavior-presentation" value="speed_up"><a role="menuitem" tabindex="-1" >急刹车次数</a></li>
								<li role="presentation"  class="singledriverbehavior-presentation" value="fatigue"><a role="menuitem" tabindex="-1" >疲劳驾驶次数</a></li>
								
								
							</ul> 
						</div>
						<div class="dropdown pull-right" id="singledriverbehavior">
                           	<button class="btn btn-default dropdown-toggle" type="button"  id="singledriverbehaviortime">
									&nbsp;2016.06.25~2016.07.01
									<span class="caret"></span>
								</button> 								
 								<ul class="dropdown-menu timeSelect" role="menu" id="timeSelect2">
									<li class="clearfix" role="presentation">
										<p class="pull-left">开始：</p>
										<select class="form-control pull-left year1" name="singledriverbehaviortime-year1" id="singledriverbehaviortime-year1">
											<option value="2016">2016年</option>
											<option value="2015">2015年</option>
											<option value="2014">2014年</option>
										</select>
										<select class="form-control pull-left month1 " name="singledriverbehaviortime-month1" id="singledriverbehaviortime-month1" >
											<option value="12">12月</option>
											<option value="11">11月</option>
											<option value="10">10月</option>
											<option value="9">9月</option>
											<option value="8">8月</option>
											<option value="7">7月</option>
											<option value="6">6月</option>
											<option value="5">5月</option>
											<option value="4">4月</option>
											<option value="3">3月</option>
											<option value="2">2月</option>
											<option value="1">1月</option>
										</select>
										<select class="form-control pull-left day1" name="singledriverbehaviortime-day1" id="singledriverbehaviortime-day1">
											<option value="31">31日</option>
											<option value="30">30日</option>
											<option value="29">29日</option>
											<option value="28">28日</option>
											<option value="27">27日</option>
											<option value="26">26日</option>
											<option value="25">25日</option>
											<option value="24">24日</option>
											<option value="23">23日</option>
											<option value="22">22日</option>
											<option value="21">21日</option>
											<option value="20">20日</option>
											<option value="19">19日</option>
											<option value="18">18日</option>
											<option value="17">17日</option>
											<option value="16">16日</option>
											<option value="15">15日</option>
											<option value="14">14日</option>
											<option value="13">13日</option>
											<option value="12">12日</option>
											<option value="11">11日</option>
											<option value="10">10日</option>
											<option value="09">09日</option>
											<option value="08">08日</option>
											<option value="07">07日</option>
											<option value="06">06日</option>
											<option value="05">05日</option>
											<option value="04">04日</option>
											<option value="03">03日</option>
											<option value="02">02日</option>
											<option value="01">01日</option>
										</select>
									</li>
									<li class="clearfix" role="presentation">
										<p class="pull-left">结束：</p>
										<select class="form-control pull-left year2"  name="singledriverbehaviortime-year2" id="singledriverbehaviortime-year2">
											<option value="2016">2016年</option>
											<option value="2015">2015年</option>
											<option value="2014">2014年</option>
										</select>
										<select class="form-control pull-left month2"  name="singledriverbehaviortime-month2" id="singledriverbehaviortime-month2">
											<option value="12">12月</option>
											<option value="11">11月</option>
											<option value="10">10月</option>
											<option value="9">9月</option>
											<option value="8">8月</option>
											<option value="7">7月</option>
											<option value="6">6月</option>
											<option value="5">5月</option>
											<option value="4">4月</option>
											<option value="3">3月</option>
											<option value="2">2月</option>
											<option value="1">1月</option>
										</select>
										<select class="form-control pull-left day2"  name="singledriverbehaviortime-day2" id="singledriverbehaviortime-day2">
											<option value="31">31日</option>
											<option value="30">30日</option>
											<option value="29">29日</option>
											<option value="28">28日</option>
											<option value="27">27日</option>
											<option value="26">26日</option>
											<option value="25">25日</option>
											<option value="24">24日</option>
											<option value="23">23日</option>
											<option value="22">22日</option>
											<option value="21">21日</option>
											<option value="20">20日</option>
											<option value="19">19日</option>
											<option value="18">18日</option>
											<option value="17">17日</option>
											<option value="16">16日</option>
											<option value="15">15日</option>
											<option value="14">14日</option>
											<option value="13">13日</option>
											<option value="12">12日</option>
											<option value="11">11日</option>
											<option value="10">10日</option>
											<option value="09">09日</option>
											<option value="08">08日</option>
											<option value="07">07日</option>
											<option value="06">06日</option>
											<option value="05">05日</option>
											<option value="04">04日</option>
											<option value="03">03日</option>
											<option value="02">02日</option>
											<option value="01">01日</option>
										</select>
									</li>
									<li class="clearfix" role="presentation">
										<button type="button" class="btn btn-primary" id="singledriverbehaviortime-confirm">确定</button>
										<button type="button" class="btn btn-default" id="cancel2">取消</button>
									</li>
								</ul> 
							</div>
						</div>	
						<div class="echartsBox">
							<div id="eccharts2" class="echartsBody">
								
							</div>
						</div>
						
					</div>
				</div> 
      	
   
      	
      			<div class="panel panel-default imeiSingle">
					<div class="panel-heading">碰撞/停车监控视频
					<div class="fnTips">
					   <i class="glyphicon glyphicon-question-sign"></i>
					   <div class="fnTipsInfo">汽车检测到碰撞后,将自动录制一段视频</div>
					</div>
					</div>
					<div class="panel-body">
					   <div id ="devicecollide-text"  class="dropdown pull-left">
							
						</div>
						<div class="modalDropdownSelectBox clearfix" id="devicecollide">
							<div class="dropdown pull-right">
                           	<button class="btn btn-default dropdown-toggle" type="button"  id="collidetime">
									&nbsp;2016.06.25~2016.07.01
									<span class="caret"></span>
								</button> 								
 								<ul class="dropdown-menu timeSelect" role="menu" id="timeSelect4">
									<li class="clearfix" role="presentation">
										<p class="pull-left">开始：</p>
										<select class="form-control pull-left year1" name="collidetime-year1" id="collidetime-year1">
											<option value="2016">2016年</option>
											<option value="2015">2015年</option>
											<option value="2014">2014年</option>
										</select>
										<select class="form-control pull-left month1 " name="collidetime-month1" id="collidetime-month1" >
											<option value="12">12月</option>
											<option value="11">11月</option>
											<option value="10">10月</option>
											<option value="9">9月</option>
											<option value="8">8月</option>
											<option value="7">7月</option>
											<option value="6">6月</option>
											<option value="5">5月</option>
											<option value="4">4月</option>
											<option value="3">3月</option>
											<option value="2">2月</option>
											<option value="1">1月</option>
										</select>
										<select class="form-control pull-left day1" name="collidetime-day1" id="collidetime-day1">
											<option value="31">31日</option>
											<option value="30">30日</option>
											<option value="29">29日</option>
											<option value="28">28日</option>
											<option value="27">27日</option>
											<option value="26">26日</option>
											<option value="25">25日</option>
											<option value="24">24日</option>
											<option value="23">23日</option>
											<option value="22">22日</option>
											<option value="21">21日</option>
											<option value="20">20日</option>
											<option value="19">19日</option>
											<option value="18">18日</option>
											<option value="17">17日</option>
											<option value="16">16日</option>
											<option value="15">15日</option>
											<option value="14">14日</option>
											<option value="13">13日</option>
											<option value="12">12日</option>
											<option value="11">11日</option>
											<option value="10">10日</option>
											<option value="09">09日</option>
											<option value="08">08日</option>
											<option value="07">07日</option>
											<option value="06">06日</option>
											<option value="05">05日</option>
											<option value="04">04日</option>
											<option value="03">03日</option>
											<option value="02">02日</option>
											<option value="01">01日</option>
										</select>
									</li>
									<li class="clearfix" role="presentation">
										<p class="pull-left">结束：</p>
										<select class="form-control pull-left year2"  name="collidetime-year2" id="collidetime-year2">
											<option value="2016">2016年</option>
											<option value="2015">2015年</option>
											<option value="2014">2014年</option>
										</select>
										<select class="form-control pull-left month2"  name="collidetime-month2" id="collidetime-month2">
											<option value="12">12月</option>
											<option value="11">11月</option>
											<option value="10">10月</option>
											<option value="9">9月</option>
											<option value="8">8月</option>
											<option value="7">7月</option>
											<option value="6">6月</option>
											<option value="5">5月</option>
											<option value="4">4月</option>
											<option value="3">3月</option>
											<option value="2">2月</option>
											<option value="1">1月</option>
										</select>
										<select class="form-control pull-left day2"  name="collidetime-day2" id="collidetime-day2">
											<option value="31">31日</option>
											<option value="30">30日</option>
											<option value="29">29日</option>
											<option value="28">28日</option>
											<option value="27">27日</option>
											<option value="26">26日</option>
											<option value="25">25日</option>
											<option value="24">24日</option>
											<option value="23">23日</option>
											<option value="22">22日</option>
											<option value="21">21日</option>
											<option value="20">20日</option>
											<option value="19">19日</option>
											<option value="18">18日</option>
											<option value="17">17日</option>
											<option value="16">16日</option>
											<option value="15">15日</option>
											<option value="14">14日</option>
											<option value="13">13日</option>
											<option value="12">12日</option>
											<option value="11">11日</option>
											<option value="10">10日</option>
											<option value="09">09日</option>
											<option value="08">08日</option>
											<option value="07">07日</option>
											<option value="06">06日</option>
											<option value="05">05日</option>
											<option value="04">04日</option>
											<option value="03">03日</option>
											<option value="02">02日</option>
											<option value="01">01日</option>
										</select>
									</li>
									<li class="clearfix" role="presentation">
										<button type="button" class="btn btn-primary" id="collidetime-confirm">确定</button>
										<button type="button" class="btn btn-default" id="cancel4">取消</button>
									</li>
								</ul> 
							</div>
						</div>
						
						<div class="echartsBox">
						 <div class="ecCharLoading" id="devicecollide-ecCharLoading"></div>
							<div class="otherInfoBody">
								<table class="table table-hover huifang">
								  	<tbody id="tableObj">
								  	</tbody>
								</table>
							</div>
						</div>
						
					</div>
				</div>
      	
      			
      			<div class="panel panel-default imeiSingle">
					<div class="panel-heading">驾驶规律时间段
					<div class="fnTips">
					   <i class="glyphicon glyphicon-question-sign"></i>
					   <div class="fnTipsInfo">了解车主通常在一天中那些时段开车</div>
					</div>
					</div>
					<div class="panel-body">
					
						<div class="modalDropdownSelectBox clearfix">
						<div class="dropdown pull-right  syyhzfSelect"  >
							<button class="btn btn-default dropdown-toggle device-singleDiverRuleTime-button1" type="button "  id="dropdownMenu1" data-toggle="dropdown" value="year">
								最近一年
								<span class="caret"></span>
							</button>
							 <ul class="dropdown-menu" role="menu" id="dropdown-menu1" aria-labelledby="dropdownMenu1">
								<li role="presentation"  class="singleDiverRuleTime" value="year"><a role="menuitem" tabindex="-1" >最近一年</a></li>
								<li role="presentation"  class="singleDiverRuleTime" value="month3" ><a role="menuitem" tabindex="-1" >最近一季度</a></li>
								<li role="presentation"  class="singleDiverRuleTime" value="month1"><a role="menuitem" tabindex="-1" >最近一个月</a></li>
								<li role="presentation"  class="singleDiverRuleTime" value="week"><a role="menuitem" tabindex="-1" >最近一周</a></li>
							</ul> 
						</div>
							
						</div>
						
						<div class="echartsBox">
							<div class="ecCharLoading" id="singleDiverRuleTime-ecCharLoading"></div>
							<div id="eccharts3" class="echartsBody">
								
							</div>
						</div>
						
					</div>
				</div>
      			<div class="panel panel-default imeiSingle">
					<div class="panel-heading">地域规律
					<div class="fnTips">
					   <i class="glyphicon glyphicon-question-sign"></i>
					   <div class="fnTipsInfo">了解用户在每个省的开车时长</div>
					</div>
					</div>
					<div class="panel-body">
					
						<div class="modalDropdownSelectBox clearfix">
							<div class="dropdown pull-right  syyhzfSelect"  >
							<button class="btn btn-default dropdown-toggle device-singleDiverRuleAreaTime-button1" type="button"  id="dropdownMenu1" data-toggle="dropdown" value="year">
								最近一年
								<span class="caret"></span>
							</button>
							 <ul class="dropdown-menu" role="menu" id="dropdown-menu1" aria-labelledby="dropdownMenu1">
								<li role="presentation"  class="singleDiverRuleAreaTime" value="year"><a role="menuitem" tabindex="-1" >最近一年</a></li>
								<li role="presentation"  class="singleDiverRuleAreaTime" value="month3" ><a role="menuitem" tabindex="-1" >最近一季度</a></li>
								<li role="presentation"  class="singleDiverRuleAreaTime" value="month1"><a role="menuitem" tabindex="-1" >最近一个月</a></li>
								<li role="presentation"  class="singleDiverRuleAreaTime" value="week"><a role="menuitem" tabindex="-1" >最近一周</a></li>
							</ul> 
						</div>
						</div> 
						<div class="echartsBox">
							<div class="ecCharLoading" id="singleDiverRuleAreaTime-ecCharLoading"></div>
							<div id="eccharts4" class="echartsBody">
								
							</div>
						</div>
						
					</div>
				</div>
       	
        	</div>
        	
		</div>
	</div>

	<script id="tableObjView" type="text/html">
		{{# for(var i = 0, len = d.length; i < len; i++){ }}
        <tr  data-n_id= {{d[i].n_id}}  data-index={{i}} >
			<td>时间：{{d[i].t_data_time}}</td>
			<td>地点：<label class={{d[i].n_id}} ></label></td>
			<td width="10%" id={{d[i].n_id}}   class="user-video" ><img src="${contextPath}/images/huifang.png" class="video"></td>
		</tr>
		{{# } }}
	</script>
	<script>
	function addDate1(date, days) {
		var d = date;
		d.setDate(d.getDate() + days);
		var month = d.getMonth() + 1;
		var day = d.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (day < 10) {
			day = "0" + day;
		}
		var val = new Array(); // 定义一数组
		val[0] = d.getFullYear();
		val[1] = month;
		val[2] = day;
		return val;
	}
	// ------------------------------------------------------初始化时间；
	$(function() {
		//判断用户类型
		var type="${adminType}";
	    if (type == "1") {
			$("#personalCenter2").hide();
		} else {
			$("#personalCenter1").hide();
		}
		var now = new Date();
		var year = now.getFullYear();
		var month = (now.getMonth() + 1).toString();
		var day = (now.getDate()-1).toString();
		if (month.length == 1) {
			month = "0" + month;
		}
		if (day.length == 1) {
			day = "0" + day;
		}
		var dateTime = year + "." + month + "." + day;
		var time =[];
		 time = addDate1(now, -7);
		// 下拉框默认选中
		// year1.selectedIndex=0 开始
		$(".year1 option").each(function() {
			if ($(this).attr("value") == time[0]) {
				$(this).attr("selected", "selected");
			}
		});
		$(".month1 option").each(function() {
			if ($(this).attr("value") == time[1]) {
				$(this).attr("selected", "selected");
			}
		});

		$(".day1 option").each(function() {
			if ($(this).attr("value") == time[2]) {
				$(this).attr("selected", "selected");
			}
		});
		// 结束
		$(".year2 option").each(function() {
			if ($(this).attr("value") == year) {
				$(this).attr("selected", "selected");
			}
		});
		$(".month2 option").each(function() {
			if ($(this).attr("value") == month) {
				$(this).attr("selected", "selected");
			}
		});

		$(".day2 option").each(function() {
			if ($(this).attr("value") == day) {
				$(this).attr("selected", "selected");
			}
		});
		time = time[0] + "." + time[1] + "." + time[2]
		$("#historytime").html(dateTime);
		$("#driverbehaviortime").html(time + "-" + dateTime);
		$("#singledriverbehaviortime").html(time + "-" + dateTime);		
		$("#collidetime").html(time + "-" + dateTime);
		
	});
	var hello;
	var trackData;
	var imei;
	function addDate(date, days) {
		var d = date;
		d.setDate(d.getDate() + days);
		var month = d.getMonth() + 1;
		var day = d.getDate();
		if (month < 10) {
			month = "0" + month;
		}
		if (day < 10) {
			day = "0" + day;
		}
		return d;
	}
	//时间相减
      function baseDate(nowDate, pastDate) {
		return (nowDate.getTime() - pastDate.getTime()) / (24 * 60 * 60 * 1000);
	};
	
	//---------显示时间；
		var strs1 = new Array(); // 定义一数组
		var now =new Date();
		var now1 = new Date();
		var now2 = new Date();
		var date=addDate(now,-7);
		//显示七天时间;
	var year = now2.getFullYear();
	var month = (now2.getMonth() + 1).toString();
	var day = (now2.getDate()-1).toString();
	if (month.length == 1) {
		month = "0" + month;
	}
	if (day.length == 1) {
		day = "0" + day;
	}
	var year1 = date.getFullYear();
	var month1 = (date.getMonth() + 1).toString();
	var day1 = (date.getDate()).toString();
	if (month1.length == 1) {
		month1 = "0" + month1;
	}
	if (day1.length == 1) {
		day1 = "0" + day1;
	}
	var dateTime = year + "." + month + "." + day;
    var dateTime1 = year1 + "." + month1 + "." + day1;
	$("#trave-time").html(dateTime1+ "-" + dateTime);	
		// 调用日期差方法，求得参数日期与系统时间相差的天数
		var diff = baseDate(now1, date);
		for (var i = diff; i >= 0; i--) {
			var year = now1.getFullYear();
			var month = now1.getMonth() + 1; // js从0开始取
			var date = now1.getDate();
			strs1[i] = year + "-" + month + "-" + date;
			now1.setDate(now1.getDate() - 1);
		}
	
	
	var  videoData;
	var videoDataIndex;
//----------------------------------得到地址	
	var index = 0;
	var geoc = new BMap.Geocoder();  
	
	var adds=[];
	var addId=[];
	function bdGEO(){
	    var pt = adds[index];
	    geocodeSearch(pt,index);
	    index++;
	}
	function geocodeSearch(pt,index){
		geoc.getLocation(pt, function(rs){
	       var address=rs.address;
	        $("."+addId[index]).html(address); 
	    });
	}
	//---------------获取链接参数
	function GetQueryString(name)
	{
	     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	     var r = window.location.search.substr(1).match(reg);
	     if(r!=null)return  unescape(r[2]); return null;
	}	
	//显示数据
	function showData(data, tmpl, target){
		var gettpl = $(tmpl).html();
		laytpl(gettpl).render(data, function(html){
	  		$(target).html(html)
		});
	} 
			var option;
			var option2;
			var option3;
			var option4;
			var compileData;
			imei=GetQueryString("c_imei");
			$("#imei").html(imei);	
//---------------------------------------------------------------退出登录
$("#user_dropout").click(
				function() {
					$.post("${contextPath}/controller/closeAccount",
							function(data) {
								if (data.state == "1") {
									alert("退出登录失败");
								} else {
								}
							});
				});		

			
			
//-----------------------------------------------------------------用户个人信息初始化
			$.post("${contextPath}/controller/homepageDevice", {
				imei : imei
			}, function(data) {
				//转换时间格式；
				var create_time = BaseUtility.longConvertDate(data[0].t_create_time);
				$("#fatigue").html(data[0].c_fatigue);
				$("#identity").html(data[0].c_user_identity);
				$("#sum-time").html(data[0].c_total_time);
				$("#sum-trave").html(data[0].c_total_mileage/1000);
				$("#grade").html(data[0].c_grade);
				$("#user-name").html(data[0].c_user_name);
				$("#createtime").html(create_time);
				$("#collide").html(data[0].c_collide);
				$("#turn").html(data[0].c_trun);
				$("#speed_up").html(data[0].c_speed_up);
				$("#speed_down").html(data[0].c_speed_down);
				var a = data[1].onlineState;
				if (a == false) {
					$("#device-state").html("离线");
					$("#device-address").parent().hide();
				}else{
					$("#device-state").html("在线");
					var pt = new BMap.Point(data[1].lng, data[1].lat);
					geoc.getLocation(pt, function(rs){
				        var addComp = rs.addressComponents;
				        var address=addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber;
				        $("#device-address").html(address); 
				    });	
				}
			});

	//------------------------------------------------------------------用户个人行为初始化	
 			$.post("${contextPath}/controller/singleDeviceDriveBehavior", {
				imei : imei,
				time1:dateTime1,
				time2:dateTime,
			}, function(data) {
				var collide = [];
				var turn = [];
				var speed_up = [];
				var speed_down = [];
				var fatigue=[];
				var grade=[];
			for(var i=data.length-1;i>=0;i--)
				{
				   collide.push(data[i].collide);
				   turn.push(data[i].turn);
				   speed_up.push(data[i].speedUp);
				   speed_down.push(data[i].speepDown);
				   fatigue.push(data[i].fatigue);
				   grade.push(data[i].grade);
				}	
				option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					legend : {
						data : [ '急转弯总次数', '急减速总次数', '急加速总次数', '碰撞事故总次数','疲劳驾驶总次数' ]
					},
					grid : {
						left : '3%',
						right : '4%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : [ {
						name : "时间",
						type : 'category',
						data : strs1
					} ],
					yAxis : [ {
						name : "次数",
						type : 'value'
					} ],
					series : [{
						name : '综合评分',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : grade,
					},{
						name : '急转弯总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : turn,
					}, {
						name : '急减速总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : speed_down,
					}, {
						name : '急加速总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : speed_up,
					}, {
						name : '碰撞事故总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : collide,
					},{
						name : '疲劳驾驶总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : fatigue,
					},
					]
				};
				var eccharts1 = echarts.init($("#eccharts1")[0]);
				eccharts1.setOption(option);
			});
//----------------------------------------------------------------用户单个驾驶行为初始化
 			$.post("${contextPath}/controller/singleDeviceSingleDriveBehavior",
					{
						imei : imei,
						behavior : "collide",
						startTime:dateTime1,
						endTime:dateTime,	
					}, function(data) {
						var collide = [];
						for (var i =data.length-1; i>=0; i--) {
							collide.push(data[i].behavior);
						}
						var option2 = {
							color : [ '#3398DB' ],
							tooltip : {
								trigger : 'axis',
								axisPointer : { // 坐标轴指示器，坐标轴触发有效
									type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
								}
							},
							grid : {
								left : '3%',
								right : '4%',
								bottom : '3%',
								containLabel : true
							},
							xAxis : [ {
								name : "时间",
								type : 'category',
								//data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
								data : strs1,
								axisTick : {
									alignWithLabel : true
								}
							} ],
							yAxis : [ {
								name : "次数",
								type : 'value',
							} ],
							series : [ {
								name : '碰撞总次数',
								type : 'bar',
								barWidth : '60%',
								data : collide
							} ]
						};
						var eccharts2 = echarts.init($("#eccharts2")[0]);
						eccharts2.setOption(option2);

					}); 

			//-----------------------------------------------------用户停车监控初始化；
 		$.post("${contextPath}/controller/singleDeviceCollide", {
				imei : imei,
				time1:dateTime1,
				time2:dateTime
			}, function(data) {
				compileData = data;
				videoData = data;
				$("#devicecollide-ecCharLoading").hide();
				if(data.length=="0")
				{
				$("#devicecollide-text").empty();
				var html="<div class=row id=1>"+"...... 该用户没有监控视频，请选择其他日期"+"</div>";
				 $("#devicecollide-text").append(html);	
				return;
				}
				
				
				
				var geoc = new BMap.Geocoder();
				for (var i = 0; i < data.length; i++) {
					var pt = new BMap.Point(data[i].n_lng, data[i].n_lat);
					var point = new BMap.Point(116.331398, 39.897445);
					adds.push(pt);
					addId.push(data[i].n_id);
					var time = data[i].t_data_time;
				
					data[i].t_data_time = BaseUtility.longConvertDate(time);
					
				}
				for (var j = 0; j < data.length; j++) {
					bdGEO();
				}
				showData(data, "#tableObjView", "#tableObj");
			}); 

			//---------------点击播放视频
			$("#tableObj").on("click", "tr", function() {

				var a = $(this).data("n_id");
				var index = $(this).data("index");
				videoDataIndex = index;

				layer.open({
					type : 2,
					area : [ '800px', '660px' ],
					fix : false, //不固定
					maxmin : true,
					content : 'video'
				});

			}); 

 			$.post("${contextPath}/controller/singleDiverRuleTime", {
				imei : imei,
				timeFlag : "year"
			}, function(result) {
				$("#singleDiverRuleTime-ecCharLoading").hide();
				var data = [];
				var date = [];
				for (var i = 0; i < result.length; i++) {
					data.push(result[i].number);
					date.push(result[i].hour + "小时");
				}
				option3 = {
					tooltip : {
						trigger : 'axis',
						position : function(pt) {
							return [ pt[0], '10%' ];
						}
					},
					title : {
						left : 'center',
						text : '累计每天驾驶规律',
					},
					xAxis : {
						type : 'category',
						boundaryGap : false,
						data : date
					},
					yAxis : {
						type : 'value',
						boundaryGap : [ 0, '100%' ]
					},
					series : [ {
						name : '在线次数',
						type : 'line',
						smooth : true,
						symbol : 'none',
						sampling : 'average',
						itemStyle : {
							normal : {
								color : 'rgb(255, 70, 131)'
							}
						},
						areaStyle : {
							normal : {
								color : new echarts.graphic.LinearGradient(0,
										0, 0, 1, [ {
											offset : 0,
											color : 'rgb(255, 158, 68)'
										}, {
											offset : 1,
											color : 'rgb(255, 70, 131)'
										} ])
							}
						},
						data : data
					} ]
				};

				var eccharts3 = echarts.init($("#eccharts3")[0]);
				eccharts3.setOption(option3);
			});
			//-------------------------------------------------------------当个设备的地域规律		
 		$.post("${contextPath}/controller/singleDiverRuleArea", {
				imei : imei,
				timeFlag : "year"
			}, function(result) {
				$("#singleDiverRuleAreaTime-ecCharLoading").hide();
			    var data=[];
			    var area=[];
				for (var i = 0; i < result.length; i++) {
					 data.push(result[i].hour); 
					 area.push(result[i].city);
				}
				option4 = {
					tooltip : {
						trigger : 'axis'
					},
					tooltip : {},
					xAxis : {
						name:"地区",
						/* data : ["湖南", "湖北" ,"山东", "四川", "安徽"] */
						data:area,
					            
					},
					yAxis : {
						name:"累计时间/小时"
					},
					series : [ {
						name : '累计时间',
						type : 'bar',
						data : data
					} ]
				};
				var eccharts4 = echarts.init($("#eccharts4")[0]);
				eccharts4.setOption(option4);

			}); 
			


		//----------------------------------------单一设备动态查询
		
  		$("#select-user").click(function(){
			$(this).find(".dropdown-menu").show();
		});		
 	$(".singledriverbehavior-presentation").click(function(){
		var model = $(this).text();
   	 var a = $(this).attr("value");
   		$('.device-singledriverbehavior-button1').html(model+"<span class=caret></span>");	
   		$('.device-singledriverbehavior-button1').attr("value", a); 
   		var time =$("#singledriverbehaviortime").text();
   		var timeSum=time.split("-");	
	
   		var date1 = time;
		var strs = new Array(); //定义一数组
		var strs2 = new Array(); //定义一数组
		strs = date1.split("-"); //字符分割     
		// 构造两个日期，分别是系统时间和2013/04/08 12:43:45
		var now = new Date(strs[1]);
		var now1 = now;
		var date = new Date(strs[0]);
		// 调用日期差方法，求得参数日期与系统时间相差的天数
	
		var diff = baseDate(now, date);
		// 打印日期差			    
		for (var i = diff; i >= 0; i--) {
			var year = now1.getFullYear();
			var month = now1.getMonth() + 1; //js从0开始取 
			var date = now1.getDate();
			strs2[i] = year + "-" + month + "-" + date;
			now1.setDate(now1.getDate() - 1);
		}
   		
   		
   		$.post("${contextPath}/controller/singleDeviceSingleDriveBehavior", 
		{
			imei:imei,
			behavior:a,
			startTime:timeSum[0],
		    endTime:timeSum[1]
		}, 
		function(data) {	
			var collide = [];
			for (var i =data.length-1; i>=0; i--) {
				collide.push(data[i].behavior);
			}
			var option2 = {
				color : [ '#3398DB' ],
				tooltip : {
					trigger : 'axis',
					axisPointer : { // 坐标轴指示器，坐标轴触发有效
						type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
					}
				},
				grid : {
					left : '3%',
					right : '4%',
					bottom : '3%',
					containLabel : true
				},
				xAxis : [ {
					name : "时间",
					type : 'category',
					//data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
					data : strs2,
					axisTick : {
						alignWithLabel : true
					}
				} ],
				yAxis : [ {
					name : "次数",
					type : 'value',
				} ],
				series : [ {
					name : model,
					type : 'bar',
					barWidth : '60%',
					data : collide
				} ]
			};
				var eccharts2 = echarts.init($("#eccharts2")[0]);
				eccharts2.setOption(option2);
			
		});	
	
	});   
	
//----------------------------------------------------------初始化选择时间；

//----------------------------------------------------------地域规律
 $(".singleDiverRuleAreaTime").click(function(){	
	 
	 var model = $(this).text();
	 var a = $(this).attr("value");

		$('.device-singleDiverRuleAreaTime-button1').html(model+"<span class=caret></span>");	
		
		$('.device-singleDiverRuleAreaTime-button1').attr("value", a);
		
		$("#singleDiverRuleAreaTime-ecCharLoading").show();
		$.post("${contextPath}/controller/singleDiverRuleArea", 
				{
			imei:imei,
			timeFlag:a
				},	
				function(result){
					$("#singleDiverRuleAreaTime-ecCharLoading").hide();
					 var data=[];
					 var area=[];
						for (var i = 0; i < result.length; i++) {
							 data.push(result[i].hour); 
							 area.push(result[i].city);
						}
					option4 = {
						tooltip : {
							trigger : 'axis'
						},
						tooltip : {},
						xAxis : {
							name:"地区",
							data : area,
						},
						yAxis : {
							name:"累计时间/小时"
						},
						series : [ {
							name : '累计时间',
							type : 'bar',
							data : data
						} ]
					};
				var eccharts4 = echarts.init($("#eccharts4")[0]);
				eccharts4.setOption(option4);	
		});
		
		
		
		
		
 });









//----------------------------------------------------------驾驶时间规律时间段选择；
	 $(".singleDiverRuleTime").click(function(){
	  var model = $(this).text();
	  var a = $(this).attr("value");
		$('.device-singleDiverRuleTime-button1').html(model+"<span class=caret></span>");	
		$('.device-singleDiverRuleTime-button1').attr("value", a); 
		$("#singleDiverRuleTime-ecCharLoading").show();
		
		$.post("${contextPath}/controller/singleDiverRuleTime",
				{
			imei:imei,
			timeFlag:a,
				},
				function(result){
					$("#singleDiverRuleTime-ecCharLoading").hide();
					var data = [];
					var date = [];
					for (var i = 0; i < result.length; i++) {
						data.push(result[i].number);
						date.push(result[i].hour + "小时");
					}
					option3 = {
						tooltip : {
							trigger : 'axis',
							position : function(pt) {
								return [ pt[0], '10%' ];
							}
						},
						title : {
							left : 'center',
							text : '累计每天驾驶规律',
						},
						xAxis : {
							type : 'category',
							boundaryGap : false,
							data : date
						},
						yAxis : {
							type : 'value',
							boundaryGap : [ 0, '100%' ]
						},

						series : [ {
							name : '在线次数',
							type : 'line',
							smooth : true,
							symbol : 'none',
							sampling : 'average',
							itemStyle : {
								normal : {
									color : 'rgb(255, 70, 131)'
								}
							},
							areaStyle : {
								normal : {
									color : new echarts.graphic.LinearGradient(0,
											0, 0, 1, [ {
												offset : 0,
												color : 'rgb(255, 158, 68)'
											}, {
												offset : 1,
												color : 'rgb(255, 70, 131)'
											} ])
								}
							},
							data : data
						} ]
					};
			 var eccharts3 = echarts.init($("#eccharts3")[0]);
				eccharts3.setOption(option3);						 
	    }); 
		
		
		
		
		
	 });


//-----------------------------------------------------------停车监控时间；
$("#devicecollide").click(function(event){
  $(this).find(".dropdown-menu").show();
});
$("#collidetime-confirm").click(function(event){
	
	
	var time1 = $("#collidetime-year1 option:selected").val();
	var time2 = $("#collidetime-month1 option:selected").val();
	var time3 = $("#collidetime-day1 option:selected").val();
	var time4 = time1 + "." + time2 + "." + time3;	

	
	var time5 = $("#collidetime-year2 option:selected").val();
	var time6 = $("#collidetime-month2 option:selected").val();
	var time7 = $("#collidetime-day2 option:selected").val();
	var time8 = time5 + "." + time6 + "." + time7;	
		
	
	var start;
	var end	
	 var mb = BaseUtility.myBrowser();
		if (mb == "Firefox") {
			start = new Date(time1, time2, time3, "", "","");
			end=new Date(time5, time6, time7, "", "","");		
		} else {			
			start = new Date(time4);
			end=new Date(time8);
		}

		var collidetime = baseDate(end, start);	
		if(collidetime<0)
			{
			alert("日期选择错误,开始时间不能大于结束时间");
			}
		if(collidetime>30)
		  {
			alert("时间间隔不能超过30天");
		  }
		  else
		  {
			  $("#collidetime").html(time4 + "-" + time8);
			  $("#devicecollide-ecCharLoading").show();
				$.post("${contextPath}/controller/singleDeviceCollide", {
					imei : imei,
					time1:time4,
					time2:time8
				}, function(data) {
					compileData = data;
					videoData = data;
					$("#devicecollide-ecCharLoading").hide();
					if(data.length=="0")
					{
					$("#devicecollide-text").empty();
					var html="<div class=row id=1>"+"...... 该用户没有监控视频，请选择其他日期"+"</div>";
					 $("#devicecollide-text").append(html);	
					return;
					}
					
					var geoc = new BMap.Geocoder();
					for (var i = 0; i < data.length; i++) {
						var pt = new BMap.Point(data[i].n_lng, data[i].n_lat);
						var point = new BMap.Point(116.331398, 39.897445);
						adds.push(pt);
						addId.push(data[i].n_id);
						var time = data[i].t_data_time;
					
						data[i].t_data_time = BaseUtility.longConvertDate(time);
						
					}
					for (var j = 0; j < data.length; j++) {
						bdGEO();
					}
					showData(data, "#tableObjView", "#tableObj");
				}); 	  
			  
		  
		  }
		
		$("#timeSelect4").hide();
		event.stopPropagation();


});




//----------------------------------------------------------单一驾驶行为时间查询

 $("#singledriverbehavior").click(function(event){
 
  $(this).find(".dropdown-menu").show();
});


$("#singledriverbehaviortime-confirm").click(function(event){
	var time1 = $("#singledriverbehaviortime-year1 option:selected").val();
	var time2 = $("#singledriverbehaviortime-month1 option:selected").val();
	var time3 = $("#singledriverbehaviortime-day1 option:selected").val();
	var time4 = time1 + "." + time2 + "." + time3;	

	
	var time5 = $("#singledriverbehaviortime-year2 option:selected").val();
	var time6 = $("#singledriverbehaviortime-month2 option:selected").val();
	var time7 = $("#singledriverbehaviortime-day2 option:selected").val();
	var time8 = time5 + "." + time6 + "." + time7;	
	$("#singledriverbehaviortime").html(time4 + "-" + time8);	
	

		
		var strs = new Array(); //定义一数组
		var strs2 = new Array(); //定义一数组
		
		// 构造两个日期，分别是系统时间和2013/04/08 12:43:45
		var now = new Date(time8);
		var now1 = now;
		var date = new Date(time4);
		// 调用日期差方法，求得参数日期与系统时间相差的天数
		var diff = baseDate(now, date);
		// 打印日期差			    
		for (var i = diff; i >= 0; i--) {
			var year = now1.getFullYear();
			var month = now1.getMonth() + 1; //js从0开始取 
			var date = now1.getDate();
			strs2[i] = year + "-" + month + "-" + date;
			now1.setDate(now1.getDate() - 1);
		}
	
	
	
	
	
	
	var start;
	var end	
	 var mb = BaseUtility.myBrowser();
		if (mb == "Firefox") {
			start = new Date(time1, time2, time3, "", "","");
			end=new Date(time5, time6, time7, "", "","");		
		} else {			
			start = new Date(time4);
			end=new Date(time8);
		}
		var singledriverbehaviortime = baseDate(end, start);	
		if(singledriverbehaviortime<0)
			{
			alert("日期选择错误,开始时间不能大于结束时间");
			}

	/* 	if(singledriverbehaviortime>7)
		  {
			alert("时间间隔不能超过七天");
		  }else
		  { */
			  //获取单一驾驶行为选项
			 	 var a = $(".device-singledriverbehavior-button1").attr("value");
			    var model=$(".device-singledriverbehavior-button1").text();
			   		$.post("${contextPath}/controller/singleDeviceSingleDriveBehavior", 
			   				{
			   					imei:imei,
			   					behavior:a,
			   					startTime:time4,
			   				    endTime:time8
			   				}, 
			   				function(data) {	
			   					var collide = [];
			   					for (var i =data.length-1; i>=0; i--) {
			   						collide.push(data[i].behavior);
			   					}
			   					var option2 = {
			   						color : [ '#3398DB' ],
			   						tooltip : {
			   							trigger : 'axis',
			   							axisPointer : { // 坐标轴指示器，坐标轴触发有效
			   								type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
			   							}
			   						},
			   						grid : {
			   							left : '3%',
			   							right : '4%',
			   							bottom : '3%',
			   							containLabel : true
			   						},
			   						xAxis : [ {
			   							name : "时间",
			   							type : 'category',
			   							//data : ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
			   							data : strs2,
			   							axisTick : {
			   								alignWithLabel : true
			   							}
			   						} ],
			   						yAxis : [ {
			   							name : "次数",
			   							type : 'value',
			   						} ],
			   						series : [ {
			   							name : model,
			   							type : 'bar',
			   							barWidth : '60%',
			   							data : collide
			   						} ]
			   					};
			   						var eccharts2 = echarts.init($("#eccharts2")[0]);
			   						eccharts2.setOption(option2);
			   					
			   				});	  
		 // }
	$("#timeSelect2").hide();
	event.stopPropagation();
}); 



//------------------------------------------------------驾驶行为选择时间	


$("#driverbehavior").click(function(event){
  $(this).find(".dropdown-menu").show();
});
$("#driverbehaviortime-confirm").click(function(event){
	var time1 = $("#driverbehaviortime-year1 option:selected").val();
	var time2 = $("#driverbehaviortime-month1 option:selected").val();
	var time3 = $("#driverbehaviortime-day1 option:selected").val();
	var time4 = time1 + "." + time2 + "." + time3;	
	var time5 = $("#driverbehaviortime-year2 option:selected").val();
	var time6 = $("#driverbehaviortime-month2 option:selected").val();
	var time7 = $("#driverbehaviortime-day2 option:selected").val();
	var time8 = time5 + "." + time6 + "." + time7;	
	$("#driverbehaviortime").html(time4 + "-" + time8);
	var start;
	var end;

	var strs = new Array(); //定义一数组
	var strs2 = new Array(); //定义一数组
	
	// 构造两个日期，分别是系统时间和2013/04/08 12:43:45
	var now = new Date(time8);
	var now1 = now;
	var date = new Date(time4);
	// 调用日期差方法，求得参数日期与系统时间相差的天数
	var diff = baseDate(now, date);
	// 打印日期差			    
	for (var i = diff; i >= 0; i--) {
		var year = now1.getFullYear();
		var month = now1.getMonth() + 1; //js从0开始取 
		var date = now1.getDate();
		strs2[i] = year + "-" + month + "-" + date;
		now1.setDate(now1.getDate() - 1);
	}
	
	
	
	 var mb = BaseUtility.myBrowser();
		if (mb == "Firefox") {

			start = new Date(time1, time2, time3, "", "","");
			end=new Date(time5, time6, time7, "", "","");
			
		} else {
			
			start = new Date(time4);
			end=new Date(time8);
		}
		var driverbehaviortime = baseDate(end, start);	
		if(driverbehaviortime<0)
			{
			alert("日期选择错误,开始时间不能大于结束时间");
			}
		if(driverbehaviortime>30)
		  {
			alert("时间间隔不能超过30天");
		  }else
		  {
 			$.post("${contextPath}/controller/singleDeviceDriveBehavior", {
 				 imei:imei,
				 time1:time4,
				 time2:time8
			}, function(data) {
				var collide = [];
				var turn = [];
				var speed_up = [];
				var speed_down = [];
				var fatigue=[];
				var grade=[];
			for(var i=data.length-1;i>=0;i--)
				{
				   collide.push(data[i].collide);
				   turn.push(data[i].turn);
				   speed_up.push(data[i].speedUp);
				   speed_down.push(data[i].speepDown);
				   fatigue.push(data[i].fatigue);
				   grade.push(data[i].grade);
				}	
				option = {
					tooltip : {
						trigger : 'axis',
						axisPointer : { // 坐标轴指示器，坐标轴触发有效
							type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
						}
					},
					legend : {
						data : [ '急转弯', '急减速', '急加速', '碰撞', ]
					},
					grid : {
						left : '3%',
						right : '4%',
						bottom : '3%',
						containLabel : true
					},
					xAxis : [ {
						name : "时间",
						type : 'category',
						data : strs2
					} ],
					yAxis : [ {
						name : "次数",
						type : 'value'
					} ],
					series : [{
						name : '综合评分',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : grade,
					},{
						name : '急转弯总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : turn,
					}, {
						name : '急减速总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : speed_down,
					}, {
						name : '急加速总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : speed_up,
					}, {
						name : '碰撞事故总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : collide,
					},{
						name : '疲劳驾驶总次数',
						type : 'bar',
						stack : '总量',
						label : {
							normal : {
								show : true,
								position : 'insideRight'
							}
						},
						data : fatigue,
					},
					]
				};
				var eccharts1 = echarts.init($("#eccharts1")[0]);
				eccharts1.setOption(option);
			});
         }
	$("#timeSelect").hide();
	event.stopPropagation();
});
	//--------------------------------------------------------------历史轨迹时间选择；	
	
		

	  $("#cancel").click(function(event){
          
		  $("#timeSelect").hide();
	
		  event.stopPropagation();
 
          });
	  $("#cancel2").click(function(event){
          
		  $("#timeSelect2").hide();
	
		  event.stopPropagation();
 
          });
	  
	  $("#cancel3").click(function(event){         
		  $("#timeSelect3").hide();	
		  event.stopPropagation();
          });
	  $("#cancel4").click(function(event){          
		  $("#timeSelect4").hide();	
		  event.stopPropagation();
          });

	</script>
</body>
</html>