package com.broadsense.iov.icloud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.broadsense.iov.icloud.util.JsonFormat;

@Controller
public class DeviceController extends BasicController {
	private static Logger logger = Logger.getLogger(DeviceController.class);

	@ResponseBody
	@RequestMapping(value = "basicController/search")
	public Map<String, Object> search(HttpServletRequest request, HttpServletResponse response, String search) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.firstSearch(request, search);
		String state = null;
		if (list.size() > 0) {
			state = "0";
		} else {
			state = "1";
		}
		return JsonFormat.jsonDecode(state, "无", list);
	}

	// --------------分组查询imei号
	@ResponseBody
	@RequestMapping(value = "basicController/groupSearch")
	public Map<String, Object> groupSearch(HttpServletRequest request, HttpServletResponse response, String search, String groupid) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.groupSearch(request, search, groupid);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", 1);
		map.put("rows", list);
		return map;
	}

	// ------------------------------------------一级账号总体模糊查询；
	@ResponseBody
	@RequestMapping(value = "basicController/firstFuzzyAllSearch")
	public Map<String, Object> firstFuzzyAllSearch(HttpServletRequest request, String search) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.firstFuzzyAllSearch(request, search);
		String state = null;
		if (list.size() > 0) {
			state = "0";
		} else {
			state = "1";
		}
		return JsonFormat.jsonDecode(state, "无", list);
	}

	// -------------------------------------------------------------------统计数据；
	// 单个驾驶行为分析；
	@ResponseBody
	@RequestMapping(value = "basicController/singleDriveBehavior")
	public List<Map<String, Object>> singleDriveBehavior(HttpServletRequest request, String behavior, String code, String timeFlag) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.singleDriveBehavior(request, behavior, timeFlag, code);

		return list;
	}

	// ---------------------------------------------------------------------规律活动地域
	@ResponseBody
	@RequestMapping(value = "basicController/ruleActivityArea")
	public List<List<Map<String, Object>>> ruleActivityArea(HttpServletRequest request, String time1, String time2) throws Exception {
		// 设置两个标签；
		List<List<Map<String, Object>>> list = deviceService.ruleActivityArea(request);

		return list;
	}

	// ----------------------------------------------------------------------------驾驶类别;

	@ResponseBody
	@RequestMapping(value = "basicController/divercategory")
	public List<Map<String, Object>> divercategory(HttpServletRequest request, String code) throws Exception {
		// 设置两个标签；

		List<Map<String, Object>> list = deviceService.divercategory(request, code);
		return list;
	}

	// ---------------------------------------------------------------------------驾驶规律时间段
	@ResponseBody
	@RequestMapping(value = "basicController/diverRuleTime")
	public List<Map<String, Object>> diverRuleTime(HttpServletRequest request, String code) throws Exception {
		// 设置两个标签；

		List<Map<String, Object>> list = deviceService.diverRuleTime(request, code);

		return list;
	}

	// ----------------------------------------------------------------------------驾驶行为评分；
	@ResponseBody
	@RequestMapping(value = "basicController/DriveBehaviorGrade")
	public List<Map<String, Object>> DriveBehaviorGrade(HttpServletRequest request, String code, String timeFlag) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.DriveBehaviorGrade(request, timeFlag, code);
		return list;
	}

	
	
	
	// ------------------------------------------------------------------------------设备监控-用户列表；
	@ResponseBody
	@RequestMapping(value = "basicController/userList")
	public Map<String, Object> userList(HttpServletRequest request, String offset, String order, String sort, String timeFlag, String timeFlag1) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		Map<String, Object> map = null;
		if (("").equals(timeFlag) || null == timeFlag) {
			map = deviceService.getUserList(request, Integer.valueOf(offset), order, sort, null, timeFlag1);
		} else {
			System.out.println("timeFlag is ---" + timeFlag);
			map = deviceService.getUserList(request, Integer.valueOf(offset), order, sort, timeFlag, null);
		}
		return map;
	}

	// ------------------------------------------------------------------------单个设备主页-移动；
	@ResponseBody
	@RequestMapping(value = "basicController/homepageDevice")
	public List<Map<String, Object>> homepageDevice(HttpServletRequest request, String imei) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.homepageDevice(imei);
		return list;
	}

	// --------------------------------------------------------------------单个设备-驾驶行为分析；
	@ResponseBody
	@RequestMapping(value = "basicController/singleDeviceDriveBehavior")
	public List<Map<String, Object>> singleDeviceDriveBehavior(HttpServletRequest request, String imei, String time1, String time2) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.singleDeviceDriveBehavior(request, imei, time1, time2);

		return list;
	}

	// --------------------------------------------------------------------单个设备-单一驾驶行为分析；
	@ResponseBody
	@RequestMapping(value = "basicController/singleDeviceSingleDriveBehavior")
	public List<Map<String, Object>> singleDeviceSingleDriveBehavior(HttpServletRequest request, String imei, String behavior, String startTime, String endTime) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.singleDeviceSingleDriveBehavior(request, imei, behavior, startTime, endTime);
		return list;
	}

	// --------------------------------------------------------------------单个设备-
	// 停车监控碰撞视频
	@ResponseBody
	@RequestMapping(value = "basicController/singleDeviceCollide")
	public List<Map<String, Object>> singleDeviceCollide(HttpServletRequest request, String imei, String time1, String time2) throws Exception {
		// 设置两个标签；

		List<Map<String, Object>> list = null;
		list = deviceService.singleDeviceCollide(imei, time1, time2);
		return list;
	}

	// --------------------------------------------------------------------单个设备-
	// 驾驶规律时间段
	@ResponseBody
	@RequestMapping(value = "basicController/singleDiverRuleTime")
	public List<Map<String, Object>> singleDiverRuleTime(HttpServletRequest request, String imei, String timeFlag) throws Exception {
		// 设置两个标签；

		List<Map<String, Object>> list = null;

		list = deviceService.singleDiverRuleTime(imei, timeFlag);

		return list;
	}

	// ----------------------------------------------------------------单个设备-地域规律

	@ResponseBody
	@RequestMapping(value = "basicController/singleDiverRuleArea")
	public List<Map<String, Object>> singleDiverRuleArea(HttpServletRequest request, String imei, String timeFlag) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = deviceService.singleDiverRuleArea(request, imei, timeFlag);
		return list;
	}

	// ----------------------------------------------------------------单个设备其他的轨迹；

	@ResponseBody
	@RequestMapping(value = "basicController/singleDiverTrave")
	public List<Object> singleDiverTrave(HttpServletRequest request, String imei, String time1, String time2) throws Exception {
		// 设置两个标签；
		List<Object> list = null;
		list = deviceService.singleDiverTrave(request, imei, time1, null);
		return list;
	}

	// -------------------------------------------------------------显示单个轨迹 的驾车行为

	@ResponseBody
	@RequestMapping(value = "basicController/drive")
	public List<Map<String, Object>> singleTraveDiverSingleTrave(HttpServletRequest request, String imei, String time1, String time2) throws Exception {
		// 设置两个标签；

		List<Map<String, Object>> list = null;
		/*
		 * list = deviceService.singleTraveDiverSingleTrave(request,
		 * "862811020345770", time1, time2);
		 */

		return list;
	}
	
	
	

}
