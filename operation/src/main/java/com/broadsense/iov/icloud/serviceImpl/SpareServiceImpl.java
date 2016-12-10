package com.broadsense.iov.icloud.serviceImpl;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.broadsense.iov.icloud.dao.BasicDao;
import com.broadsense.iov.icloud.service.SpareService;

@Service("spareService")
public class SpareServiceImpl extends BasicService implements SpareService {
	// ----------------------------------------------------------------------------备用机交换统计
	// 显示备用机换机信息
	public Map<String, Object> spareChangList(String region, String offset, String order, String sort) throws Exception {

		// 获取总数；
		List<Map<String, Object>> listNum = spareDao.querySpareChangeSum(region);
		int number = Integer.valueOf(String.valueOf(listNum.get(0).get("number")));
		List<Map<String, Object>> list = spareDao.spareChangList(region, Integer.valueOf(offset), order, sort);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", number);
		map.put("rows", list);
		return map;
	}

	// 备用机换机统计-查询备用imei信息
	public Map<String, Object> searchSpareChang(String spareImei, String code) throws Exception {
		List<Map<String, Object>> list = spareDao.searchSpareChang(spareImei, code);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", 1);
		map.put("rows", list);
		return map;
	}

	// 备用机换机统计-模糊查询备用imei信息
	public List<Map<String, Object>> fuzzySearchSpareChang(String spareImei, String region) throws Exception {
		List<Map<String, Object>> list = spareDao.fuzzySearchSpareChang(spareImei, region);
		return list;
	}

	// 备用机换机统计-编辑备用机信息；
	public Object spareChangEdit(Map<String, String> json, HttpServletRequest request) throws Exception {
		Date time = new Date();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("n_id", json.get("spareChangId"));
		map.put("c_respace_imei", json.get("respaceImei"));
		map.put("c_remark", json.get("remark"));
		map.put("t_time", time);
		map.put("c_spare_state", "1");
		Object object = spareDao.basicUpdate("iov_spare_change", map, "n_id=" + json.get("spareChangId"));
		if (!object.equals("0")) {
			// 获取备用机id；
			String spareId = String.valueOf(spareDao.basicQueryByFields("iov_spare_change", map).get(0).get("n_id"));
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "修改替换机器IMEI号" + json.get("respaceImei"), date, "01", spareId);
		}
		return object;
	}

	// 备用机换机统计-备用机更换信息；
	public Object spareImieChang(Map<String, String> json, HttpServletRequest request) throws Exception {
		Date time = new Date();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_respace_imei", json.get("respaceImei"));
		map.put("c_remark", json.get("remark"));
		map.put("t_time", time);
		map.put("c_region", json.get("region"));
		map.put("c_area", json.get("area"));
		map.put("c_spare_state", "1");
		Object object = spareDao.basicUpdate("iov_spare_change", map, "c_spare_imei=" + json.get("spareImei"));
		if (!object.equals("0")) {
			// 获取备用机id；
			String spareId = String.valueOf(spareDao.basicQueryByFields("iov_spare_change", map).get(0).get("n_id"));
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "修改替换机器IMEI号" + json.get("respaceImei"), date, "01", spareId);
		}
		return object;
	}

	// --------------------------------------------------------------------------------发货统计
	// 显示发货信息
	public Map<String, Object> spareSendList(String region, String offset, String order, String sort) throws Exception {
		// 获取总数；
		List<Map<String, Object>> listNum = spareDao.querySpareSendSum(region);
		int number = Integer.valueOf(String.valueOf(listNum.get(0).get("number")));
		List<Map<String, Object>> list = spareDao.spareSendList(region, Integer.valueOf(offset), order, sort);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", number);
		map.put("rows", list);
		return map;
	}
	
	//确认是否收货；
	
	public Object goodsConfirm(Map<String, String> json, HttpServletRequest request) throws Exception {
		
		String sendId=json.get("sendId");
		System.out.println("------sendId------"+sendId);
		//更新数据；
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_receiver_state", "1");
		Object object	=spareDao.basicUpdate("iov_spare_send", map, "n_id="+sendId);
		
		if(!object.equals("0"))
		{
			// 获取发货申请id；
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "已经确认收货", date, "00", sendId);
			 spareDao.updateChangeReState("1", sendId);
		}
		
		return object;
	}
	

	// 发货申请；
	public Object sendApplication(Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_area", json.get("area"));
		map.put("c_region", json.get("region"));
		map.put("c_address", json.get("address"));
		map.put("c_receiver", json.get("receiver"));
		map.put("c_number", json.get("number"));
		map.put("c_model", json.get("model"));
		map.put("c_send_type", json.get("sendType"));
		map.put("c_apply_state", "0");
		Object object = null;
		if (json.get("sendId") == null || ("").equals(json.get("sendId"))) {
			object = spareDao.basicInsertData("iov_spare_send", map);
		} else {

			object = spareDao.basicUpdate("iov_spare_send", map, "n_id=" + json.get("sendId"));
		}
		// 插入日志；
		if (!object.equals("0")) {
			// 获取发货申请id；
			String spareId = String.valueOf(spareDao.basicQueryByFields("iov_spare_send", map).get(0).get("n_id"));
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			if (json.get("sendId") == null || ("").equals(json.get("sendId"))) {
				BasicDao.spareLogInsertData(name, "添加发货申请", date, "00", spareId);
			} else {
				BasicDao.spareLogInsertData(name, "修改发货申请", date, "00", spareId);
			}
		}
		return object;
	}

	// 发货申请确定；
	public Object sendApplicationConfirm(Map<String, String> json, HttpServletRequest request, List<String> listImei) throws Exception {
		String name = String.valueOf(request.getSession().getAttribute("username"));
		List<Map<String, Object>> addList=new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> addLogList=new ArrayList<Map<String,Object>>();
		System.out.println("--111--" + json);
		Date date = new Date();
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		// 发货申请确认；
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_region", json.get("region"));
		map.put("c_address", json.get("address"));
		map.put("c_number", json.get("number"));
		map.put("c_model", json.get("model"));
		map.put("c_send_type", json.get("sendType"));
		map.put("c_apply_state", "1");
		map.put("c_express_id", json.get("expressId"));
		map.put("c_receiver_state", json.get("receiveState"));
		Date time = new Date();
		map.put("t_send_time", time);
		Object object = null;
		map.put("n_id", json.get("n_id"));
		// 查询是否已经处理过；
		List<Map<String, Object>> list = spareDao.basicQueryById("iov_spare_send", Integer.valueOf(json.get("n_id")));
		Object applyState = list.get(0).get("c_apply_state");
		System.out.println("--c_apply_state--- "+applyState);
		
		if (applyState.equals(0)) {
			// 备用机交换信息插入；
			if (json.get("sendType").equals("1")) {
				List<Object> spareObject=null;
				for (int i = 0; i < listImei.size(); i++) {
					Map<String, Object> spareMap = new HashMap<String, Object>();
					// 地区，备用机IMEI号，model，发货id
					spareMap.put("c_area", json.get("area"));
					spareMap.put("c_model", json.get("model"));
					spareMap.put("c_spare_imei", listImei.get(i));
					spareMap.put("c_send_id", map.get("n_id"));
					spareMap.put("c_region", json.get("region"));
					spareMap.put("c_receive_state", json.get("receiveState"));
					addList.add(spareMap);
				}
				   spareObject=spareDao.insertSpareBatch(addList);
				  if(spareObject.size()>0)
				  {
					   // 插入交换表
						object = spareDao.basicUpdate("iov_spare_send", map, "n_id=" + json.get("n_id"));
						// 发货申请确认log
						BasicDao.spareLogInsertData(name, "发货申请确认", date, "00", json.get("n_id"));
						for(int j=0;j<spareObject.size();j++)
						{
							//BasicDao.spareLogInsertData(name, "导入备用机信息", date, "01", String.valueOf(spareObject.get(j)));	
							Map<String, Object> fields = new HashMap<String, Object>();
							fields.put("c_name", name);
							fields.put("c_content", "导入备用机信息");
							fields.put("c_flag", "01");
							fields.put("c_spare_id", String.valueOf(spareObject.get(j)));
							fields.put("t_create_time", sdf1.format(date));
							addLogList.add(fields);
						}
						spareDao.spareLogInsertDataBatch(addLogList);
				  }
			}else
			{
				   // 插入交换表
				object = spareDao.basicUpdate("iov_spare_send", map, "n_id=" + json.get("n_id"));
				// 发货申请确认log
				BasicDao.spareLogInsertData(name, "发货申请确认", date, "00", json.get("n_id"));
			}
			
		}
		
		return object;
	}

	// 添加发货申请确定；
	public Object addSendApplicationConfirm(Map<String, String> json, HttpServletRequest request, List<String> listImei) throws Exception {
		String name = String.valueOf(request.getSession().getAttribute("username"));
		List<Map<String, Object>> addList=new ArrayList<Map<String,Object>>();
		System.out.println("--111--" + json);
		Date date = new Date();
		// 发货申请确认；
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_receiver", json.get("c_receiver"));
		map.put("c_region", json.get("region"));
		map.put("c_address", json.get("address"));
		map.put("c_number", json.get("number"));
		map.put("c_model", json.get("model"));
		map.put("c_send_type", json.get("sendType"));
		map.put("c_apply_state", "1");
		map.put("c_express_id", json.get("expressId"));
		map.put("c_receiver_state", json.get("receiveState"));
		map.put("c_area", json.get("area"));
		
		Date time = new Date();
		map.put("t_send_time", time);
		Object object = null;
		object = spareDao.basicInsertData("iov_spare_send", map);
		String sendId = String.valueOf(spareDao.basicQueryByFields("iov_spare_send", map).get(0).get("n_id"));
		map.put("n_id", sendId);
		
		if (object.equals("0")) {
			return object;
		} else {
			// 发货申请确认log
			BasicDao.spareLogInsertData(name, "发货申请确认", date, "00", sendId);
			
			
			// 备用机交换信息插入；
			if (json.get("sendType").equals("1")) {
				List<Object> spareObject=null;
				for (int i = 0; i < listImei.size(); i++) {
					Map<String, Object> spareMap = new HashMap<String, Object>();
					// 地区，备用机IMEI号，model，发货id
					spareMap.put("c_area", json.get("area"));
					spareMap.put("c_model", json.get("model"));
					spareMap.put("c_spare_imei", listImei.get(i));
					spareMap.put("c_send_id", map.get("n_id"));
					spareMap.put("c_region", json.get("region"));
					spareMap.put("c_receive_state", json.get("receiveState"));
					addList.add(spareMap);
				}
				spareObject=spareDao.insertSpareBatch(addList);
				  if(spareObject.size()>0)
				  {
					
					// 插入交换表
						for(int j=0;j<spareObject.size();j++)
						{
							BasicDao.spareLogInsertData(name, "导入备用机信息", date, "01", String.valueOf(spareObject.get(j)));
						}
						
				  }else
				  {
					  spareDao.basicDeleteData("iov_spare_send", Integer.valueOf(sendId));
				  }
			}
		}
		return object;
	}
	
	

	// 发货申请单修改；
	public Object sendApplicationEdit(Map<String, String> json, HttpServletRequest request, List<String> listImei) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("n_id", json.get("sendId"));
		map.put("c_express_message", json.get("expressMessage"));
		Object object = spareDao.basicUpdate("iov_spare_send", map, "n_id=" + json.get("sendId"));
		
		if(!object.equals("0")){
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "发货申请单修改", date, "00", json.get("sendId"));	
		}
		return object;
	}

	// -----------------------------------------------------------------------导出数据；
	public void spareExport(List<Map<String, Object>> listImei, HttpServletResponse response) throws Exception {
		// 时间，地区，备用机IMEI号，替换机器IMEI号，备用机产品型号，备注信息
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("时间");
		cell.setCellStyle(style);
		cell = row.createCell(1);
		cell.setCellValue("地区");
		cell.setCellStyle(style);
		cell = row.createCell(2);
		cell.setCellValue("备用机IMEI号");
		cell.setCellStyle(style);
		cell = row.createCell(3);
		cell.setCellValue("替换机器IMEI号");
		cell.setCellStyle(style);
		cell = row.createCell(4);
		cell.setCellValue("备用机产品型号");
		cell.setCellStyle(style);
		cell = row.createCell(5);
		cell.setCellValue("备注信息");
		cell.setCellStyle(style);
		List<Map<String, Object>> list = listImei;
		for (int i = 0; i < list.size(); i++) {
			row = sheet.createRow((int) i + 1);
			String a = String.valueOf(list.get(i).get("t_time"));
			String b = String.valueOf(list.get(i).get("c_area"));
			String c = String.valueOf(list.get(i).get("c_spare_imei"));
			String d = String.valueOf(list.get(i).get("c_respace_imei"));
			String e = String.valueOf(list.get(i).get("c_model"));
			String f = String.valueOf(list.get(i).get("c_remark"));
			if (list.get(i).get("t_time") == null) {
				a = "";
			}
			if (list.get(i).get("c_area") == null) {
				b = "";
			}
			if (list.get(i).get("c_spare_imei") == null) {
				c = "";
			}
			if (list.get(i).get("c_respace_imei") == null) {
				d = "";
			}
			if (list.get(i).get("c_model") == null) {
				e = "";
			}
			if (list.get(i).get("c_remark") == null) {
				f = "";
			}
			row.createCell(0).setCellValue(a);
			row.createCell(1).setCellValue(b);
			row.createCell(2).setCellValue(c);
			row.createCell(3).setCellValue(d);
			row.createCell(4).setCellValue(e);
			row.createCell(5).setCellValue(f);
		}
		try {
			// 转换格式，拼接文件文件后缀名
			Date date = new Date();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String dateDay = sdf1.format(date);
			String fileName = "备用机信息" + dateDay;
			OutputStream outputStream = response.getOutputStream();// 打开流
			response.setContentType("application/application/vnd.ms-excel");
			response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName + ".xlsx", "utf-8")); // 创建一个Workbook，对应一个Excel文件
			wb.write(outputStream);// HSSFWorkbook写入流
			outputStream.flush();// 刷新流
			outputStream.close();// 关闭流
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void sendSpareExport(List<Map<String, Object>> listImei, HttpServletResponse response) throws Exception {
		// 时间，地区，备用机IMEI号，替换机器IMEI号，备用机产品型号，备注信息
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("时间");
		cell.setCellStyle(style);
		cell = row.createCell(1);
		cell.setCellValue("收货地址");
		cell.setCellStyle(style);
		cell = row.createCell(2);
		cell.setCellValue("发货数量");
		cell.setCellStyle(style);
		cell = row.createCell(3);
		cell.setCellValue("收货人");
		cell.setCellStyle(style);
		cell = row.createCell(4);
		cell.setCellValue("快递信息");
		cell.setCellStyle(style);
		cell = row.createCell(5);
		cell.setCellValue("发货产品型号");
		cell.setCellStyle(style);
		cell = row.createCell(6);
		cell.setCellValue("机器类型");
		cell.setCellStyle(style);
		List<Map<String, Object>> list = listImei;
		for (int i = 0; i < list.size(); i++) {
			row = sheet.createRow((int) i + 1);
			String a = String.valueOf(list.get(i).get("t_semd_time"));
			String b = String.valueOf(list.get(i).get("c_address"));
			String c = String.valueOf(list.get(i).get("c_number"));
			String d = String.valueOf(list.get(i).get("c_receiver"));
			String e = String.valueOf(list.get(i).get("c_express_message"));
			String f = String.valueOf(list.get(i).get("c_model"));
			String g = String.valueOf(list.get(i).get("c_send_type"));
			row.createCell(0).setCellValue(a);
			row.createCell(1).setCellValue(b);
			row.createCell(2).setCellValue(c);
			row.createCell(3).setCellValue(d);
			row.createCell(4).setCellValue(e);
			row.createCell(5).setCellValue(f);
			row.createCell(6).setCellValue(g);
		}
		try {
			// 转换格式，拼接文件文件后缀名
			Date date = new Date();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String dateDay = sdf1.format(date);
			String fileName = "发货申请信息" + dateDay;
			OutputStream outputStream = response.getOutputStream();// 打开流
			response.setContentType("application/application/vnd.ms-excel");
			response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName + ".xls", "utf-8")); // 创建一个Workbook，对应一个Excel文件
			wb.write(outputStream);// HSSFWorkbook写入流
			outputStream.flush();// 刷新流
			outputStream.close();// 关闭流
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	// --------------------------------------------------显示日志；
	public List<Map<String, Object>> spareShowLog(String flag, String recordId) throws Exception {
		System.out.println("----------"+flag+"-----------"+recordId);
		
		List<Map<String, Object>> list = spareDao.spareShowLog(flag, recordId);
		return list;
	}

	// --------------------------------------------------显示全国各地区的发货数量，已安装，已激活，微信绑定，
	public List<Map<String, Object>> spareShow(HttpServletRequest request, String code) throws Exception {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		// 发货数量
		List<Map<String, Object>> sendList = spareDao.spareShowSendList(code);
		
		//备用机数量；
		List<Map<String, Object>> sendSpareList = spareDao.spareShowSendList1(code);
		
		// 已激活；
		List<Map<String, Object>> activeList = spareDao.spareShowActiveList(code);
		// 已安装；
		List<Map<String, Object>> installList = spareDao.spareShowInstallList(code);
		// 已绑定；
		List<Map<String, Object>> bindingList = spareDao.spareShowBindeList(code);
		String sendNumber = String.valueOf(sendList.get(0).get("number"));
		String activeNumber = String.valueOf(activeList.get(0).get("number"));
		String installNumber = String.valueOf(installList.get(0).get("number"));
		String bindingNumber = String.valueOf(bindingList.get(0).get("number"));
		String sendSpareNumber = String.valueOf(sendSpareList.get(0).get("number"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sendNumber", sendNumber);
		map.put("activeNumber", activeNumber);
		map.put("installNumber", installNumber);
		map.put("bindingNumber", bindingNumber);
		map.put("sendSpareNumber", sendSpareNumber);
		
		list.add(map);
		return list;
	}

	// 显示各省的信息；
	// --------------------------------------------------显示全国各地区的发货数量，已安装，已激活，微信绑定，
	public List<Map<String, Object>> spareShowMap(HttpServletRequest request, String code) throws Exception {
		List<Map<String, Object>> listAll = new ArrayList<Map<String, Object>>();
		// 全部地区编码；
		int area[] = { 11, 12, 13, 14, 15, 21, 22, 23, 31, 32, 33, 34, 35, 36, 37, 41, 42, 43, 44, 45, 46, 50, 51, 52, 53, 54, 61, 62, 63, 64, 65, 71, 81, 82 };
		String area1[] = { "北京", "天津", "河北", "山西", "内蒙古", "辽宁", "吉林", "黑龙江", "上海", "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南", "湖北", "湖南", "广东", "广西", "海南", "重庆", "四川", "贵州", "云南", "西藏", "陕西", "甘肃",
				"青海", "宁夏", "新疆", "台湾", "香港", "澳门" };
		
		
//		for (int i = 0; i < area.length; i++) {
//			List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
//			// 发货数量
//			List<Map<String, Object>> sendList = spareDao.spareShowSendList(String.valueOf(area[i]));
//			// 已激活；
//			List<Map<String, Object>> activeList = spareDao.spareShowActiveList(String.valueOf(area[i]));
//			// 已安装；
//			List<Map<String, Object>> installList = spareDao.spareShowInstallList(String.valueOf(area[i]));
//			// 已绑定；
//			List<Map<String, Object>> bindingList = spareDao.spareShowBindeList(String.valueOf(area[i]));
//			//备用机数量；
//			List<Map<String, Object>> sendSpareList = spareDao.spareShowSendList1(String.valueOf(area[i]));
//			String sendNumber = String.valueOf(sendList.get(0).get("number"));
//			String activeNumber = String.valueOf(activeList.get(0).get("number"));
//			String installNumber = String.valueOf(installList.get(0).get("number"));
//			String bindingNumber = String.valueOf(bindingList.get(0).get("number"));
//			String sendSpareNumber = String.valueOf(sendSpareList.get(0).get("number"));
//			Map<String, Object> map = new HashMap<String, Object>();
//			map.put("sendNumber", sendNumber);
//			map.put("activeNumber", activeNumber);
//			map.put("installNumber", installNumber);
//			map.put("bindingNumber", bindingNumber);
//			map.put("sendSpareNumber", sendSpareNumber);
//			list.add(map);
//			Map<String, Object> map1 = new HashMap<String, Object>();
//			map1.put("data", list);
//			map1.put("province", area1[i]);
//			listAll.add(map1);
//		}
		//c_number,c_region
		// 发货数量
		List<Map<String, Object>> sendList = spareDao.spareShowSendListTest("allcode");
		// 已激活；
		List<Map<String, Object>> activeList = spareDao.spareShowActiveListTest("allcode");
		// 已安装；
		List<Map<String, Object>> installList = spareDao.spareShowInstallListTest("allcode");
		// 已绑定；
		List<Map<String, Object>> bindingList = spareDao.spareShowBindeListTest("allcode");
		//备用机数量；
		List<Map<String, Object>> sendSpareList = spareDao.spareShowSendList1Test("allcode");
		
		for (int i = 0; i < area.length; i++) {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
	    int sendNumber=0,activeNumber=0,installNumber=0,bindingNumber=0,sendSpareNumber=0;
		for(Map<String, Object> map:sendList)
		{
			String region=String.valueOf(map.get("c_region"));
			region=region.substring(0, 2);
			int sendNumber1=Integer.valueOf(String.valueOf(map.get("c_number")));
			
			if(String.valueOf(area[i]).equals(region))
			{
				sendNumber=sendNumber+sendNumber1;
			}
		}
		
		for(Map<String, Object> map:activeList)
		{
			String region=String.valueOf(map.get("c_region"));
			region=region.substring(0, 2);
			if(String.valueOf(area[i]).equals(region))
			{
				activeNumber=activeNumber+1;
			}
		}
		for(Map<String, Object> map:installList)
		{
			String region=String.valueOf(map.get("c_region"));
			region=region.substring(0, 2);
			if(String.valueOf(area[i]).equals(region))
			{
				installNumber=installNumber+1;
			}
		}
		for(Map<String, Object> map:bindingList)
		{
			String region=String.valueOf(map.get("c_region"));
			region=region.substring(0, 2);
			if(String.valueOf(area[i]).equals(region))
			{
				bindingNumber=bindingNumber+1;
			}
		}
		for(Map<String, Object> map:sendSpareList)
		{
			String region=String.valueOf(map.get("c_region"));
			region=region.substring(0, 2);
			int sendSpareNumber1=Integer.valueOf(String.valueOf(map.get("c_number")));
			if(String.valueOf(area[i]).equals(region))
			{
				sendSpareNumber=sendSpareNumber+sendSpareNumber1;
			}
		}
		
		
		
		Map<String, Object> map1 = new HashMap<String, Object>();
		map1.put("sendNumber", sendNumber);
		map1.put("activeNumber", activeNumber);
		map1.put("installNumber", installNumber);
		map1.put("bindingNumber", bindingNumber);
		map1.put("sendSpareNumber", sendSpareNumber);
		list.add(map1);
		Map<String, Object> map2 = new HashMap<String, Object>();
		map2.put("data", list);
		map2.put("province", area1[i]);
		listAll.add(map2);
	}

		return listAll;
	}

	// 显示各市的信息；
	public List<Map<String, Object>> spareShowProvinceMap(HttpServletRequest request, String code) throws Exception {
		code = code.substring(0, 2);
		// 通过编码获取各市地区信息；
		List<Map<String, Object>> list = codeRegion(code);
		List<Map<String, Object>> listAll = new ArrayList<Map<String, Object>>();
		
		List<Map<String, Object>> sendList = spareDao.spareShowSendListTest(code);
		// 已激活；
		List<Map<String, Object>> activeList = spareDao.spareShowActiveListTest(code);
		// 已安装；
		List<Map<String, Object>> installList = spareDao.spareShowInstallListTest(code);
		// 已绑定；
		List<Map<String, Object>> bindingList = spareDao.spareShowBindeListTest(code);
		//备用机数量；
		List<Map<String, Object>> sendSpareList = spareDao.spareShowSendList1Test(code);
		
		for (int i = 0; i < list.size(); i++) {
			if (!list.get(i).get("c_code").equals("00")) {
//				List<Map<String, Object>> list1 = new ArrayList<Map<String, Object>>();
//				String region = code + String.valueOf(list.get(i).get("c_code"));
//				region = region.substring(0, 4);
//
//				System.out.println("-----region---" + region);
//				// 发货数量
//				List<Map<String, Object>> sendList = spareDao.spareShowSendList(region);
//				// 已激活；
//				List<Map<String, Object>> activeList = spareDao.spareShowActiveList(region);
//				// 已安装；
//				List<Map<String, Object>> installList = spareDao.spareShowInstallList(region);
//				// 已绑定；
//				List<Map<String, Object>> bindingList = spareDao.spareShowBindeList(region);
//				
//				//备用机数量；
//				List<Map<String, Object>> sendSpareList = spareDao.spareShowSendList1(region);
//				String sendSpareNumber = String.valueOf(sendSpareList.get(0).get("number"));
//
//				String sendNumber = String.valueOf(sendList.get(0).get("number"));
//				String activeNumber = String.valueOf(activeList.get(0).get("number"));
//				String installNumber = String.valueOf(installList.get(0).get("number"));
//				String bindingNumber = String.valueOf(bindingList.get(0).get("number"));
//
//				Map<String, Object> map = new HashMap<String, Object>();
//				map.put("sendNumber", sendNumber);
//				map.put("activeNumber", activeNumber);
//				map.put("installNumber", installNumber);
//				map.put("bindingNumber", bindingNumber);
//				map.put("sendSpareNumber", sendSpareNumber);
//				
//				list1.add(map);
//				Map<String, Object> map1 = new HashMap<String, Object>();
//				map1.put("data", list1);
//				map1.put("city", list.get(i).get("c_city"));
//				listAll.add(map1);
				
				List<Map<String, Object>> list1 = new ArrayList<Map<String, Object>>();
				String region = code + String.valueOf(list.get(i).get("c_code"));
				region = region.substring(0, 4);
				System.out.println("-----region---" + region);
				int sendSpareNumber=0,sendNumber=0,activeNumber=0,installNumber=0,bindingNumber=0;
				for(Map<String, Object> map:sendList)
				{
					String region1=String.valueOf(map.get("c_region"));
					region1=region1.substring(0, 4);
					int sendNumber1=Integer.valueOf(String.valueOf(map.get("c_number")));
					if(region.equals(region1))
					{
						sendNumber=sendNumber+sendNumber1;
					}
				}
				for(Map<String, Object> map:activeList)
				{
					String region1=String.valueOf(map.get("c_region"));
					region1=region1.substring(0, 4);
					if(region.equals(region1))
					{
						activeNumber=activeNumber+1;
					}
				}
				for(Map<String, Object> map:installList)
				{
					String region1=String.valueOf(map.get("c_region"));
					region1=region1.substring(0, 4);
					if(region.equals(region1))
					{
						installNumber=installNumber+1;
					}
				}
				for(Map<String, Object> map:bindingList)
				{
					String region1=String.valueOf(map.get("c_region"));
					region1=region1.substring(0, 4);
					if(region.equals(region1))
					{
						bindingNumber=bindingNumber+1;
					}
				}
				for(Map<String, Object> map:sendSpareList)
				{
					String region1=String.valueOf(map.get("c_region"));
					region1=region1.substring(0, 4);
					int sendSpareNumber1=Integer.valueOf(String.valueOf(map.get("c_number")));
					if(region.equals(region1))
					{
						sendSpareNumber=sendSpareNumber+sendSpareNumber1;
					}
				}
				

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("sendNumber", sendNumber);
				map.put("activeNumber", activeNumber);
				map.put("installNumber", installNumber);
				map.put("bindingNumber", bindingNumber);
				map.put("sendSpareNumber", sendSpareNumber);
				
				list1.add(map);
				Map<String, Object> map1 = new HashMap<String, Object>();
				map1.put("data", list1);
				map1.put("city", list.get(i).get("c_city"));
				listAll.add(map1);
			}
		}
		return listAll;
	}

	/*
	 * 公共接口；
	 */
	// 地图编码；
	public List<Map<String, Object>> codeRegion(String flag) throws Exception {
		List<Map<String, Object>> list = spareDao.code_regionList(flag);
		// 截取城市编号；
		for (int i = 0; i < list.size(); i++) {
			String cityCode = String.valueOf(list.get(i).get("c_code"));
			String cityCode1 = cityCode.substring(2, 4);
			String cityCode2 = cityCode.substring(0, 2);
			// if(cityCode1.equals("00")&&cityCode2."11"&&cityCode2!="12"&&cityCode2!="31")
			/*
			 * if(cityCode1.equals("00")&&!cityCode2.equals("11")&&!cityCode2.equals
			 * ("12")&&!cityCode2.equals("31")) { list.remove(i); }else{
			 */
			list.get(i).put("c_code", cityCode1);
			System.out.println("---------" + cityCode);
			// }

		}
		return list;
	}

	public List<Map<String, Object>> codeRegion1(String flag) throws Exception {
		List<Map<String, Object>> list = spareDao.code_regionList1(flag);
		// 截取城市编号；
		for (int i = 0; i < list.size(); i++) {
			String cityCode = String.valueOf(list.get(i).get("c_code"));
			String cityCode1 = cityCode.substring(4, 6);
			// if(cityCode1.equals("00"))
			// {
			// list.remove(i);
			// }
			list.get(i).put("c_code", cityCode1);
		}
		return list;
	}

	public List<Map<String, Object>> codeRegion2(String flag) throws Exception {
		List<Map<String, Object>> list = spareDao.code_regionList2(flag);
		return list;
	}

	public List<Map<String, Object>> codeRegion3(String name) throws Exception {
		List<Map<String, Object>> list = spareDao.code_regionList3(name);
		// 截取城市编号；
		return list;
	}
	
	
	
	//删除交换机信息；
	public Object deleteSpareChange(String changId) throws Exception {
		
		Object o=spareDao.basicDeleteData("iov_spare_change", Integer.valueOf(changId));
		return o;
		
	}
	
	
	
	
	
	
	
	

}
