package com.broadsense.iov.icloud.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.entity.DeviceClient;
import com.broadsense.iov.icloud.util.JsonFormat;

@Controller
public class AfterSaleController extends BasicController {
	private static Logger logger = Logger.getLogger(AfterSaleController.class);
	// 定义全局list保存IMEI号；
	public static Map<String, List<String>> asmapAll = new HashMap<String, List<String>>();
	// 定义保存导出-备用机替换信息；
	List<Map<String, Object>> afterSalelist = new ArrayList<Map<String, Object>>();
	// 定义保存导出-发货单信息；
	List<Map<String, Object>> sendAfterSaleList = new ArrayList<Map<String, Object>>();

	// ----------------------------------------------------换机统计

	// 显示备用机交换信息
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleChangMsg")
	public Map<String, Object> afterSaleChangList(HttpServletRequest request, HttpServletResponse response, String region, String offset, String order, String sort) throws Exception {
		// 参数验证；
		if (region == null || ("").equals(region)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = null;
		list = afterSaleService.afterSaleChangList(region, offset, order, sort);

		afterSalelist = (List<Map<String, Object>>) list.get("rows");

		return list;
	}

	// 备用机换机统计-查询备用imei信息
	@ResponseBody
	@RequestMapping(value = "basicController/searchAfterSale")
	public Map<String, Object> searchafterSaleChang(HttpServletRequest request, HttpServletResponse response, String afterSaleImei, String region) throws Exception {
		// 参数验证；
		if (afterSaleImei == null || ("").equals(afterSaleImei)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = afterSaleService.searchAfterSaleChang(afterSaleImei, region);
		return list;
	}

	// 备用机换机统计-模糊查询备用imei信息
	@ResponseBody
	@RequestMapping(value = "basicController/fuzzySearchAfterSaleChang")
	public Map<String, Object> fuzzySearchafterSaleChang(HttpServletRequest request, HttpServletResponse response, String afterSaleImei) throws Exception {
		if (afterSaleImei == null || ("").equals(afterSaleImei)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = afterSaleService.fuzzySearchAfterSaleChang(afterSaleImei);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有此IMEI号的");
	}

	// 备用机换机统计-编辑备用机信息；
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleChangEdit")
	public Map<String, Object> afterSaleChangEdit(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = afterSaleService.afterSaleChangEdit(json, request);
		return JsonFormat.jsonDecode2(list, "修改确认成功", "参数错误");
	}

	// 备用机换机统计-备用机更换；
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleImieChang")
	public Map<String, Object> afterSaleImieChang(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = afterSaleService.afterSaleImieChang(json, request);
		return JsonFormat.jsonDecode2(list, "修改确认成功", "参数错误");
	}

	// 导出备用机统计信息；

	@RequestMapping(value = "basicController/afterSaleExport")
	public void afterSaleExport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		afterSaleService.afterSaleExport(afterSalelist, response);
	}

	// --------------------------------------------------显示操作日志；
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleShowLog")
	public Map<String, Object> afterSaleShowLog(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response, String flag, String recordId) throws Exception {
		if (json.get("flag") == null || ("").equals(json.get("flag")) || json.get("recordId") == null || ("").equals(json.get("recordId"))) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}

		List<Map<String, Object>> list = afterSaleService.afterSaleShowLog(json.get("flag"), json.get("recordId"));
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}

	// -----------------------------------------------------------发货统计
	// 显示发货统计
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleSendMsg")
	public Map<String, Object> afterSaleSendList(HttpServletRequest request, HttpServletResponse response, String region, String offset, String order, String sort) throws Exception {
		if (region == null || ("").equals(region)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = afterSaleService.afterSaleSendList(region, offset, order, sort);
		return list;
	}

	// @RequestBody Map<String, String> map
	// ---------------------------导入IMEI号
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("basicController/sendAsFileUpload")
	public Map<String, Object> sendFileUpload(@RequestParam("file1") CommonsMultipartFile file, HttpServletRequest request, String groupid) throws Exception {
		String path = "/" + new Date().getTime();
		InputStream input = file.getInputStream();
		Workbook wb = null;
		wb = new XSSFWorkbook(input);
		Sheet sheet = wb.getSheetAt(0); // 获得第一个表单
		Iterator<Row> rows = sheet.rowIterator();
		List listImei = new ArrayList<Object>();
		List errorImei = new ArrayList<Object>();
		while (rows.hasNext()) {
			Row row = rows.next(); // 获得行数据
			Iterator<Cell> cells = row.cellIterator(); // 获得第一行的迭代器
			if (row.getRowNum() == 0) {
				continue;
			}
			while (cells.hasNext()) {
				Cell cell = cells.next();
				switch (cell.getCellType()) {
				// 根据cell中的类型来输出数据
				case HSSFCell.CELL_TYPE_NUMERIC:
					DecimalFormat df = new DecimalFormat("0");
					String whatYourWant = df.format(cell.getNumericCellValue());
					listImei.add(whatYourWant);
					break;
				default:
					errorImei.add(cell.getStringCellValue());
					break;
				}
			}
		}
		// 根据用户id进行绑定；
		asmapAll.put(request.getSession().getId(), listImei);
		System.out.println("list is ---" + listImei);
		System.out.println("error is ---" + errorImei);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("error", errorImei);
		return map;
	}

	// -----------------------------------------------------发货
	@ResponseBody
	@RequestMapping(value = "basicController/sendAfterSale")
	public Map<String, Object> sendAfterSale(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = afterSaleService.sendAfterSale(json, request, asmapAll.get(request.getSession().getId()));
		return JsonFormat.jsonDecode2(list, "发货确认成功", "申请参数错误");
	}

	// ----------------------------------------------------收货确认；
	@ResponseBody
	@RequestMapping(value = "basicController/sendAfterSaleEdit")
	public Map<String, Object> sendAfterSaleEdit(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = afterSaleService.sendAfterSaleEdit(json, request, asmapAll.get(request.getSession().getId()));
		return JsonFormat.jsonDecode2(list, "收货确认成功", "参数错误");
	}

	// --------------------------------------------------备用机安装网点；
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleWebSiteMsg")
	public Map<String, Object> afterSaleWebSiteList(HttpServletRequest request, HttpServletResponse response, String region, String offset, String order, String sort) throws Exception {
		// 参数验证；
		if (region == null || ("").equals(region)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = null;
		list = afterSaleService.afterSaleWebSiteList(region, offset, order, sort);
		return list;
	}

	// 安装网点IMEI号；
	@ResponseBody
	@RequestMapping(value = "basicController/afterSaleWebSiteImei")
	public Map<String, Object> afterSaleWebSiteImeiList(HttpServletRequest request, HttpServletResponse response, String webSiteId) throws Exception {
		// 参数验证；
		if (webSiteId == null || ("").equals(webSiteId)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = null;
		list = afterSaleService.afterSaleWebSiteImeiList(webSiteId);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}

	// 删除交换机信息；
	@ResponseBody
	@RequestMapping(value = "basicController/deleteSpareAsChange")
	public Map<String, Object> deleteSpareAsChange(String changId) throws Exception {
		// List<Map<String, Object>> list;
		if (changId == null || ("").equals(changId)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = afterSaleService.deleteSpareAsChange(changId);
		// return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
		return JsonFormat.jsonDecode2(list, "删除成功", "没有数据或参数错误");
	}

	// 保存售后网点信息
	@ResponseBody
	@RequestMapping(value = "basicController/addAfterSaleWebSite")
	public Map<String, Object> addAfterSaleWebSite(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		System.out.println("---------website--------------"+json);
	   Object list = afterSaleService.addAfterSaleWebSite(json, request,response);
		return JsonFormat.jsonDecode2(list, "添加成功", "添加参数错误");
		
	}
	// 删除售后网点信息；
	@ResponseBody
	@RequestMapping(value = "basicController/deleteAfterSaleWebSite")
	public Map<String, Object> deleteAfterSaleWebSite(String webSiteId) throws Exception {
		// List<Map<String, Object>> list;
		if (webSiteId == null || ("").equals(webSiteId)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = afterSaleService.deleteAfterSaleWebSite(webSiteId);
		// return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
		return JsonFormat.jsonDecode2(list, "删除成功", "没有数据或参数错误");
	}
	
	
	
	
	
	
	
	

}
