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
    <script src="${contextPath}/js/ajaxfileupload.js"></script>
    <script src="${contextPath}/js/laytpl.js"></script>
    <script src="http://cdn.bootcss.com/bootstrap-table/1.9.1/locale/bootstrap-table-zh-CN.min.js"></script>  
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
		             <jsp:param name="title" value="登录页面"/> 
		            </jsp:include>
				<jsp:include page="/WEB-INF/basicPage/firstSearch.jsp">
	                <jsp:param name="title" value="登录页面"/> 
	            </jsp:include>
	            
        	</div>
    	</div>
    </nav>
	
	<div class="container-fluid">
		<div class="row">
        	<div class="col-sm-12 col-md-12 main">
        		<h3 class="page-header">售后安装网点备用机统计与换机申请</h3>
        		<div class="row">
        			<div class="panel panel-default qgfhsq" id="as-region">
        				<!-- <button type="button" class="btn btn-default"><a class="as-region"  value="allcode" href="#">全国</a></button>
        				<button type="button" class="btn btn-default"><a class="as-region"  value="50" id="chongqi" >重庆市</a></button>
        				<button type="button" class="btn btn-default"><a class="as-region"  value="37" id="shandong">山东省</a></button>
        				<button type="button" class="btn btn-default"><a class="as-region"  value="44" id="guangdong">广东省</a></button>
        				<button type="button" class="btn btn-default"><a class="as-region"  value="43" id="hainan">湖南省</a></button>
        				<button type="button" class="btn btn-default"><a class="as-region"  value="35" id="fujian">福建省</a></button> -->
        				<a class="as-region btn btn-default"  value="allcode" href="#">全国</a>
        				<a class="as-region btn btn-default"  value="50" id="chongqi" >重庆市</a>
        				<a class="as-region btn btn-default"  value="37" id="shandong">山东省</a>
        				<a class="as-region btn btn-default"  value="44" id="guangdong">广东省</a>
        				<a class="as-region btn btn-default"  value="43" id="hainan">湖南省</a>
        				<a class="as-region btn btn-default"  value="35" id="fujian">福建省</a>
					</div>
				</div>
				    <div class="row">
        			<div class="panel panel-default qgfhsq" id="city">
        			
					</div>
				    </div>
        		<h3 class="page-header">备用机安装数量统计</h3>
        		
	       		<!--    <div class="row">
	       		      <button type="button" class="btn btn-primary pull-right" id="addWebSite">添加网点</button>
	       		      <button type="button" class="btn btn-primary pull-right" id="deleteWebSite">删除网点</button>
				   </div> -->
        		
        		<div class="row">
        			<div class="panel panel-default qgfhsq">
						<!--备用机安装数量统计模板-->
						<table id="byjazsltjTable"></table>
					</div>
			  	</div>
      			<h3 class="page-header">备用机更换统计</h3>
				<div class="row">
					<div class="bs-tabs qgfhsq">
						<ul id="myTab" class="nav nav-tabs" role="tablist">
							<li role="presentation" class="active"><a  href="#home" id="home-tab" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true">全国换机统计</a></li>
							<li role="presentation" class=""><a href="#profile" role="tab" id="profile-tab" data-toggle="tab" aria-controls="profile" aria-expanded="false">全国发货统计</a></li>
						</ul>
						<div id="myTabContent" class="tab-content">
							<div role="tabpanel" class="tab-pane fade active in" id="home" aria-labelledby="home-tab">
								<div class="panel panel-default">
									<div class="panel-heading clearfix">
										<form class="navbar-form navbar-left" role="search">
											<div class="form-group">
												<input type="text" class="form-control" placeholder="Search"id="change-search1">
											</div>
										</form>
										<button class="btn btn-primary" id="change-search">搜索</button>
									<!-- 	<button id="testChange" class="btn btn-default">更换备用机</button> -->
										<button class="btn btn-default"><a href="${contextPath}/controller/afterSaleExport">导出</a></button>
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
	</div>
		<!--添加售后网点模态弹窗-->
	<div class="modal fade" id="addWebSite-fhqr" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">发货确认</h4>
		  		</div>
		  		<div class="modal-body">
		  		   <div class="ecCharLoading" id="addWebSite-ecCharLoading"></div>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-3 control-label">安装网点地区</label>
							<div class="col-sm-8">
								<div class="row">
								<div class="col-sm-4">
									 <select name="addWebSite-city1" id="addWebSite-city1" class="form-control"
						      onChange="findsubcity('addWebSite-city1','addWebSite-city2','addWebSite-city3')">
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
										<select class="form-control" name="addWebSite-city2" id="addWebSite-city2"
											onChange="findsubcity1('addWebSite-city2','addWebSite-city3')">
						                    <option>请选择市</option>
										</select>
									</div>
									<div class="col-sm-4" >
										<select class="form-control" name="addWebSite-city3" id="addWebSite-city3">
										<option >请选择区/县</option>
										</select>
									</div>
								</div>
								
							</div>
					  	</div>
					  	<div class="form-group">
					  	<label class="col-sm-3 control-label">安装网点</label>
						<div class="col-sm-8">
							<input type="text" class="form-control form-control1" placeholder="" id="add-install-website">
						</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">详细地址</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1" placeholder="" id="addWebSite-addresss">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">联系人</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1" placeholder="" id="addWebSite-contacts">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	
					  	<div class="form-group">
							<label class="col-sm-3 control-label">联系电话</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1"  id="addWebSite-telephone" >
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否培训</label>
							<div class="col-sm-8">
								<div style="margin-right: 10px;" class="radio pull-left">
									<label>
								  		<input type="radio" name="addWebSite-test1"  value="0" >
								  		否
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="addWebSite-test1"  value="1" >
								  		是
									</label>
								</div>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" id ="addWebSite-confirm" class="btn btn-primary saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
			<!--添加售后网点模态弹窗-->
	<div class="modal fade" id="deleteWebSite-fhqr" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">发货确认</h4>
		  		</div>
		  		<div class="modal-body">
		  		   <div class="ecCharLoading" id="deleteWebSite-ecCharLoading"></div>
					<form class="form-horizontal" role="form">
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否删除</label>
							<div class="col-sm-8">
								<div style="margin-right: 10px;" class="radio pull-left">
									<label>
								  		<input type="radio" name="deleteWebSite-test1"  value="0" >
								  		否
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="deleteWebSite-test1"  value="1" >
								  		是
									</label>
								</div>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" id ="deleteWebSite-confirm" class="btn btn-primary saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
	
	
	
	<!--发货确认模态弹窗-->
	<!--添加发货确认模态弹窗-->
	<div class="modal fade" id="fhqr1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">发货确认</h4>
		  		</div>
		  		<div class="modal-body">
		  		   <div class="ecCharLoading" id="ecCharLoading1"></div>
					<form class="form-horizontal" role="form">
						<div class="form-group">
							<label class="col-sm-3 control-label">分公司地区</label>
							<div class="col-sm-8">
								<div class="row">
								<div class="col-sm-4">
									 <select name="add-city1" id="add-city1" class="form-control"
						onChange="findsubcity('add-city1','add-city2','add-city3')">
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
					  	<label class="col-sm-3 control-label">安装网点</label>
						<div class="col-sm-8">
							<select class="form-control" name="install-website" id="install-website">
							</select>
						</div>
						</div>
						<div class="form-group">
							<label class="col-sm-3 control-label">发货人</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1" placeholder="" id="add-send-shipper">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
						
						<div class="form-group">
							<label class="col-sm-3 control-label">收货人</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1" placeholder="" id="add-send-receiver">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	
					  	<div class="form-group">
							<label class="col-sm-3 control-label">发货数量</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1"  id="add-send-number" >
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
								  		<input type="radio" name="add-test1"  value="0" >
								  		正常发货
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="add-test1"  value="1" >
								  		备用机
									</label>
								</div>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">快递单号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control form-control1" placeholder="" id="add-send-expressId">
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
								  		<input type="radio" name="add-test2"  value="0" >
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
	<!--发货确认模态弹窗-->
	
	
	<!--换机申请模态弹窗-->
	<div class="modal fade" id="hjsq" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">备用机IMEI号</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
					   <div class="form-group">
							<label class="col-sm-3 control-label">备用机IMEI号</label>
							<div class="col-sm-8">
								<select class="form-control" id="change-spare-imei">
									<option value="R611">R611</option>
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<input type="hidden" class="form-control" placeholder="" value="" id="changId">
					  	
						<div class="form-group">
							<label class="col-sm-3 control-label">替换机IMEI号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="change-respace-imei">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">备注信息</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="3" id="change-remark" ></textarea>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否寄回</label>
							<div class="col-sm-8">
								<div style="margin-right: 10px;" class="radio pull-left">
									<label>
								  		<input type="radio" name="change-text"  value="1" checked="">
								  		是
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="change-text"  value="0" checked="true">
								  		否
									</label>
								</div>
							</div>
					  	</div>
					  	<div class="form-group" hidden="hidden" id="change-expressId1">
							<label class="col-sm-3 control-label">寄回快递单号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="change-expressId">
							</div>
					  	</div>
					  	<div class="form-group" hidden="hidden" id="change-charge1">
							<label class="col-sm-3 control-label">快递费用</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="change-charge">
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" class="btn btn-primary change-saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
		<!--安装网点换机申请模态弹窗-->
	<div class="modal fade" id="hjsq1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">备用机IMEI号</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
					   <div class="form-group">
							<label class="col-sm-3 control-label">备用机IMEI号</label>
							<div class="col-sm-8">
								<select class="form-control" id="change-spare-imei1">
									<option value="R611">868156416464464</option>
								</select>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<input type="hidden" class="form-control" placeholder="" value="" id="changId1">
					  	
						<div class="form-group">
							<label class="col-sm-3 control-label">替换机IMEI号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="change-respace-imei1">
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	<div class="form-group">
							<label class="col-sm-3 control-label">备注信息</label>
							<div class="col-sm-8">
								<textarea class="form-control" rows="3" id="change-remark1" ></textarea>
							</div>
							<label class="col-sm-1 must">*</label>
					  	</div>
					  	
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否寄回</label>
							<div class="col-sm-8">
								<div style="margin-right: 10px;" class="radio pull-left">
									<label>
								  		<input type="radio" name="change-text1"  value="1" checked="">
								  		是
									</label>
								</div>
								<div class="radio pull-left">
									<label>
								  		<input type="radio" name="change-text1"  value="0" checked="true">
								  		否
									</label>
								</div>
							</div>
					  	</div>
					  	<div class="form-group" hidden="hidden" id="change-expressId11">
							<label class="col-sm-3 control-label">寄回快递单号</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="change-expressId2">
							</div>
					  	</div>
					  	<div class="form-group" hidden="hidden" id="change-charge11">
							<label class="col-sm-3 control-label">快递费用</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" placeholder="" id="change-charge2">
							</div>
					  	</div>
    				</form>
		  		</div>
		  		<div class="modal-footer">
		  			<button type="button" class="btn btn-primary change-saveBtn1">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	
	
	
		<!--收货确认模态弹窗-->
	<div class="modal fade" id="fhqr2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
		  		<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title" id="myModalLabel">收货确认</h4>
		  		</div>
		  		<div class="modal-body">
					<form class="form-horizontal" role="form">
					  	<div class="form-group">
							<label class="col-sm-3 control-label">是否收货</label>
								<input type="hidden"   value=""  id="sendId-confirm">
							<div class="col-sm-9">
								<div style="margin-right: 10px;" class="radio3 pull-left">
									<label>
								  		<input type="radio" name="test1"  value="1" >
								  		是
									</label>
								</div>
								<div class="radio2 pull-left">
									<label>
								  		<input type="radio" name="test1"  value="0" >
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
		  			<button type="button" id ="send-confirm-state" class="btn btn-primary saveBtn">确定</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		  		</div>
			</div>
		</div>
	</div>
	<script>
	var webSiteId=null;
	var region="allcode";
	var name=null;
	$(".as-region").on("click", function(){
		
		 name = $(this).text();
	   	 region = $(this).attr("value");
	    	$('#qgfhsqtjTable').bootstrapTable('refresh', {
				silent : true
			});
	       	$('#qgbyjtjTable').bootstrapTable('refresh', {
				silent : true
			});
	       	$('#byjazsltjTable').bootstrapTable('refresh', {
				silent : true
			});
	       	$("#home-tab").text(name+"换机统计");
	       	$("#profile-tab").text(name+"发货统计");
	        $("#city").empty();
	       	if(region!="allcode")
	       		{
	       		$.ajax({
	       			type : 'GET',
	       			url : "${contextPath}/controller/code_region?code=" + region,
	       			dataType : 'json',
	       			cache : 'ture',
	       			success : function(data) {
	     				$.each(data, function(index, entry) {
	     					//<a class="as-region btn btn-default"  value="50" id="chongqi" >重庆市</a>
	     					//if(entry['c_city']!=name){
	     						//var html ='<button type="button" class="btn btn-default"><a class="as-region1" value='+entry['c_code']+'>'+entry['c_city']+'</a></button>';	
	     						var html ='<a class="as-region1 btn btn-default" value='+entry['c_code']+'>'+entry['c_city']+'</a>';		
	    	     				$("#city").append(html);	
	     					//}
	     				}); 
	       			}
	       		})
	       		}
	        $('.as-region').removeClass('active');
            $(this).addClass('active');	
	});
	
	$("#city").click(function(event){
		var code=$(event.target).attr("value");
		 name = $(event.target).text();
		 $('#city a').removeClass('active');
         $(event.target).addClass('active');	
		 
	   	 if(region.length==2)
	   		 {
	   		 region = region+code;
	   		 }else
	   			 {
	   			 region = region.substring(0, 2)+code;
	   			 }
	   	if(name.length<5)
	   		{
	   		$('#qgfhsqtjTable').bootstrapTable('refresh', {
				silent : true
			});
	       	$('#qgbyjtjTable').bootstrapTable('refresh', {
				silent : true
			});
	       	$('#byjazsltjTable').bootstrapTable('refresh', {
				silent : true
			});
	       	$("#home-tab").text(name+"换机统计");
	       	$("#profile-tab").text(name+"发货统计"); 
	   		}
	});
	
	
	
	//上传文件事件；
	var sendId=null;
	$("#add-exampleInputFile").bind("change",function(){
		var file=$("input[name='file1']").val(); 
		var filename=file.replace(/.*(\/|\\)/, ""); 
		var fileExt=(/[.]/.exec(filename)) ? /[^.]+$/.exec(filename.toLowerCase()) : '';  
		 if(fileExt!="xlsx")
			 {
			 alert("上传文件类型错误,请重新上传文件")
			 }else{
               $("#add-upload-state").text("正在上传");
				 ajaxFileUpload(); 
			 }
		  });
	//上传文件；
	 function ajaxFileUpload() {
            $.ajaxFileUpload
            (
                {
                    url: '${contextPath}/controller/sendAsFileUpload', //用于文件上传的服务器端请求地址
                    secureuri: false, //是否需要安全协议，一般设置为false
                    fileElementId: 'add-exampleInputFile', //文件上传域的ID
                    dataType: 'json', //返回值类型 一般设置为json
                    success: function (data, status)  //服务器成功响应处理函数
                    {
                   	 if(data.error.length>0)
                   		 {
                   		 var imeiRrror=data.error;
                   		 alert("以下imei号无法导入:"+imeiRrror);
                   		 }else
                   			 {
                   			 $("#add-upload-state").text("上传完成");
                   			 }
                 	$("#add-exampleInputFile").bind("change",function(){
                		var file=$("input[name='file1']").val(); 
                		var filename=file.replace(/.*(\/|\\)/, ""); 
                		var fileExt=(/[.]/.exec(filename)) ? /[^.]+$/.exec(filename.toLowerCase()) : '';  
                		 if(fileExt!="xlsx")
                			 {
                			 alert("上传文件类型错误,请重新上传文件")
                			 }else{
                               $("#add-upload-state").text("正在上传");
                				 ajaxFileUpload(); 
                			 }
                		  });
                    },
                }
            )
            return false;
        }
	
	 
	$("#deleteWebSite-confirm").click(function(){
		
    	$.post("${contextPath}/controller/deleteAfterSaleWebSite", {
    		webSiteId : webSiteId,
    	}, function(data) {
    		
    		  if(data.state!="0")
	            {
	            	alert("删除失败，参数错误");	
	            }else
          	{
          	alert("删除成功");	
          	$('#byjazsltjTable').bootstrapTable('refresh', {
					silent : true
				});
          	webSiteId=null;
          	}
    		  
    		  $("#deleteWebSite-fhqr").modal("hide");	  
    
    	});
		
		
	});
	
	
	//添加售后网点；
	$("#addWebSite-confirm").click(function(){
		/* addWebSite-test1 */
		   var city1 = $("#addWebSite-city1 option:selected").text();
		   var city2 = $("#addWebSite-city2 option:selected").text();
		   var city3 = $("#addWebSite-city3 option:selected").text();
		   var cityCode1=$("#addWebSite-city1 option:selected").attr("value");
		   var cityCode2=$("#addWebSite-city2 option:selected").attr("value");
		   var cityCode3=$("#addWebSite-city3 option:selected").attr("value");
		  
		   var region=cityCode1+cityCode2+cityCode3;
	
		   if(cityCode1==undefined||cityCode1==""||cityCode2==undefined||cityCode2==""||cityCode3==undefined||cityCode3=="")
		   {
		       alert("请填选完整地区选择");
		       return;
		   }
		   var installWebSite=$("#add-install-website").val();
		   var  address=$("#addWebSite-addresss").val();
		   var contacts =$("#addWebSite-contacts").val();
		   var telephone = $("#addWebSite-telephone").val();
		   var falg = $('.radio  input[name="addWebSite-test1"]:checked ').val();
		  
		   var obj = {};
			obj['region'] = region;
			obj['installWebSite'] = installWebSite;
			obj['address'] = address;
			obj['contacts'] = contacts;
			obj['telephone'] = telephone;
			obj['falg'] = falg;
			$("#addWebSite-ecCharLoading").show();
			$.ajax({
		        url: '${contextPath}/controller/addAfterSaleWebSite',
		        method: 'post',
		        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
		        data: JSON.stringify(obj), // 以json字符串方式传递
		        success: function(data) {
		        	$("#addWebSite-ecCharLoading").hide();
		            if(data.state!="0")
		            {
		            	alert("添加失败，参数填写错误");	
		            }else
	            	{
	            	alert("添加成功");	
	            	$('#byjazsltjTable').bootstrapTable('refresh', {
						silent : true
					});
	            	}
		            $("#addWebSite-fhqr").modal("hide");
		        },
		    });
		
	});
	
	
	
	
	
		$(function(){
			$("#test").click(function(){
				$("#addNewFenzuModal2").modal();
			});
			
			//添加售后网点
			$("#addWebSite").click(function(){
				$("#addWebSite-ecCharLoading").hide();
				$("#addWebSite-fhqr").modal();
			});
			//删除售后网点
			
			$("#deleteWebSite").click(function(){
				$("#deleteWebSite-ecCharLoading").hide();
				if(webSiteId==null||webSiteId=="")
					{
					alert("请选择网点");
					}else{
						
						$("#deleteWebSite-fhqr").modal();	
					}
			});

			
			$("#testAdd").click(function(){
				$("#ecCharLoading1").hide();
				$(".form-control1").val(""); 
				if(region.length=="2")
					{
                       /* $("#add-city1 option:selected").text(name);
		        	   $('#add-city1 option:selected').attr("value", region);	 */
		        	   $("#add-city1").val(region);
		        		$.ajax({
		        			type : 'GET',
		        			url : "${contextPath}/controller/code_region?code=" + region,
		        			dataType : 'json',
		        			cache : 'ture',
		        			success : function(data) {
		        				$("#add-city3 option").remove();
		        				$("#add-city2 option").remove();
		        				
		        				var option1 = "<option value='" + 1 + "'>" + "请选择市" + "</option>";
		        				$("#add-city2").append(option1);

		        				var option2 = "<option value='" + 1 + "'>" + "请选择县" + "</option>";
		        				$("#add-city3").append(option2);
		        				
		        				$.each(data, function(index, entry) {
		        					
		        					var option = "<option value='" + entry['c_code'] + "'>"
		        							+ entry['c_city'] + "</option>";
		        	               
		        					/*if(entry['c_city']!=cityName)
		        					{*/
		        						$("#add-city2").append(option);	
		        					/*}*/
		        					
		        				
		        				});

		        			}
		        		})
					}
				if(region.length=="4")
					{
					$("#add-city1").val(region.substring(0,2));
					//$("#add-city2").val(region.substring(2,4));
					$("#add-city2 option").remove();
					var option = "<option value=0 >请选择市</option>";
					$("#add-city2").append(option);
					$("#add-city2 option:selected").text(name);
		        	$('#add-city2 option:selected').attr("value",region.substring(2,4));	
		        	
		        	$.post("${contextPath}/controller/code_region1", {
		        		code : name
		        	}, function(result) {
		        		$("#add-city3 option").remove();
		        		$.each(result, function(index, entry) {
		        			var option = "<option value='" + entry['c_code'] + "'>"
		        					+ entry['c_county'] + "</option>";
        					if(entry['c_county']!=name)
        					{
		        				$("#add-city3").append(option);
        					}
		        		});
		        	});
				}
				$("#fhqr1").modal();
			});
			$("#testChange").click(function(){
				$("#hjsq").modal();
			});
			
			
			
			
			
			
			
			
			
			
			
			
			
			$("#add-city3").bind("change",function(){ 
		        //请求安装网点；           
			   var city1 = $("#add-city1 option:selected").text();
			   var city2 = $("#add-city2 option:selected").text();
			   var city3 = $("#add-city3 option:selected").text();
			   var cityCode1=$("#add-city1 option:selected").attr("value");
			   var cityCode2=$("#add-city2 option:selected").attr("value");
			   var cityCode3=$("#add-city3 option:selected").attr("value");
			  
			   var region=cityCode1+cityCode2+cityCode3;
				
				$.post("${contextPath}/controller/afterSaleWebSiteMsg", {
					region :region,
					offset : "0",
					order : "desc",
					sort : "n_id"
				}, function(result) {
					$("#install-website option").remove();
				for(var i=0;i<result.rows.length;i++)
					{
					var option = "<option value='" +result.rows[i].n_id  + "'>"
					+result.rows[i].c_install_website + "</option>";
				
					$("#install-website").append(option);
					}
				
				}); 
			 }); 
			
			
			
			//添加发货确认
			$("#add-send-confirm").click(function(){
				
	 		   var city1 = $("#add-city1 option:selected").text();
			   var city2 = $("#add-city2 option:selected").text();
			   var city3 = $("#add-city3 option:selected").text();
			   var cityCode1=$("#add-city1 option:selected").attr("value");
			   var cityCode2=$("#add-city2 option:selected").attr("value");
			   var cityCode3=$("#add-city3 option:selected").attr("value");
			   if(cityCode1==undefined||cityCode1==""||cityCode2==undefined||cityCode2==""||cityCode3==undefined||cityCode3=="")
			   {
			       alert("请填选完整地区选择");
			       return;
			   }
			   
			   var region=cityCode1+cityCode2+cityCode3;
			   var address=$("#add-send-address").val();
			   var  shipper=$("#add-send-shipper").val();
			   var number =$("#add-send-number").val();
			   var model = $("#add-send-model option:selected").text();
			   var sendType = $('.radio  input[name="add-test1"]:checked ').val();
			   var receiveState=$('.radio1  input[name="add-test2"]:checked ').val();
			   var expressId=$("#add-send-expressId").val();

			   var websiteId=$("#install-website option:selected").attr("value");
			   if(address==""||receiveState==""||receiveState==undefined||number==""||expressId==""||sendType==""||sendType==undefined)
			   {
			   alert("请把信息填完整");
			   return;
			   }
			
			   var obj = {};
				obj['region'] = region;
				obj['address'] = address;
				obj['number'] = number;
				obj['model'] = model;
				obj['sendType'] = sendType;
				obj['receiveState'] = receiveState;
				obj['expressId'] = expressId;
				obj['websiteId'] = websiteId;
				obj['area'] =city1+city2+city3;
				obj['receiver'] =$("#add-send-receiver").val();
				obj['shipper'] = shipper;
				$("#ecCharLoading1").show();
				$.ajax({
			        url: '${contextPath}/controller/sendAfterSale',
			        method: 'post',
			        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
			        data: JSON.stringify(obj), // 以json字符串方式传递
			        success: function(data) {
			        	$("#ecCharLoading1").hide();
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
			            $("#fhqr1").modal("hide");
			        },
			    });  
				
			});
			$("#send-confirm-state").click(function(){
				   var sendId=$("#sendId-confirm").val();
				   var receiveState=$('.radio3  input[name="test1"]:checked ').val();
				   var obj = {};
				   obj['sendId'] = sendId;
				   if(receiveState=="1")
					 {
						$.ajax({
					        url: '${contextPath}/controller/sendAfterSaleEdit',
					        method: 'post',
					        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
					        data: JSON.stringify(obj), // 以json字符串方式传递
					        success: function(data) {
					            if(data.state!="0")
					            {
					            	alert("修改失败，参数填写错误");	
					            }else
				            	{
				            	alert("收货成功");	
				            	$('#qgfhsqtjTable').bootstrapTable('refresh', {
									silent : true
								});
				            	}
					            $("#fhqr2").modal("hide");
					        },
					    }); 
					 }else{
						 $("#fhqr2").modal("hide"); 
					 }
				   
				});

			//售后发货申请
			$('#qgfhsqtjTable').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/afterSaleSendMsg",
				pagination : true,
				sidePagination : "server",//服务器分页     	    
				pageSize : 10,
				sortable : true,
				sortOrder : "desc",
				sortName : "t_send_time",
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
						field: 'c_shipper',
						title: '发货人'
					}, 
					{
						field: 'c_number',
						title: '发货备用机数量'
					},
					{
						field: 'c_receiver',
						title: '收货人'
					},
					{
						field: 'c_address',
						title: '收货地址'
					},
					{
						field: 'c_express_message',
						title: '快递信息'
					},
					{
						field: 'c_receiver_state',
						title: '确认收货',
						formatter: receiverFormatter,
					},
					{
						field: 'handle',
						title: '操作',
						formatter: operateFormatter,
						events:'actionEvents',
					}
				],
			});
			function timeFormatter(value, row, index){
				if(value!=null){
					value=BaseUtility.longConvertDate(value);	
				}
				return value;
			}
			function operateFormatter(value, row, index){
				
				var obj = {};
				obj['flag'] = "0";
				obj['recordId']=row.n_id;
				var html=null;
		  		$.ajax({
			        url: '${contextPath}/controller/afterSaleShowLog',
			        method: 'post',
			        async : false,
			        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
			        data: JSON.stringify(obj), // 以json字符串方式传递
			        success: function(data) {
			        $('.popover').remove();
			        if(data.state=="0")
			        	{
			        	var result=data.result;
						for(var i=0;i<result.length;i++)
							{
							if(html==null){
								html='<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';	
							}else
								{
								html=html+'<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';
								}
							}
			        	}
			        },
			    });
		  		
				return [
					'<div class="glyphicon-box"><span class="glyphicon glyphicon-edit glyphicon-edit1 "></span></div>',
					'<div class="glyphicon-box"><span  data-content="'+html+'" class="glmoreinfo glyphicon glyphicon-info-sign"></span></div>'
				].join('');
				
			}
			function receiverFormatter(value, row, index){
				
				if(value=="1")
					{
					value="是";
					}else
						{
						value="否"
						}
				return value; 
			}
			function getParams(params) {
				return {
					region:region,
 					offset : params.offset,
					sort : params.sort,
					order : params.order 
				};
			}	

			//售后交换机信息
			$('#qgbyjtjTable').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/afterSaleChangMsg",
				pagination : true,
				sidePagination : "server",//服务器分页     	    
				pageSize : 10,
				sortable : true,
				sortOrder : "desc",
				sortName : "t_time",
				pageNumber : 1,
				pageList : [ 10 ],
				queryParams : getParams,
				clickToSelect : true,//选择行即选择checkbox  
				singleSelect : true,//仅允许单选  
				//{"n_id":1,"c_region":"432200","c_express_message":null,"c_send_id":null,"c_spare_imei":"123456789","c_spare_state":null,"c_express_id":null,"c_install_state":null,"c_charge":null,"c_model":null,"c_remark":"屏幕损坏","c_receive_state":"1","c_respace_imei":"6546321987","t_time":1478102400000,"c_website_id":"广东深圳市"}
				columns: [
			      	{
						field: 'n_id',
						visible:false,
					},
					{
						field: 't_time',
						title: '时间',
						formatter: timeFormatter
					}, 
					{
						field: 'c_website_id',
						title: '安装网点名称',
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
						field: 'c_install_message',
						title: '安装状态'
					},
					{
						field: 'c_express_message',
						title: '寄回信息'
					},
					{
						field: 'c_charge',
						title: '快递费用'
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
			function operateFormatter1(value, row, index){
				var obj = {};
				obj['flag'] = "1";
				obj['recordId']=row.n_id;
				var html=null;
		  		$.ajax({
			        url: '${contextPath}/controller/afterSaleShowLog',
			        method: 'post',
			        async : false,
			        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
			        data: JSON.stringify(obj), // 以json字符串方式传递
			        success: function(data) {
			        if(data.state=="0")
			        	{
			        	var result=data.result;
						for(var i=0;i<result.length;i++)
							{
							if(html==null){
								html='<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';	
							}else
								{
								html=html+'<p>'+result[i].t_create_time+' '+result[i].c_content+'</p>';
								}
							}  
			        	}
			        },
			    });
		  		
				return [
					'<div class="glyphicon-box"><span class="glyphicon glyphicon-edit glyphicon-edit2"></span></div>',
					'<div class="glyphicon-box"><span  data-content="'+html+'" class=" glmoreinfo glyphicon glyphicon-info-sign"></span></div>'
				].join('');
			}
			
			$('#qgbyjtjTable').on('load-success.bs.table', function(){
				addPopover();
			});
			
			$('#qgfhsqtjTable').on('load-success.bs.table', function(){
				addPopover();
			});
			var testTarget;
			function addPopover(){
				$('.glmoreinfo').popover({
					container: 'body',
					placement: 'left',
					html: true
				});
			 }
			
			$(document).click(function(ev){
				if($('.popover')[0] && $.contains($('.popover')[0], ev.target)){
					return;
				}
				if(ev.target != testTarget){
					$(testTarget).popover('hide');
				}
			});
			
			
			window.actionEvents = {
					'click .glmoreinfo': function(e, value, row, index){
						if(testTarget && testTarget != e.target){
							$(testTarget).popover('hide');
						}
						testTarget = e.target;
					},		
					
					'click .glyphicon-edit1': function (e, value, row, index) {
						
						if(row.c_receiver_state=="1")
							{
							alert("已经处理完毕")
							}else{
								$("#fhqr2").modal();
								$("#sendId-confirm").val(row.n_id);	
							}
					},
					
		           'click .glyphicon-edit2': function (e, value, row, index) {
		        	   console.log(row)
		        	   $("#hjsq").modal();
		        	   $("#changId").val(row.n_id);
		        	   $("#change-spare-imei option:selected").text(row.c_spare_imei);
		        	   $('#change-spare-imei option:selected').attr("value", "1");
		        	   $("#change-respace-imei").val(row.c_respace_imei);
		        	   $("#change-remark").val(row.c_remark);
		        	   $("#change-expressId").val(row.c_express_id);
		        	   $("#change-charge").val(row.c_charge);
		        	   if(row.c_express_id==null||("")==row.c_express_id)
		        		   {
		        		   $('.radio input[name=change-text]').removeAttr('checked');
						   $('.radio input[name=change-text][value='+"0"+']').prop("checked", true);
						   $("#change-charge1").hide();
						   $("#change-expressId1").hide();
		        		   }else
		        			   {
		        			   $('.radio input[name=change-text]').removeAttr('checked');
							   $('.radio input[name=change-text][value='+"1"+']').prop("checked", true);
							   $("#change-charge1").show();
							   $("#change-expressId1").show();
		        			   
		        			   }
					},
				};
		
			//监听单选按钮的事件；
			$("input:radio[name='change-text']").change(function (){ //拨通
				 var expressFlag = $('.radio  input[name="change-text"]:checked ').val();
			     if(expressFlag=="1")
			    	 {
			    	 $("#change-charge1").show();
					 $("#change-expressId1").show();
			    	 }else
			    		 {
			    		 $("#change-charge1").hide();
						 $("#change-expressId1").hide();
			    		 }
			});
			$("input:radio[name='change-text1']").change(function (){ //拨通
				 var expressFlag = $('.radio  input[name="change-text1"]:checked ').val();
			     if(expressFlag=="1")
			    	 {
			    	 $("#change-charge11").show();
					 $("#change-expressId11").show();
			    	 }else
			    		 {
			    		 $("#change-charge11").hide();
						 $("#change-expressId11").hide();
			    		 }
			});	
			$(".change-saveBtn").click(function(){
				   var changeId=$("#changId").val();
				   var respaceImei=$('#change-respace-imei').val();
				   var remark=$("#change-remark").val();
				   var expressId=$("#change-expressId").val();
			       var charge=$("#change-charge").val();
				   var obj = {};
				   obj['afterSaleChangId'] = changeId;
				   obj['respaceImei'] = respaceImei;
				   obj['remark'] = remark;
				   obj['expressId'] = expressId;
				   obj['charge'] = charge;
						$.ajax({
					        url: '${contextPath}/controller/afterSaleChangEdit',
					        method: 'post',
					        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
					        data: JSON.stringify(obj), // 以json字符串方式传递
					        success: function(data) {
					            if(data.state!="0")
					            {
					            	alert("修改失败，参数填写错误");	
					            }else
				            	{
				            	alert("替换成功");	
				            	$('#qgbyjtjTable').bootstrapTable('refresh', {
									silent : true
								});
				            	}
					            $("#hjsq").modal("hide");
					        },
					    }); 
				});
			
			//搜索信息；
			$("#change-search").click(function(){
				   var search=$("#change-search1").val();
				   $.post("${contextPath}/controller/searchAfterSale", {
					   afterSaleImei : search,
					   region:"allcode",
					}, function(data) {
						
						if(data.total=="0")
							{
							alert("没有次imei号");
							}else
								{
								$('#qgbyjtjTable').bootstrapTable('load', data);	
								}
					});
				});
		     //售后网点；
			$('#byjazsltjTable').on('click-row.bs.table', function (e, row, $element) {
		    		$('.success').removeClass('success');
		    		$($element).addClass('success');
		    		webSiteId=row.n_id;
		  	});
			$('#byjazsltjTable').bootstrapTable({
				method : 'get',
				url : "${contextPath}/controller/afterSaleWebSiteMsg",
				pagination : true,
				sidePagination : "server",//服务器分页     	    
				pageSize : 10,
				sortable : true,
				sortOrder : "desc",
				sortName : "n_id",
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
						field: 'c_install_website',
						title: '安装网点名称',
					}, 
					{
						field: 'n_count',
						title: '剩余备用机数量'
					},
					{
						field: 'c_address',
						title: '地址'
					},
					{
						field: 'c_contacts',
						title: '联系人'
					},
					{
						field: 'c_telephone',
						title: '电话'
					},
					{
						field: 'n_falg',
						title: '是否培训',
						formatter:falgFormatter,
					},
					{
						field: 'handle',
						title: '操作',
						formatter: function(value, row, index){
							if(row.n_count!="0")
							{
								return '<button type="button" class="btn btn-primary applyAsChange">申请换机</button>';	
							}else{
								return '没有数据';
							}
						},
						events: {
							'click .btn-primary': function (e, value, row, index) {
								//初始化参数;
								//根据id查询安装网点有几个imei号
						   $.post("${contextPath}/controller/afterSaleWebSiteImei", {
							   webSiteId : row.n_id,
								}, function(data) {
								   if(data.state=="0")
									   {
									   $("#change-spare-imei1 option").remove();
									   for(var i=0;i<data.result.length;i++)
										   {
										   var imei=data.result[i].c_spare_imei;
											var option1 = "<option value="+data.result[i].n_id+" >" + imei + "</option>";
											$("#change-spare-imei1").append(option1);
										   }
									   }
								});
				        	   $("#change-respace-imei1").val(row.c_respace_imei);
				        	   $("#change-remark1").val(row.c_remark);
				        	   $("#change-expressId2").val(row.c_express_id);
				        	   $("#change-charge2").val(row.c_charge);
				        	   if(row.c_express_id==null||("")==row.c_express_id)
				        		   {
				        		   $('.radio input[name=change-text1]').removeAttr('checked');
								   $('.radio input[name=change-text1][value='+"0"+']').prop("checked", true);
				        		   }else
				        			   {
				        			   $('.radio input[name=change-text1]').removeAttr('checked');
									   $('.radio input[name=change-text1][value='+"1"+']').prop("checked", true);
									   $("#change-charge11").show();
									   $("#change-expressId11").show();
				        			   }
									$("#hjsq1").modal();
							},
						}
					}
				],
	
			});
			function falgFormatter(value, row, index){
				if(value=="0")
					{
					value="否";
					}else{
					value="是";	
					}
				return value;
			}
			
			$(".change-saveBtn1").click(function(){
				   var changeId=$("#change-spare-imei1 option:selected").attr("value");
				/*    var respaceImei=$("#change-spare-imei1 option:selected").text(); */
				   
				   var respaceImei=$("#change-respace-imei1").val();
				   
				   
				   var remark=$("#change-remark1").val();
				   var expressId=$("#change-expressId2").val();
			       var charge=$("#change-charge2").val();
				   var obj = {};
				   obj['afterSaleChangId'] = changeId;
				   obj['respaceImei'] = respaceImei;
				   obj['remark'] = remark;
				   obj['expressId'] = expressId;
				   obj['charge'] = charge;
						$.ajax({
					        url: '${contextPath}/controller/afterSaleChangEdit',
					        method: 'post',
					        contentType: 'application/json', // 这句不加出现415错误:Unsupported Media Type
					        data: JSON.stringify(obj), // 以json字符串方式传递
					        success: function(data) {
					            if(data.state!="0")
					            {
					            	alert("修改失败，参数填写错误");	
					            }else
				            	{
				            	alert("替换成功");	
				            	$('#qgbyjtjTable').bootstrapTable('refresh', {
									silent : true
								});
				               	$('#byjazsltjTable').bootstrapTable('refresh', {
									silent : true
								});
				            	}
					            $("#hjsq1").modal("hide");
					        },
					    }); 
				});
		});
	</script>
</body>
</html>