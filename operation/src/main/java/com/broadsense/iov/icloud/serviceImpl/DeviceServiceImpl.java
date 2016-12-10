package com.broadsense.iov.icloud.serviceImpl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.broadsense.iov.base.data.entity.LacEntity;
import com.broadsense.iov.base.data.entity.TravelEntity;
import com.broadsense.iov.icloud.dao.BasicDao;
import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.service.DeviceService;
import com.broadsense.iov.icloud.util.CoordinateUtil;
import com.broadsense.iov.icloud.util.DateUtil;
import com.broadsense.iov.icloud.util.GetAddress;
import com.broadsense.iov.icloud.util.GetTrack;
import com.broadsense.iov.icloud.util.UserAccount;

@Service("deviceService")
public class DeviceServiceImpl extends BasicService implements DeviceService {
	private static Logger logger = Logger.getLogger(DeviceServiceImpl.class);

	// ------------------------------------------一级账号总体模糊查询；
	public List<Map<String, Object>> firstFuzzyAllSearch(HttpServletRequest request, String search) throws Exception {
		// 判断是账号1还是2
		Object type = request.getSession().getAttribute("adminType");
		System.out.println("type is " + type);

		String group = null;
		System.out.println("search is --" + search);
		if (type.equals("2")) {
			group = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		}
		List<Map<String, Object>> list = deviceDao.queryFuzzyGroupImeiList(group, search + "%");
		return list;
	}

	// --------------分组查询imei号
	public List<Map<String, Object>> groupSearch(HttpServletRequest request, String search, String groupid) throws Exception {

		Map<String, Object> fields = new HashMap<String, Object>();
		fields.put("c_group_id", groupid);
		fields.put("c_imei", search);
		List<Map<String, Object>> list = deviceDao.basicQueryByFields("iov_administrator_group_imei", fields);
		return list;

	}

	// 搜索；
	public List<Map<String, Object>> firstSearch(HttpServletRequest request, String search) throws Exception {
		List<Map<String, Object>> list;
		Object type = request.getSession().getAttribute("adminType");
		String group = null;
		System.out.println("search is --" + search);
		if (type.equals("2")) {
			String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));
			Map<String, Object> fields = new HashMap<String, Object>();
			fields.put("c_group_id", groupid);
			fields.put("c_imei", search);
			list = deviceDao.basicQueryByFields("iov_administrator_group_imei", fields);
		} else {

			list = deviceDao.basicQueryByString("iov_administrator_group_imei", "c_imei=?", search);
		}
		return list;
	}

	// 分页查询；返回总用户量、和用户数据
	public Map<String, Object> getUserList(HttpServletRequest request, int beginIndex, String order, String sort, String timeFlag, String timeFlag1) throws Exception {
		Date dateTime1;
		Date dateTime2;
		String timeFlagAll;
		// 所属分组；
		String groupId = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		List<Map<String, Object>> list;
		if (("").equals(timeFlag) || null == timeFlag) {

			List<Date> listDate = DateUtil.stringToDateTimeFlag(timeFlag1);
			dateTime1 = listDate.get(0);
			dateTime2 = listDate.get(1);
			timeFlagAll = timeFlag1;
			list = deviceDao.queryUserSum1(Integer.valueOf(groupId), dateTime1, dateTime2, timeFlag1);
		} else {
			list = deviceDao.queryUserSum(Integer.valueOf(groupId), timeFlag);
			List<Date> listDate = DateUtil.stringToDateTimeFlag(timeFlag);
			timeFlagAll = timeFlag;
			dateTime1 = listDate.get(0);
			dateTime2 = listDate.get(1);
		}
		int userNumber = Integer.valueOf(String.valueOf(list.get(0).get("number")));
		List<Map<String, Object>> listUser = deviceDao.queryUserList(groupId,beginIndex, order, sort, dateTime1, dateTime2, timeFlagAll);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", userNumber);
		map.put("rows", listUser);
		return map;
	}

	// --------------------------------------------------------------统计数据分析；
	// ----------------------------------------------------------------------驾驶行为评分

	public List<Map<String, Object>> DriveBehaviorGrade(HttpServletRequest request, String timeFlag, String code) throws Exception {
		
		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		// 获取所有的数据；
		List<Map<String, Object>> listBehavior = deviceDao.getBehaviour(timeFlag, code,groupid);
		int number1 = 0, number2 = 0, number3 = 0, number4 = 0, number5 = 0, number6 = 0, number7 = 0, number8 = 0, number9 = 0, number10 = 0;
		// 所用用户驾驶行为评分
		float gradeSum = 0;
		// 所有用户驾驶行为平均分
		float grade = 0;
		// 保存每个用户的驾驶评分
		float behaviornumber[] = new float[listBehavior.size()];
		for (int i = 0; i < listBehavior.size(); i++) {
			String c_driver = String.valueOf(listBehavior.get(i).get("c_driver"));
			JSONObject jsonObject = JSONObject.fromObject(c_driver);
			float userGrade = Float.valueOf(jsonObject.getString("grade"));
			behaviornumber[i] = userGrade;
			gradeSum += userGrade;
			if (userGrade >= 90) {
				number10++;
			} else if (userGrade >= 80) {
				number9++;
			} else if (userGrade >= 70) {
				number8++;
			} else if (userGrade >= 60) {
				number7++;
			} else if (userGrade >= 50) {
				number6++;
			} else if (userGrade >= 40) {
				number5++;
			} else if (userGrade >= 30) {
				number4++;
			} else if (userGrade >= 20) {
				number3++;
			} else if (userGrade >= 10) {
				number2++;
			} else if (userGrade >= 0) {
				number1++;
			}
		}
		if (listBehavior.size() > 0) {
			grade = gradeSum / listBehavior.size();
		}
		BigDecimal b = new BigDecimal(grade);
		grade = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
		float variance = 0;
		if (listBehavior.size() > 0) {
			variance = UserAccount.getVariance(behaviornumber);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("behaviorGrade", grade);
		map.put("variance", variance);
		map.put("allUser", listBehavior.size());
		map.put("number1", number1);
		map.put("number2", number2);
		map.put("number3", number3);
		map.put("number4", number4);
		map.put("number5", number5);
		map.put("number6", number6);
		map.put("number7", number7);
		map.put("number8", number8);
		map.put("number9", number9);
		map.put("number10", number10);
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		list.add(map);
		return list;
	}

	// 单个驾驶行为；
	public List<Map<String, Object>> singleDriveBehavior(HttpServletRequest request, String behavior, String timeFlag, String code) throws Exception {
		
		String groupid = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		// 获取所有的数据；
		List<Map<String, Object>> listBehavior = deviceDao.getBehaviour(timeFlag,code,groupid);
		int number1 = 0, number2 = 0, number3 = 0, number4 = 0, number5 = 0, number6 = 0, number7 = 0, number8 = 0, number9 = 0, number10 = 0;
		// 保存每个用户的单一驾驶行为次数
		float behaviornumber[] = new float[listBehavior.size()];
		for (int i = 0; i < listBehavior.size(); i++) {
			String c_driver = String.valueOf(listBehavior.get(i).get("c_driver"));
			JSONObject jsonObject = JSONObject.fromObject(c_driver);
			int behavior1 = Integer.valueOf(jsonObject.getString(behavior));
			behaviornumber[i] = behavior1;
			if (behavior1 > 900) {
				number10++;
			} else if (behavior1 > 700) {
				number9++;
			} else if (behavior1 > 500) {
				number8++;
			} else if (behavior1 > 300) {
				number7++;
			} else if (behavior1 > 250) {
				number6++;
			} else if (behavior1 > 200) {
				number5++;
			} else if (behavior1 > 150) {
				number4++;
			} else if (behavior1 > 100) {
				number3++;
			} else if (behavior1 > 50) {
				number2++;
			} else if (behavior1 >= 0) {
				number1++;
			}
		}

		// 方差；
		float variance = 0;
		if (listBehavior.size() > 0) {
			variance = UserAccount.getVariance(behaviornumber);
		}

		List<Map<String, Object>> listNumber = new ArrayList<Map<String, Object>>();
		Map<String, Object> mapNumber = new HashMap<String, Object>();
		mapNumber.put("number1", number1);
		mapNumber.put("number2", number2);
		mapNumber.put("number3", number3);
		mapNumber.put("number4", number4);
		mapNumber.put("number5", number5);
		mapNumber.put("number6", number6);
		mapNumber.put("number7", number7);
		mapNumber.put("number8", number8);
		mapNumber.put("number9", number9);
		mapNumber.put("number10", number10);
		mapNumber.put("variance", variance);
		mapNumber.put("sumImei", listBehavior.size());
		listNumber.add(mapNumber);
		return listNumber;
	}

	// -------------------------------------------------------------驾驶行为；
	public String transDrive(String imei) {
		imei = imei.substring(13);
		String event = "iov_event_" + Integer.valueOf(imei) % 20;
		return event;
	}

	// -----------------------------------------------转换到路径表
	public String transTravelDrive(String imei) {

		System.out.println("imei is ---------" + imei);
		imei = imei.substring(13);

		String travel = "iov_travel_" + Integer.valueOf(imei) % 10;
		return travel;
	}

	// --------------------------------------------------------------排序算法
	public void listSort(List<Map<String, Object>> resultList) throws Exception {
		// resultList是需要排序的list，其内放的是Map
		// 返回的结果集
		Collections.sort(resultList, new Comparator<Map<String, Object>>() {

			public int compare(Map<String, Object> o1, Map<String, Object> o2) {

				// o1，o2是list中的Map，可以在其内取得值，按其排序，此例为升序，s1和s2是排序字段值
				Integer s1 = Integer.valueOf(String.valueOf(o1.get("behavior")));
				Integer s2 = Integer.valueOf(String.valueOf(o2.get("behavior")));

				if (s1 > s2) {
					return 1;
				} else {
					return -1;
				}
			}
		});

	}

	// ---------------------------------------------------------------------规律活动地域

	public List<List<Map<String, Object>>> ruleActivityArea(HttpServletRequest request) throws Exception {
		List<Map<String, Object>> list1 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> list2 = new ArrayList<Map<String, Object>>();
		List<Map<String, Object>> list3 = new ArrayList<Map<String, Object>>();
		List<List<Map<String, Object>>> list4 = new ArrayList<List<Map<String, Object>>>();

		String area[] = { "北京", "天津", "河北", "山西", "内蒙古", "辽宁", "吉林", "黑龙江", "上海", "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南", "广东", "广西", "海南", "重庆", "四川", "贵州", "云南", "西藏", "陕西", "甘肃",
				"青海", "宁夏", "新疆", "台湾", "香港", "澳门" };
		int provinceNumber[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

		int area1[] = { 11, 12, 13, 14, 15, 21, 22, 23, 31, 32, 33, 34, 35, 36, 37, 41, 42, 43, 44, 45, 46, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65, 71, 81, 82 };
		String group = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		System.out.println("listall is---" + group);
		// 获取所有数据
		List<Map<String, Object>> listAll = deviceDao.getArea(group);
		System.out.println("listall is---" + listAll);

		for (int i = 0; i < listAll.size(); i++) {
			// '1', '230900', '七台河市', '0', '1'
			String region = String.valueOf(listAll.get(i).get("c_region"));
			String number = String.valueOf(listAll.get(i).get("c_number"));
			region = region.substring(0, 2);
			for (int j = 0; j < area1.length; j++) {
				if (area1[j] == Integer.valueOf(region)) {
					provinceNumber[j] = provinceNumber[j] + Integer.valueOf(number);
					break;
				}
			}
		}
		for (int k = 0; k < area.length; k++) {
			if (provinceNumber[k] == 0) {
				continue;
			} else {
				// 获取市级
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("number", provinceNumber[k]);
				map.put("province", area[k]);
				list1.add(map);
			}
		}
		list4.add(list1);
		return list4;
	}

	// ----------------------------------------------------------------------驾驶类别；
	public List<Map<String, Object>> divercategory(HttpServletRequest request, String code) throws Exception {
		List<Map<String, Object>> listSum = new ArrayList<Map<String, Object>>();
		String group = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		
		
		int number1 = 0, number2 = 0, number3 = 0, number4 = 0;
		// 获取所有的数据；
		List<Map<String, Object>> listAll = deviceDao.getDriverBcategory(code,group);
		for (int i = 0; i < listAll.size(); i++) {
			int number33 = Integer.valueOf(String.valueOf(listAll.get(i).get("c_taxi_driver")));
			int number11 = Integer.valueOf(String.valueOf(listAll.get(i).get("c_truck_driver")));
			int number22 = Integer.valueOf(String.valueOf(listAll.get(i).get("c_office_worker")));
			int number44 = Integer.valueOf(String.valueOf(listAll.get(i).get("c_other")));
			number1 += number11;
			number2 += number22;
			number3 += number33;
			number4 += number44;
		}
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("diver", "货车司机");
		map1.put("number", number1);
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("diver", "上班族");
		map2.put("number", number2);
		Map<String, Object> map3 = new HashMap<String, Object>();
		map3.put("diver", "出租司机");
		map3.put("number", number3);
		Map<String, Object> map4 = new HashMap<String, Object>();
		map4.put("diver", "其他");
		map4.put("number", number4);
		listSum.add(map1);
		listSum.add(map2);
		listSum.add(map3);
		listSum.add(map4);
		return listSum;
	}

	// ---------------------------------------------------------------------驾驶规律时间段
	public List<Map<String, Object>> diverRuleTime(HttpServletRequest request, String code) throws Exception {
		List<Map<String, Object>> listSum = new ArrayList<Map<String, Object>>();
		int number1 = 0, number2 = 0, number3 = 0, number4 = 0, number5 = 0, number6 = 0, number7 = 0, number8 = 0, number9 = 0, number10 = 0, number11 = 0, number12 = 0, number13 = 0, number14 = 0, number15 = 0, number16 = 0, number17 = 0, number18 = 0, number19 = 0, number20 = 0, number21 = 0, number22 = 0, number23 = 0, number24 = 0;
		int numberList[] = { number1, number2, number3, number4, number5, number6, number7, number8, number9, number10, number11, number12, number13, number14, number15, number16, number17, number18,
				number19, number20, number21, number22, number23, number24 };
		String group = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		
		List<Map<String, Object>> listAll = deviceDao.getDriverRuleTime(code,group);
		System.out.println("---1111--" + listAll.size() + "-1111-" + code);

		
		for (int j = 1; j < 25; j++) {
			for (int i = 0; i < listAll.size(); i++) {
				int hours1 = Integer.valueOf(String.valueOf(listAll.get(i).get("c_time" + j)));
				if (hours1 > 0) {
					numberList[j - 1] = numberList[j - 1] + 1;
				}
			}

		}
		for (int k = 0; k < 24; k++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("number" + k, numberList[k]);
			listSum.add(map);
		}
		return listSum;
	
	}



	// --------------------------------------------------------------计算
	
	// 有多少轨迹段，以及时间
	public List<TravelEntity> queryTravel(Date startDate, Date endDate, String imei, String model) throws Exception {
		List<TravelEntity> resultList = GetTrack.queryTravel(startDate, endDate, imei, model);
		return resultList;
	}

	// ------------------------------------------------------------路径表和轨迹表
	public String transCoding(String imei) {
		imei = imei.substring(13);
		String track = "iov_track_" + Integer.valueOf(imei) % 100;
		return track;
	}



	// ------------------------------------------------------------------------单个设备主页-移动；

	public List<Map<String, Object>> homepageDevice(String imei) throws Exception {
		List<Map<String, Object>> listData = new ArrayList<Map<String, Object>>();
		List<Date> list = DateUtil.dateToDateMinute();
		Date currentTime = list.get(0);
		Date currentTime1 = list.get(1);
		// 获取在线信息；
		List<Map<String, Object>> listOnline = deviceDao.getlocal(imei, currentTime, currentTime1);
		String lng = null;
		String lat = null;
		boolean onlineState = false;
		// 驾驶行为
		List<Map<String, Object>> imeiList = deviceDao.singleGetImeiInformation(imei);
		Map<String, Object> map = new HashMap<String, Object>();
		if (listOnline.size() > 0) {
			lng = String.valueOf(listOnline.get(0).get("n_lng"));
			lat = String.valueOf(listOnline.get(0).get("n_lat"));
			onlineState = true;
			map.put("lng", lng);
			map.put("lat", lat);
		}
		map.put("onlineState", onlineState);
		imeiList.add(map);
		return imeiList;
	}



	// --------------------------------------------------------------------单个设备-驾驶行为分析；
	public List<Map<String, Object>> singleDeviceDriveBehavior(HttpServletRequest request, String imei, String startTime, String endTime) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		Date starttime2 = DateUtil.StringToDateStart(startTime, "yyyy.MM.dd");
		Date endtime2 = DateUtil.StringToDateStart(endTime, "yyyy.MM.dd");
		long day = (endtime2.getTime() - starttime2.getTime()) / (24 * 60 * 60 * 1000);
		day = day + 1;
		// 定义时间；
		Date time = endtime2;
		String travel = transTravelDrive(imei);

		for (int i = 0; i < day; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			Date queryDate;
			Calendar rightNow = Calendar.getInstance();
			rightNow.setTime(time);
			rightNow.add(Calendar.DAY_OF_YEAR, -i);
			queryDate = rightNow.getTime();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			String reStr = sdf1.format(queryDate);
			String reStr1 = reStr + " 00:00:00";
			String reStr2 = reStr + " 23:59:00";
			SimpleDateFormat sdf11 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date todayDate1 = sdf11.parse(reStr1);
			Date todayDate2 = sdf11.parse(reStr2);
			// 统计一天的单个设备的驾驶行为

			int turn = 0, speepDown = 0, speedUp = 0, collide = 0, fatigue = 0;
			float grade = 0;

			List<Map<String, Object>> listBehavior = deviceDao.singleGetImeiBehavior(travel, imei, todayDate1, todayDate2);

			for (int j = 0; j < listBehavior.size(); j++) {
				String driver = String.valueOf(listBehavior.get(j).get("c_driver"));
				JSONObject jsonObject = JSONObject.fromObject(driver);

				float userGrade = Float.valueOf(jsonObject.getString("grade"));
				int userTurn = Integer.valueOf(jsonObject.getString("turn"));
				int userSpeedDown = Integer.valueOf(jsonObject.getString("speed_down"));
				int userSpeedUp = Integer.valueOf(jsonObject.getString("speed_up"));
				int userCollide = Integer.valueOf(jsonObject.getString("collide"));
				int userFatigue = Integer.valueOf(jsonObject.getString("fatigue"));

				turn += userTurn;
				speepDown += userSpeedDown;
				speedUp += userSpeedUp;
				collide += userCollide;
				fatigue += userFatigue;

				grade += userGrade;
			}

			if (listBehavior.size() > 0) {
				grade = grade / listBehavior.size();
				BigDecimal b = new BigDecimal(grade);
				grade = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
			}
			map.put("turn", turn);
			map.put("speepDown", speepDown);
			map.put("speedUp", speedUp);
			map.put("collide", collide);
			map.put("fatigue", fatigue);
			map.put("grade", grade);
			map.put("flag", i);
			list.add(map);
		}

		return list;
	}

	// --------------------------------------------------------------------单个设备-单一驾驶行为分析；

	public List<Map<String, Object>> singleDeviceSingleDriveBehavior(HttpServletRequest request, String imei, String behavior, String startTime, String endTime) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();

		Date starttime2 = DateUtil.StringToDateStart(startTime, "yyyy.MM.dd");
		Date endtime2 = DateUtil.StringToDateStart(endTime, "yyyy.MM.dd");
		long day = (endtime2.getTime() - starttime2.getTime()) / (24 * 60 * 60 * 1000);
		day = day + 1;
		// 定义时间；
		Date time = endtime2;
		String travel = transTravelDrive(imei);

		for (int i = 0; i < day; i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			Date queryDate;
			Calendar rightNow = Calendar.getInstance();
			rightNow.setTime(time);
			rightNow.add(Calendar.DAY_OF_YEAR, -i);
			queryDate = rightNow.getTime();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			String reStr = sdf1.format(queryDate);
			String reStr1 = reStr + " 00:00:00";
			String reStr2 = reStr + " 23:59:00";
			SimpleDateFormat sdf11 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date todayDate1 = sdf11.parse(reStr1);
			Date todayDate2 = sdf11.parse(reStr2);
			// 统计一天的单个设备的驾驶行为
			int userBehavior = 0;
			List<Map<String, Object>> listBehavior = deviceDao.singleGetImeiBehavior(travel, imei, todayDate1, todayDate2);
			for (int j = 0; j < listBehavior.size(); j++) {
				String driver = String.valueOf(listBehavior.get(j).get("c_driver"));
				JSONObject jsonObject = JSONObject.fromObject(driver);
				float userBehavior1 = Float.valueOf(jsonObject.getString(behavior));
				userBehavior += userBehavior1;

			}
			map.put("behavior", userBehavior);
			map.put("flag", i);
			list.add(map);
		}

		return list;
	}

	// --------------------------------------------------------------------单个设备-
	// 碰撞视频
	public List<Map<String, Object>> singleDeviceCollide(String imei, String startTime, String endTime) throws Exception {
		Date startTime1 = DateUtil.StringToDateStart(startTime, "yyyy.MM.dd HH:mm:ss");
		Date endTime1 = DateUtil.StringToDateEnd(endTime, "yyyy.MM.dd HH:mm:ss");
		String flag = transVideo(imei);
		List<Map<String, Object>> list = deviceDao.videoUserNumber(flag, "R611", imei, startTime1, endTime1);
		return list;

	}
	// -------------------------------------------------------------视频表
	public String transVideo(String imei) {
		imei = imei.substring(13);
		String media = "iov_media_" + Integer.valueOf(imei) % 10;
		return media;
	}

	// --------------------------------------------------------------------单个设备-
	// 驾驶规律时间段
	public List<Map<String, Object>> singleDiverRuleTime(String imei, String timeFlag) throws Exception {
		List<Date> listDate = DateUtil.stringToDateTimeFlag(timeFlag);
		Date startTime1 = listDate.get(0);
		Date endTime1 = listDate.get(1);
		List<Map<String, Object>> listSum = new ArrayList<Map<String, Object>>();
		String travel = transTravelDrive(imei);
		for (int j = 0; j < 24; j++) {
			List<Map<String, Object>> listNumber = deviceDao.singleDiverRuleTime(travel, imei, j, j + 1, startTime1, endTime1);// 货车司机
			int number = listNumber.size();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hour", j + 1);
			map.put("number", number);
			listSum.add(map);
		}
		return listSum;
	}

	// ----------------------------------------------------------------单个设备-地域规律
	public List<Map<String, Object>> singleDiverRuleArea(HttpServletRequest request, String imei, String timeFlag) throws Exception {
		String area[] = { "北京", "天津", "河北", "山西", "内蒙古", "辽宁", "吉林", "黑龙江", "上海", "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南", "广东", "广西", "海南", "重庆", "四川", "贵州", "云南", "西藏", "陕西", "甘肃",
				"青海", "宁夏", "新疆", "台湾", "香港", "澳门" };

		int area1[] = { 11, 12, 13, 14, 15, 21, 22, 23, 31, 32, 33, 34, 35, 36, 37, 41, 42, 43, 44, 45, 46, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65, 71, 81, 82 };

		List<Date> listDate = DateUtil.stringToDateTimeFlag(timeFlag);

		Date startTime1 = listDate.get(0);
		Date endTime1 = listDate.get(1);

		String travel = transTravelDrive(imei);

		List<Map<String, Object>> listResult = new ArrayList<Map<String, Object>>();
		long time111112 = System.currentTimeMillis();

		for (int i = 0; i < area.length; i++) {
			long time11111 = System.currentTimeMillis();
			List<Map<String, Object>> list = deviceDao.singleDiverRuleArea(travel, imei, area1[i] + "%", startTime1, endTime1);
			long time22222 = System.currentTimeMillis();
			System.out.println("---查询时间---" + (time22222 - time11111));

			float sumHour = 0;
			if (list.size() > 0) {
				for (int j = 0; j < list.size(); j++) {
					String time1 = String.valueOf(list.get(j).get("t_st_time"));
					String time2 = String.valueOf(list.get(j).get("t_ed_time"));
					Date time11 = DateUtil.StringToDateStart(time1, "yyyy-MM-dd HH:mm:ss");
					Date time22 = DateUtil.StringToDateStart(time2, "yyyy-MM-dd HH:mm:ss");
					float time = time22.getTime() - time11.getTime();
					float hour1 = time / (1000 * 60 * 60);
					sumHour = sumHour + hour1;
				}
			}
			BigDecimal b = new BigDecimal(sumHour);
			sumHour = b.setScale(2, BigDecimal.ROUND_HALF_UP).floatValue();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("hour", sumHour);
			map.put("city", area[i]);
			listResult.add(map);

			long time3333 = System.currentTimeMillis();
			System.out.println("---查询时间1---" + (time3333 - time22222));

		}
		long time4444 = System.currentTimeMillis();

		System.out.println("---查询时间2---" + (time4444 - time111112));

		return listResult;
	}

	// ----------------------------------------------------------------单个设备其他的轨迹；
	public List<Object> singleDiverTrave(HttpServletRequest request, String imei, String time1, String time2) throws Exception {

		List<Object> resultList1 = new ArrayList<Object>();

		Date stratTime1 = DateUtil.StringToDateStart(time1, "yyyy.MM.dd HH:mm:ss");
		Date endTime1 = DateUtil.StringToDateEnd(time1, "yyyy.MM.dd HH:mm:ss");

		// 获取轨迹段；
		String travel = transTravelDrive(imei);
		List<Map<String, Object>> resultList = deviceDao.singleDiverTravel(travel, imei, stratTime1, endTime1);

		for (int i = 0; i < resultList.size(); i++) {
			String strartTime2 = String.valueOf(resultList.get(i).get("t_st_time"));
			String endTime2 = String.valueOf(resultList.get(i).get("t_ed_time"));
			Date strartTime3 = DateUtil.StringToDateStart(strartTime2, "yyyy-MM-dd HH:mm:ss");
			Date endTime3 = DateUtil.StringToDateEnd(endTime2, "yyyy-MM-dd HH:mm:ss");

			String driver = String.valueOf(resultList.get(i).get("c_driver"));
			String distance = String.valueOf(resultList.get(i).get("n_distance"));
			String speed = String.valueOf(resultList.get(i).get("n_speed"));

			JSONObject jsonObject = JSONObject.fromObject(driver);
			jsonObject.accumulate("distance", distance);
			jsonObject.accumulate("speed", speed);

			logger.error("request is " + request + "------strartTime3" + strartTime3 + "--endTime3" + endTime3);
			// 获取轨迹点
			List<LacEntity> resultList2 = GetTrack.show(request, strartTime3, endTime3, imei, "R611");
			List<Object> list = new ArrayList<Object>();
			list.add(resultList2);
			list.add(jsonObject);
			resultList1.add(list);
		}
		return resultList1;
	}



}
