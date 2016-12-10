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
import org.springframework.web.bind.annotation.RequestMapping;

import com.broadsense.iov.icloud.dao.BasicDao;
import com.broadsense.iov.icloud.service.AfterSaleService;

@Service("afterSaleService")
public class AfterSaleServiceImpl extends BasicService implements AfterSaleService {
	// ----------------------------------------------------------------------------备用机交换统计
	// 显示备用机换机信息
	public Map<String, Object> afterSaleChangList(String region, String offset, String order, String sort) throws Exception {

		// 获取总数；
		List<Map<String, Object>> listNum = afterSaleDao.querySpareAsChangeSum(region);
		int number = Integer.valueOf(String.valueOf(listNum.get(0).get("number")));
		List<Map<String, Object>> list = afterSaleDao.afterSaleChangList(region, Integer.valueOf(offset), order, sort);

		// 更换安装网点信息；
		for (int i = 0; i < list.size(); i++) {
			String webSiteId = String.valueOf(list.get(i).get("c_website_id"));
			String webSiteName = String.valueOf(afterSaleDao.basicQueryById("iov_spare_as_website", Integer.valueOf(webSiteId)).get(0).get("c_install_website"));
			list.get(i).put("c_website_id", webSiteName);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", number);
		map.put("rows", list);
		return map;
	}

	// 备用机换机统计-查询备用imei信息
	public Map<String, Object> searchAfterSaleChang(String afterSaleImei, String region) throws Exception {
		List<Map<String, Object>> list = afterSaleDao.searchAfterSaleChang(afterSaleImei, region);
		if (list.size() > 0) {
			String websiteId = String.valueOf(list.get(0).get("c_website_id"));
			String name = String.valueOf(afterSaleDao.basicQueryById("iov_spare_as_website", Integer.valueOf(websiteId)).get(0).get("c_install_website"));
			list.get(0).put("c_website_id", name);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", "1");
		map.put("rows", list);
		return map;
	}

	// 备用机换机统计-模糊查询备用imei信息
	public List<Map<String, Object>> fuzzySearchAfterSaleChang(String afterSaleImei) throws Exception {
		List<Map<String, Object>> list = afterSaleDao.fuzzySearchAfterSaleChang(afterSaleImei);
		return list;
	}

	// 备用机换机统计-编辑备用机信息；
	public Object afterSaleChangEdit(Map<String, String> json, HttpServletRequest request) throws Exception {
		Date time = new Date();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("n_id", json.get("afterSaleChangId"));
		map.put("c_respace_imei", json.get("respaceImei"));
		map.put("c_remark", json.get("remark"));
		map.put("c_express_id", json.get("expressId"));
		map.put("c_charge", json.get("charge"));
		if (json.get("respaceImei") != null && !("").equals(json.get("respaceImei"))) {
			System.out.println("-------11111---------" + json.get("respaceImei"));
			map.put("c_spare_state", "1");
		}

		map.put("t_time", time);
		Object object = afterSaleDao.basicUpdate("iov_spare_as_change", map, "n_id=" + json.get("afterSaleChangId"));

		if (!object.equals("0")) {
			// 获取备用机id；

			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "修改替换机器IMEI号" + json.get("respaceImei"), date, "11", json.get("afterSaleChangId"));
		}
		return object;
	}

	// 备用机换机统计-备用机更换信息；
	public Object afterSaleImieChang(Map<String, String> json, HttpServletRequest request) throws Exception {
		Date time = new Date();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_respace_imei", json.get("respaceImei"));
		map.put("c_remark", json.get("remark"));
		map.put("t_time", time);
		map.put("c_express_id", json.get("expressId"));
		System.out.println("-------22222---------" + json.get("respaceImei"));
		// 使用状态；
		if (json.get("respaceImei") != null && !("").equals(json.get("respaceImei"))) {
			System.out.println("-------11111---------" + json.get("respaceImei"));
			map.put("c_spare_state", "1");
		}

		Object object = afterSaleDao.basicUpdate("iov_as_change", map, "c_imei=" + json.get("afterSaleImei"));
		if (!object.equals("0")) {
			// 获取备用机id；
			String spareId = String.valueOf(spareDao.basicQueryByFields("iov_as_change", map).get(0).get("n_id"));
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "修改替换机器IMEI号" + json.get("respaceImei"), date, "00", spareId);
		}
		return object;
	}

	// --------------------------------------------------------------------------------发货统计
	// 显示发货信息
	public Map<String, Object> afterSaleSendList(String region, String offset, String order, String sort) throws Exception {
		List<Map<String, Object>> listNum = afterSaleDao.afterSaleSendSum(region);

		int number = Integer.valueOf(String.valueOf(listNum.get(0).get("number")));
		List<Map<String, Object>> list = afterSaleDao.afterSaleSendList(region, Integer.valueOf(offset), order, sort);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", number);
		map.put("rows", list);
		return map;
	}

	// 发货申请；
	public Object sendAfterSale(Map<String, String> json, HttpServletRequest request, List<String> listImei) throws Exception {
		List<Map<String, Object>> addList = new ArrayList<Map<String, Object>>();

		String name = String.valueOf(request.getSession().getAttribute("username"));
		Date date = new Date();
		// 通过安装网点id查询安装网点地址；
		List<Map<String, Object>> webList = afterSaleDao.basicQueryById("iov_spare_as_website", Integer.valueOf(json.get("websiteId")));
		String address = String.valueOf(webList.get(0).get("c_address"));
		// 发货申请确认；
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("c_number", json.get("number"));
		map.put("c_receiver", json.get("receiver"));
		map.put("c_address", address);
		map.put("c_receiver_state", json.get("receiveState"));
		map.put("c_model", json.get("model"));
		map.put("c_send_type", json.get("sendType"));
		map.put("t_send_time", date);
		map.put("c_region", json.get("region"));
		map.put("c_express_id", json.get("expressId"));
		map.put("c_website_id", json.get("websiteId"));
		map.put("c_shipper", json.get("shipper"));
		map.put("c_area", json.get("area"));
		Object object = afterSaleDao.basicInsertData("iov_spare_as_send", map);

		if (object.equals("0")) {
			return object;
		} else {
			// 获取备用机id；
			String afterSaleId = String.valueOf(spareDao.basicQueryByFields("iov_spare_as_send", map).get(0).get("n_id"));
			// 备用机交换信息插入；
			if (json.get("sendType").equals("1")) {
				List<Object> spareAsObject = null;
				for (int i = 0; i < listImei.size(); i++) {
					Map<String, Object> afterSaleMap = new HashMap<String, Object>();
					// 地区，备用机IMEI号，model，发货id
					afterSaleMap.put("c_region", json.get("region"));
					afterSaleMap.put("c_website_id", json.get("websiteId"));
					afterSaleMap.put("c_model", json.get("model"));
					afterSaleMap.put("c_spare_imei", listImei.get(i));
					afterSaleMap.put("c_send_id", afterSaleId);
					afterSaleMap.put("c_spare_state", "0");
					// 是否收货；
					afterSaleMap.put("c_receive_state", json.get("receiveState"));
					// afterSaleDao.basicInsertData("iov_spare_as_change",
					// afterSaleMap);
					addList.add(afterSaleMap);

				}
				spareAsObject = afterSaleDao.insertAsSpareBatch(addList);
				if (spareAsObject.size() > 0) {
					// 发货申请确认log
					BasicDao.spareLogInsertData(name, "发货申请", date, "10", afterSaleId);
					// 插入交换表
					for (int j = 0; j < spareAsObject.size(); j++) {
						BasicDao.spareLogInsertData(name, "导入备用机信息", date, "11", String.valueOf(spareAsObject.get(j)));
					}
					return 1;
				} else {
					spareDao.basicDeleteData("iov_spare_send", Integer.valueOf(afterSaleId));
				}
			} else {
				// 发货申请确认log
				BasicDao.spareLogInsertData(name, "发货申请", date, "10", afterSaleId);
			}

		}
		return object;
	}

	// 收货确认；
	public Object sendAfterSaleEdit(Map<String, String> json, HttpServletRequest request, List<String> listImei) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("n_id", json.get("sendId"));
		map.put("c_receiver_state", "1");
		Object object = afterSaleDao.basicUpdate("iov_spare_as_send", map, "n_id=" + json.get("sendId"));
		if (object.equals("0")) {
			return object;
		} else {
			// 获取发货申请id；
			String name = String.valueOf(request.getSession().getAttribute("username"));
			Date date = new Date();
			BasicDao.spareLogInsertData(name, "已经确认收货", date, "10", json.get("sendId"));

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("c_receive_state", "1");
			afterSaleDao.basicUpdate("iov_spare_as_change", map1, "c_send_id=" + json.get("sendId"));
		}

		return object;
	}

	// -----------------------------------------------------------------------导出数据；
	public void afterSaleExport(List<Map<String, Object>> listImei, HttpServletResponse response) throws Exception {
		// 时间，安装网点，备用机IMEI号，替换机器IMEI号，安装状态，寄回信息，快递费用，备注信息
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet();
		HSSFRow row = sheet.createRow((int) 0);
		HSSFCellStyle style = wb.createCellStyle();
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		HSSFCell cell = row.createCell(0);
		cell.setCellValue("时间");
		cell.setCellStyle(style);
		cell = row.createCell(1);
		cell.setCellValue("安装网点");
		cell.setCellStyle(style);
		cell = row.createCell(2);
		cell.setCellValue("备用机IMEI号");
		cell.setCellStyle(style);
		cell = row.createCell(3);
		cell.setCellValue("替换机器IMEI号");
		cell.setCellStyle(style);
		cell = row.createCell(4);
		cell.setCellValue("安装状态");
		cell.setCellStyle(style);
		cell = row.createCell(5);
		cell.setCellValue("寄回信息");
		cell.setCellStyle(style);
		cell = row.createCell(6);
		cell.setCellValue("快递费用");
		cell.setCellStyle(style);
		cell = row.createCell(7);
		cell.setCellValue("备注信息");
		cell.setCellStyle(style);
		List<Map<String, Object>> list = listImei;
		for (int i = 0; i < list.size(); i++) {
			row = sheet.createRow((int) i + 1);
			String a = String.valueOf(list.get(i).get("t_time"));
			String b = String.valueOf(list.get(i).get("c_website_id"));
			String c = String.valueOf(list.get(i).get("c_afterSale_imei"));
			String d = String.valueOf(list.get(i).get("c_respace_imei"));
			String e = String.valueOf(list.get(i).get("c_install_state"));
			String f = String.valueOf(list.get(i).get("c_express_message"));
			String g = String.valueOf(list.get(i).get("c_charge"));
			String h = String.valueOf(list.get(i).get("c_remark"));
			if (list.get(i).get("t_time") == null) {
				a = "";
			}
			if (list.get(i).get("c_website_id") == null) {
				b = "";
			}
			if (list.get(i).get("c_afterSale_imei") == null) {
				c = "";
			}
			if (list.get(i).get("c_respace_imei") == null) {
				d = "";
			}
			if (list.get(i).get("c_install_state") == null) {
				e = "";
			}
			if (list.get(i).get("c_express_message") == null) {
				f = "";
			}
			if (list.get(i).get("c_charge") == null) {
				g = "";
			}
			if (list.get(i).get("c_charge") == null) {
				h = "";
			}
			row.createCell(0).setCellValue(a);
			row.createCell(1).setCellValue(b);
			row.createCell(2).setCellValue(c);
			row.createCell(3).setCellValue(d);
			row.createCell(4).setCellValue(e);
			row.createCell(5).setCellValue(f);
			row.createCell(6).setCellValue(g);
			row.createCell(7).setCellValue(h);
		}
		try {
			// 转换格式，拼接文件文件后缀名
			Date date = new Date();
			SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String dateDay = sdf1.format(date);
			String fileName = "备用机信息" + dateDay;
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

	public void sendAfterSaleExport(List<Map<String, Object>> listImei, HttpServletResponse response) throws Exception {
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
		cell.setCellValue("发货人");
		cell.setCellStyle(style);
		cell = row.createCell(2);
		cell.setCellValue("发货备用机数量");
		cell.setCellStyle(style);
		cell = row.createCell(3);
		cell.setCellValue("收货人");
		cell.setCellStyle(style);
		cell = row.createCell(4);
		cell.setCellValue("收货地址");
		cell.setCellStyle(style);
		cell = row.createCell(5);
		cell.setCellValue("快递信息");
		cell.setCellStyle(style);
		cell = row.createCell(6);
		cell.setCellValue("是否确认收货");
		cell.setCellStyle(style);
		List<Map<String, Object>> list = listImei;
		for (int i = 0; i < list.size(); i++) {
			row = sheet.createRow((int) i + 1);
			String a = String.valueOf(list.get(i).get("t_semd_time"));
			String b = String.valueOf(list.get(i).get("c_shipper"));
			String c = String.valueOf(list.get(i).get("c_number"));
			String d = String.valueOf(list.get(i).get("c_receiver"));
			String e = String.valueOf(list.get(i).get("c_address"));
			String f = String.valueOf(list.get(i).get("c_express_message"));
			String g = String.valueOf(list.get(i).get("c_receiver_state"));
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

	// -------------------------------------------------------------------安装网点；
	// 安装网点数据统计；
	public Map<String, Object> afterSaleWebSiteList(String region, String offset, String order, String sort) throws Exception {
		// 获取总数；
		List<Map<String, Object>> listNum = afterSaleDao.afterSaleWebSiteSum(region);
		int number = Integer.valueOf(String.valueOf(listNum.get(0).get("number")));
		List<Map<String, Object>> list = afterSaleDao.afterSaleWebSiteList(region, Integer.valueOf(offset), order, sort);
		for (int i = 0; i < list.size(); i++) {
			String webSiteId = String.valueOf(list.get(i).get("n_id"));
			String number1 = String.valueOf(afterSaleDao.afterSaleWebSiteImeiSum(webSiteId).get(0).get("number"));
			list.get(i).put("n_count", number1);
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("total", number);
		map.put("rows", list);
		return map;
	}

	// 获取安装网点imei号；
	public List<Map<String, Object>> afterSaleWebSiteImeiList(String webSiteId) throws Exception {
		List<Map<String, Object>> list = afterSaleDao.afterSaleWebSiteImeiList(webSiteId);
		return list;
	}

	// --------------------------------------------------显示日志；
	public List<Map<String, Object>> afterSaleShowLog(String flag, String recordId) throws Exception {
		System.out.println("----flag is --" + flag + "-----recordId----" + recordId);
		List<Map<String, Object>> list = afterSaleDao.afterSaleShowLog(flag, recordId);
		return list;
	}
	
	
	//删除交换机信息；
	public Object deleteSpareAsChange(String changId) throws Exception {
		Object o=spareDao.basicDeleteData("iov_spare_as_change", Integer.valueOf(changId));
		return o;
	}
	
	//添加售后网点
	@RequestMapping(value = "basicController/addAfterSaleWebSite")
	public Object addAfterSaleWebSite(Map<String,String> json, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		//{region=440106, installWebSite=天下是开放近段时间, address=广东, contacts=李阳, telephone=, falg=1}
		
		Map<String, Object> map=new HashMap<String,Object>();
		map.put("c_region",  json.get("region"));
		map.put("c_install_website", json.get("installWebSite"));
		map.put("c_address", json.get("address"));
		map.put("c_contacts",json.get("contacts"));
		map.put("c_telephone",json.get("telephone"));
		map.put("n_falg",json.get("falg"));
		Object o=spareDao.basicInsertData("iov_spare_as_website", map);
		return o;

	}
	//删除网点；
	public Object deleteAfterSaleWebSite(String webSiteId) throws Exception
	{
		
		Object o=spareDao.basicDeleteData("iov_spare_as_website", Integer.valueOf(webSiteId));
		return o;
	}
	
	
	
	
	
	

}
