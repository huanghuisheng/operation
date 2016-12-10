package com.broadsense.iov.icloud.serviceImpl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.broadsense.iov.icloud.dao.BasicDao;
import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.entity.DeviceClient;
import com.broadsense.iov.icloud.service.DeviceService;
import com.broadsense.iov.icloud.service.GroupService;
import com.broadsense.iov.icloud.util.DateUtil;
import com.broadsense.iov.icloud.util.GetAddress;

@Service("groupService")
public class GroupServiceImpl extends BasicService implements GroupService {

	// 分页查询；返回操作日志
	public Map<String, Object> showOperationlog(HttpServletRequest request, String offset, String order, String sort) throws Exception {
		List<Map<String, Object>> list = groupDao.queryOperationSum();
		int userNumber = Integer.valueOf(String.valueOf(list.get(0).get("number")));
		List<Map<String, Object>> listUser = groupDao.queryOperationList(Integer.valueOf(offset), order, sort);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", userNumber);
		map.put("rows", listUser);
		return map;

	}

	// ------------------------------------日志查询；
	public Map<String, Object> searchOperationlog(HttpServletRequest request, String offset, String name, String type, String time1, String time2) throws Exception {
		Date date1 = DateUtil.StringToDateStart(time1, "yyyy.MM.dd HH:mm:ss");
		Date date2 = DateUtil.StringToDateEnd(time2, "yyyy.MM.dd HH:mm:ss");
		List<Map<String, Object>> OperationList = groupDao.searchOperationList(Integer.valueOf(offset), name, type, date1, date2);
		List<Map<String, Object>> list = groupDao.searchOperationSum(name, type, date1, date2);
		int userNumber = Integer.valueOf(String.valueOf(list.get(0).get("number")));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", userNumber);
		map.put("rows", OperationList);
		return map;

	}

	// 新增分组；
	public List<Map<String, Object>> firstAccoutSaveGroup(HttpServletRequest request, String groupName) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_group_name", groupName);
		Object o = groupDao.basicInsertData("iov_administrator_group", map);
		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "新增" + groupName + "分组", day, adminDepartment);
		}

		// 查询生成的分组；
		List<Map<String, Object>> list = groupDao.basicQueryByString("iov_administrator_group", "c_group_name=?", groupName);
		// 用户id
		int adminId = Integer.valueOf(String.valueOf(request.getSession().getAttribute("adminId")));
		// 获取被账号的分组信更新；
		List<Map<String, Object>> list1 = groupDao.basicQueryById("iov_system_administrator", adminId);
		String group = String.valueOf(list1.get(0).get("c_group"));
		String group1 = group + "," + String.valueOf(list.get(0).get("n_id"));
		Map<String, Object> adminMap = new HashMap<String, Object>();
		adminMap.put("c_group", group1);
		groupDao.basicUpdate("iov_system_administrator", adminMap, "n_id=" + adminId);
		return list;

	}

	// 删除分组；

	public String firstAccoutDeleteGroup(HttpServletRequest request, int groupid) throws Exception {
		// 删除分组id
		Object o = groupDao.basicDeleteData("iov_administrator_group", groupid);
		// request.getSession().getAttribute("username");
		// 用户id
		int adminId = Integer.valueOf(String.valueOf(request.getSession().getAttribute("adminId")));
		// 删除管理员表的group的id
		List<Map<String, Object>> list = groupDao.basicQueryById("iov_system_administrator", adminId);
		String group = String.valueOf(list.get(0).get("c_group"));
		// 1,2,3,4,7
		String group1 = group.replace("," + groupid, "");
		Map<String, Object> adminMap = new HashMap<String, Object>();
		adminMap.put("c_group", group1);
		groupDao.basicUpdate("iov_system_administrator", adminMap, "n_id=" + adminId);
		// 更新group
		if (o.equals("0")) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_delete", "删除分组", day, adminDepartment);
			return "0";
		}

	}

	// 更新分组；
	public String firstAccoutUpdateGroup(HttpServletRequest request, int groupid, String groupName) throws Exception {
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_group_name", groupName);
		Object o = groupDao.basicUpdate("iov_administrator_group", fields, "n_id=" + groupid);
		System.out.println("分组修改问题+++" + groupName);
		if (o.equals(0)) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_update", "更新" + groupName + "分组", day, adminDepartment);
			return "0";
		}

	}

	// 显示分组信息；
	public List<Map<String, Object>> firstAccoutShowGroup(HttpServletRequest request) throws Exception {
		// 用户id
		System.out.println("-------------------" + request.getSession().getAttribute("adminId"));
		int adminId = Integer.valueOf(String.valueOf(request.getSession().getAttribute("adminId")));
		// 获取当前用户id ,
		List<Map<String, Object>> list = groupDao.basicQueryById("iov_system_administrator", adminId);
		// 存储分组信息；
		List<Map<String, Object>> listGroup = new ArrayList<Map<String, Object>>();
		// 获取当前用户分组信息；
		String group = String.valueOf(list.get(0).get("c_group"));
		String[] mingroup = group.split(",");
		for (int i = 0; i < mingroup.length; i++) {
			if (!mingroup[i].equals("")) {
				// 查询分组；
				List<Map<String, Object>> mingroupList = groupDao.basicQueryById("iov_administrator_group", Integer.valueOf(mingroup[i]));
				listGroup.add(mingroupList.get(0));
			}
		}
		return listGroup;
	}

	// 单个分组信息
	public List<Map<String, Object>> singleShowGroupName(HttpServletRequest request, String groudId) throws Exception {
		List<Map<String, Object>> list = groupDao.basicQueryById("iov_administrator_group", Integer.valueOf(groudId));
		return list;
	}

	// ---------------------------------------------------------------设备管理；

	public List<Map<String, Object>> addDeviceImei(HttpServletRequest request, String imei, int groupid) throws Exception {
		// 获取分组信息；
		List<Map<String, Object>> group = groupDao.basicQueryById("iov_administrator_group", groupid);
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_imei", imei);
		fields.put("c_group_id", groupid);
		Object o = groupDao.basicInsertData("iov_administrator_group_imei", fields);
		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "新增设备号为" + imei, day, adminDepartment);
		}
		List<Map<String, Object>> list = groupDao.basicQueryByFields("iov_administrator_group_imei", fields);
		return list;

	}

	public List<Map<String, Object>> addDeviceImeiGroup(HttpServletRequest request, List imei, int groupid) throws Exception {
		// 获取分组信息；
		
		List<Map<String, Object>> listImeiSum = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> addList = new ArrayList<Map<String, Object>>();
		for (int i = 0; i < imei.size(); i++) {
			List<Map<String, Object>> listImei = new ArrayList<Map<String, Object>>();
			String imei1 = String.valueOf(imei.get(i));
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("c_imei", imei1);
			map.put("c_group_id", groupid);
			// 判断是否已经插入imei号
			listImei = groupDao.basicQueryByFields("iov_administrator_group_imei", map);
			if (listImei.size() == 0) {
				Map<String, Object> fields = new HashMap<String, Object>();
				fields.put("c_imei", imei1);
				fields.put("c_group_id", groupid);
				addList.add(fields);
				System.out.println("----------"+fields);
				
				//Object o = groupDao.basicInsertData("iov_administrator_group_imei", fields);
			}
		}
		Object o =groupDao.insertMobileBatch(addList);
		
		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "批量导入新增设备", day, adminDepartment);
		}
		return listImeiSum;

	}

	public String updateDeviceImei(HttpServletRequest request, String imei, int groupid, int id) throws Exception {
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_group_id", groupid);
		fields.put("c_imei", imei);
		Object o = groupDao.basicUpdate("iov_administrator_group_imei", fields, "n_id=" + id);
		if (o.equals(0)) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_update", "更新设备" + imei, day, adminDepartment);
			return "0";

		}

	}

	public String deleteDeviceImei(HttpServletRequest request, String imei, int groupid) throws Exception {
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_group_id", groupid);
		fields.put("c_imei", imei);
		Object o = groupDao.basicDeleteData("iov_administrator_group_imei", groupid);
		if (o.equals(0)) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_delete", "删除设备号为" + imei, day, adminDepartment);
			return "0";
		}
	}

	// 显示分组imei号
	public Map<String, Object> showGroupImei(HttpServletRequest request, String groupid, int offset) throws Exception {
		String groupName = String.valueOf(groupDao.basicQueryById("iov_administrator_group", Integer.valueOf(groupid)).get(0).get("c_group_name"));
		// 总imei号；
		List<Map<String, Object>> listImei = groupDao.queryGroupImeiList(Integer.valueOf(groupid), offset);
		// 用户量
		List<Map<String, Object>> sumlistImei = groupDao.queryGroupImeiSum(Integer.valueOf(groupid));
		int sumImei = Integer.valueOf(String.valueOf(sumlistImei.get(0).get("number")));
		if (listImei.size() > 0) {
			for (int i = 0; i < listImei.size(); i++) {
				listImei.get(i).put("c_group_id", groupName);
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", sumImei);
		map.put("rows", listImei);
		return map;
	}

	// ---------------------------------------------------账号管理；
	// 显示用户账号
	public List<Map<String, Object>> showAdminAccout(HttpServletRequest request) throws Exception {
		// 用户id
		int adminId = Integer.valueOf(String.valueOf(request.getSession().getAttribute("adminId")));
		List<Map<String, Object>> listAccout = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> listGroup = groupDao.basicQueryById("iov_system_administrator", adminId);
		String group = String.valueOf(listGroup.get(0).get("c_group"));
		String[] groupId = group.split(",");
		for (int i = 0; i < groupId.length; i++) {
			if (!groupId[i].equals("")) {
				List<Map<String, Object>> group1 = groupDao.basicQueryByString("iov_system_administrator", "c_department=?", groupId[i]);
				if (group1.size() > 0) {
					// 添加所属分组名称；
					for (int j = 0; j < group1.size(); j++) {
						String groupid = String.valueOf(group1.get(j).get("c_department"));

						String groupName = String.valueOf(groupDao.basicQueryById("iov_administrator_group", Integer.valueOf(groupid)).get(0).get("c_group_name"));

						group1.get(j).put("c_groupName", groupName);

						listAccout.add(group1.get(j));
					}
				}
			}
		}
		return listAccout;
	}

	public List<Map<String, Object>> addAdminAccount(HttpServletRequest request, Administrator admin) throws Exception {
		// 用户id
		String type = String.valueOf(request.getSession().getAttribute("adminType"));
		// String type = administrator.getAdminType();
		String adminType = "0";
		if (type.equals("1")) {
			adminType = "2";
		} else if (type.equals("2")) {
			adminType = "3";
		}
		String department = admin.getAdminDepartment();
		List<Map<String, Object>> list = groupDao.basicQueryByString("iov_system_administrator", "c_department=?", department);
		String group = "";
		if (list.size() > 0) {
			group = String.valueOf(list.get(0).get("c_group"));
		}
		admin.setAdminType(adminType);
		admin.setAdminGroup(group);
		// 保存
		Map<String, Object> fields = new HashMap<String, Object>();
		Map<String, Object> fields1 = new HashMap<String, Object>();
		fields.put("c_name", admin.getAdminName());
		fields.put("c_password", admin.getAdminPassword());
		fields.put("c_type", admin.getAdminType());
		fields.put("c_group", admin.getAdminGroup());
		fields.put("c_department", admin.getAdminDepartment());
		fields.put("c_role", admin.getAdminRole());
		fields.put("c_telephone", admin.getAdminTelephone());
		fields.put("c_remark", admin.getAdminRemark());
		fields1.put("c_name", admin.getAdminName());

		Object o = groupDao.basicInsertData("iov_system_administrator", fields);
		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "新增用户" + admin.getAdminName(), day, adminDepartment);
		}
		List<Map<String, Object>> listReturn = groupDao.basicQueryByFields("iov_system_administrator", fields1);
		String groupid = String.valueOf(listReturn.get(0).get("c_department"));
		String groupName = String.valueOf(groupDao.basicQueryById("iov_administrator_group", Integer.valueOf(groupid)).get(0).get("c_group_name"));
		listReturn.get(0).put("c_groupName", groupName);
		return listReturn;
	}

	// 删除 账号
	public String deleteAdminAccount(HttpServletRequest request, String adminId) throws Exception {
		Object o = groupDao.basicDeleteData("iov_system_administrator", Integer.valueOf(adminId));
		if (o.equals("0")) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_delete", "删除用户", day, adminDepartment);
			return "0";
		}

	}

	public String updateAdminAccount(HttpServletRequest request, Administrator admin) throws Exception {
		// 保存
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_name", admin.getAdminName());
		fields.put("c_password", admin.getAdminPassword());
		// fields.put("c_type", admin.getAdminType());
		// fields.put("c_group", admin.getAdminGroup());
		fields.put("c_department", admin.getAdminDepartment());
		fields.put("c_role", admin.getAdminRole());
		fields.put("c_telephone", admin.getAdminTelephone());
		fields.put("c_remark", admin.getAdminRemark());
		Object o = groupDao.basicUpdate("iov_system_administrator", fields, "n_id=" + admin.getAdminId());
		if (o.equals("0")) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_update", "更新用户" + admin.getAdminName(), day, adminDepartment);
			return "0";
		}
	}

	// ---------------------------------------------------------个人账号管理；
	public String updatePersonalAdminAccount(HttpServletRequest request, String adminName) throws Exception {
		// 用户id
		String admin = String.valueOf(request.getSession().getAttribute("adminId"));
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_name", adminName);
		Object o = groupDao.basicUpdate("iov_system_administrator", fields, "n_id=" + admin);
		if (o.equals("0")) {
			return "1";
		} else {
			request.getSession().setAttribute("username", adminName);
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_update", "更新个人账号" + adminName, day, adminDepartment);
			return "0";
		}

	}

	public String updatePersonalAdminAccount1(HttpServletRequest request, String oldAdminPass, String adminPass1) throws Exception {
		// 用户id
		String adminId = String.valueOf(request.getSession().getAttribute("adminId"));
		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_password", adminPass1);
		Object o = groupDao.basicUpdate("iov_system_administrator", fields, "n_id=" + adminId);
		if (o.equals("0")) {
			return "1";
		} else {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_update", "更新个人账号密码", day, adminDepartment);
			return "0";
		}

	}

	// --------------------------------------------------------------------------设备-用户
	// 添加设备-用户

	public void addDeviceClient(HttpServletRequest request, DeviceClient deviceClient) throws Exception {

		// 用户id
		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));

		// String groupid=administrator.getAdminDepartment();

		deviceClient.setImeiRroup(groupid);

		Map<String, Object> fields = new HashMap<String, Object>();

		fields.put("c_client_name", deviceClient.getClientName());
		fields.put("c_imei", deviceClient.getClientImei());
		fields.put("c_car_number", deviceClient.getCarNumber());
		fields.put("c_remark", deviceClient.getClientRemark());
		fields.put("c_group", deviceClient.getImeiRroup());

		Object o = groupDao.basicInsertData("iov_device_client", fields);
		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "二级账号新增设备" + deviceClient.getClientImei(), day, adminDepartment);
		}

	}

	public void deleteDeviceClient(HttpServletRequest request, String deviceClientId) throws Exception {
		Object o = groupDao.basicDeleteData("iov_device_client", Integer.valueOf(deviceClientId));

		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "二级账号删除设备", day, adminDepartment);
		}

	}

	public void updateDeviceClient(HttpServletRequest request, DeviceClient deviceClient) throws Exception {

		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		// String groupid=administrator.getAdminDepartment();

		deviceClient.setImeiRroup(groupid);

		Map<String, Object> fields = new HashMap<String, Object>();

		fields.put("c_client_name", deviceClient.getClientName());
		fields.put("c_imei", deviceClient.getClientImei());
		fields.put("c_car_number", deviceClient.getCarNumber());
		fields.put("c_remark", deviceClient.getClientRemark());
		fields.put("c_group", deviceClient.getImeiRroup());

		Object o = groupDao.basicUpdate("iov_device_client", fields, "n_id=" + deviceClient.getClientId());

		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_update", "二级账号更新设备" + deviceClient.getClientImei(), day, adminDepartment);
		}
	}

	// 批量添加设备-用户
	public void addDeviceClientGroup(HttpServletRequest request, List<List> listImei1) throws Exception {

		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		System.out.println("------size os-------" + listImei1.size());
		
		List<Map<String,Object>> addList=new ArrayList<Map<String,Object>>();
		

		for (int i = 0; i < listImei1.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("c_group", groupid);
			map.put("c_imei", listImei1.get(i).get(0));
			// 判断是否已存在次imei号；
			List<Map<String, Object>> list = groupDao.basicQueryByFields("iov_device_client", map);
			if (list.size() == 0) {
				System.out.println("--------------" + listImei1.get(i));
				Map<String, Object> fields = new HashMap<String, Object>();
				fields.put("c_imei", listImei1.get(i).get(0));
				fields.put("c_client_name", listImei1.get(i).get(1));
				fields.put("c_car_number", listImei1.get(i).get(2));
				fields.put("c_remark", listImei1.get(i).get(3));
				fields.put("c_group", groupid);
				//Object o = groupDao.basicInsertData("iov_device_client", fields);
				addList.add(fields);
			}
		}
		//批量导入；
		Object o=groupDao.insertClientBatch(addList);
		
		if (!o.equals(0)) {
			// 插入日志；
			Date day = new Date();
			String userName = String.valueOf(request.getSession().getAttribute("username"));
			String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			String address = GetAddress.getIpAddr(request);
			BasicDao.operationLogInsertData(userName, address, "user_add", "二级账号批量新增设备", day, adminDepartment);
		}
		
		
		
		

	}

	// 显示二级账号；
	public Map<String, Object> showSecondeClientAccout(HttpServletRequest request, int offset) throws Exception {

		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		// String groupId=administrator.getAdminDepartment();

		// List<Map<String, Object>>
		// list=secondAccountDao.basicQueryByString("iov_device_client",
		// "c_group=?", groupid);
		// querySecondImeiList

		List<Map<String, Object>> listImei = groupDao.querySecondImeiList(Integer.valueOf(groupid), offset);

		List<Map<String, Object>> listSum = groupDao.querySecondImeiSum(Integer.valueOf(groupid));

		String total = String.valueOf(listSum.get(0).get("number"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", total);
		map.put("rows", listImei);
		return map;
	}

	// 分组模糊查询
	public List<Map<String, Object>> fuzzySearch(HttpServletRequest request, String search, String groupid) throws Exception {
		List<Map<String, Object>> list = groupDao.queryFuzzyGroupImeiList(groupid, search + "%");
		return list;
	}

	// -------------------------------------------------------二级用户查询；
	// 搜索；
	public Map<String, Object> secondSearch(HttpServletRequest request, String search) throws Exception {

		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));

		Map<String, Object> map = new HashMap<String, Object>();

		map.put("c_group", groupid);
		map.put("c_imei", search);

		List<Map<String, Object>> list = groupDao.basicQueryByFields("iov_device_client", map);

		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("total", "1");
		map2.put("rows", list);

		return map2;

	}

}
