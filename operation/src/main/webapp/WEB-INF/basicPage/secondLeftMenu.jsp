<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
						<div class="col-sm-12 col-md-2">
							<div class="panel-group" id="sbglSidebar" role="tablist" aria-multiselectable="true">
					
								<div class="panel panel-default">
									<div class="panel-heading active" role="tab" id="headingTwo">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse" data-parent="#sbglSidebar" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
												设备管理
											</a>
										</h4>
									</div>
									<div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
										<div class="panel-body">
											<ul class="list-group" id="admin-group">
												<!-- <li class="list-group-item">全部设备</li> -->
												<li class="list-group-item"><a href="${contextPath2}secondDeviceClient">全部设备</a></li>
												
											</ul>
										</div>
									</div>
								</div>
								<div class="panel panel-default">
									<div class="panel-heading active" role="tab" id="headingThree">
										<h4 class="panel-title">
											<a class="collapsed" data-toggle="collapse" data-parent="#sbglSidebar" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
												账号管理
											</a>
										</h4>
									</div>
									<div id="collapseThree" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
										<div class="panel-body">
											<ul class="list-group">
												<li class="list-group-item"><a href="${contextPath2}secondPersonalAdminAccount">个人账户</a></li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
	<script id="leftMenu" type="text/html">
	{{# for(var i = 0, len = d.length; i < len; i++){ }}
       <li data-n_id={{d[i].n_id}}   data-c_group_name={{d[i].c_group_name}}  class="list-group-item">
       <a href="${contextPath2}firstDeviceImei?groupId={{d[i].n_id}}">{{d[i].c_group_name}}</a>
       </li>
   {{# } }}
	</script>

	













