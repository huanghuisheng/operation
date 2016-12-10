package com.broadsense.iov.icloud.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.broadsense.iov.base.data.entity.TravelEntity;
import com.broadsense.iov.icloud.entity.Administrator;

public interface DeviceService {
	// ------------------------------------------一级账号总体模糊查询；
	public List<Map<String, Object>> firstFuzzyAllSearch(HttpServletRequest request, String search) throws Exception;


	// --------------搜索
	public List<Map<String, Object>> firstSearch(HttpServletRequest request, String search) throws Exception;

	// --------------分组查询imei号
	public List<Map<String, Object>> groupSearch(HttpServletRequest request, String search, String groupid) throws Exception;

	// --------------------------------------------------------------统计数据分析；
	// 单个驾驶行为；
	public List<Map<String, Object>> singleDriveBehavior(HttpServletRequest request, String behavior, String timeFlag, String code) throws Exception;

	// ---------------------------------------------------------------------规律活动地域
	public List<List<Map<String, Object>>> ruleActivityArea(HttpServletRequest request) throws Exception;

	// ----------------------------------------------------------------------驾驶类别；
	public List<Map<String, Object>> divercategory(HttpServletRequest request, String code) throws Exception;

	// ---------------------------------------------------------------------驾驶规律时间段；
	public List<Map<String, Object>> diverRuleTime(HttpServletRequest request, String code) throws Exception;

	// 驾驶行为评分；
	public List<Map<String, Object>> DriveBehaviorGrade(HttpServletRequest request, String timeFlag, String code) throws Exception;
	
	
	

	// ------------------------------------------------------------------------单个设备主页-移动；
	public List<Map<String, Object>> homepageDevice(String imei) throws Exception;

	// --------------查询用户列表；
	public Map<String, Object> getUserList(HttpServletRequest request, int beginIndex, String order, String sort, String timeFlag, String timeFlag1) throws Exception;

	// --------------------------------------------------------------------单个设备-驾驶行为分析；
	public List<Map<String, Object>> singleDeviceDriveBehavior(HttpServletRequest request, String imei, String startTime, String endTime) throws Exception;

	// --------------------------------------------------------------------单个设备-单一驾驶行为分析；
	public List<Map<String, Object>> singleDeviceSingleDriveBehavior(HttpServletRequest request, String imei, String behavior, String startTime, String endTime) throws Exception;

	// --------------------------------------------------------------------单个设备-
	// 碰撞视频
	public List<Map<String, Object>> singleDeviceCollide(String imei, String startTime, String endTime) throws Exception;

	// --------------------------------------------------------------------单个设备-
	// 驾驶规律时间段
	public List<Map<String, Object>> singleDiverRuleTime(String imei, String timeFlag) throws Exception;

	// ----------------------------------------------------------------单个设备-地域规律
	public List<Map<String, Object>> singleDiverRuleArea(HttpServletRequest request, String imei, String timeFlag) throws Exception;

	// ----------------------------------------------------------------单个设备其他的轨迹；
	public List<Object> singleDiverTrave(HttpServletRequest request, String imei, String time1, String time2) throws Exception;

	

}
