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
import org.springframework.context.annotation.Scope;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import com.broadsense.iov.icloud.util.JsonFormat;

@Controller
public class SpareController extends BasicController {

	private static Logger logger = Logger.getLogger(SpareController.class);
	// 定义全局list保存IMEI号；
	public static Map<String, List<String>> mapAll = new HashMap<String, List<String>>();
	// 定义备用机替换信息；
	List<Map<String, Object>> sparelist = new ArrayList<Map<String, Object>>();
	// 定义发货单信息；
	List<Map<String, Object>> sendSpareList = new ArrayList<Map<String, Object>>();

	public SpareController(){
		System.out.println("1111111111111111111133331111111111111111111");
	}
	
	
	
	
	// ----------------------------------------------------换机统计
	// 显示备用机信息
	@ResponseBody
	@RequestMapping(value = "basicController/spareChangMsg")
	public Map<String, Object> spareChangList(HttpServletRequest request, HttpServletResponse response, String region, String offset, String order, String sort) throws Exception {
		// 参数验证；
		if (region == null || ("").equals(region)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = null;
		list = spareService.spareChangList(region, offset, order, sort);
		sparelist = (List<Map<String, Object>>) list.get("rows");

		return list;
	}

	// 备用机换机统计-查询备用imei信息
	@ResponseBody
	@RequestMapping(value = "basicController/searchSpare")
	public Map<String, Object> searchSpareChang(HttpServletRequest request, HttpServletResponse response, String spareImei, String code) throws Exception {
		// 参数验证；
		if (spareImei == null || ("").equals(spareImei)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = spareService.searchSpareChang(spareImei, code);
		return list;
	}

	// 备用机换机统计-模糊查询备用imei信息
	@ResponseBody
	@RequestMapping(value = "basicController/fuzzySearchSpareChang")
	public Map<String, Object> fuzzySearchSpareChang(HttpServletRequest request, HttpServletResponse response, String spareImei, String region) throws Exception {
		if (spareImei == null || ("").equals(spareImei)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = spareService.fuzzySearchSpareChang(spareImei, region);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有此IMEI号的");
	}

	// 备用机换机统计-编辑备用机信息；
	@ResponseBody
	@RequestMapping(value = "basicController/spareChangEdit")
	public Map<String, Object> spareChangEdit(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = spareService.spareChangEdit(json, request);
		return JsonFormat.jsonDecode2(list, "修改确认成功", "参数错误");
	}

	// 备用机换机统计-备用机更换；
	@ResponseBody
	@RequestMapping(value = "basicController/spareImieChang")
	public Map<String, Object> spareImieChang(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = spareService.spareImieChang(json, request);
		return JsonFormat.jsonDecode2(list, "修改确认成功", "参数错误");
	}

	// 导出备用机统计信息；

	@RequestMapping(value = "basicController/spareExport")
	public void spareExport(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("-------sparelist-------"+sparelist);
		spareService.spareExport(sparelist, response);
	}

	// -----------------------------------------------------------发货统计
	// 显示发货统计
	@ResponseBody
	@RequestMapping(value = "basicController/spareSendMsg")
	public Map<String, Object> spareSendList(HttpServletRequest request, HttpServletResponse response, String region, String offset, String order, String sort) throws Exception {
		if (region == null || ("").equals(region)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Map<String, Object> list = spareService.spareSendList(region, offset, order, sort);
		return list;
	}

	// 添加下载模板；
	// ---------------------------下载模板1
	@ResponseBody
	@RequestMapping(value = "basicController/sendFileDownload")
	public ResponseEntity<byte[]> sendFileDownload(HttpServletRequest request) throws IOException {
		String homePath = request.getSession().getServletContext().getRealPath("/");
		String path = homePath + "/basicFile/01.xlsx";
		File file = new File(path);
		HttpHeaders headers = new HttpHeaders();
		String fileName = new String("发货导入IMEI号模板.xlsx".getBytes("UTF-8"), "iso-8859-1");// 为了解决中文名称乱码问题
		headers.setContentDispositionFormData("attachment", fileName);
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

	// ---------------------------导入IMEI号
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("basicController/sendFileUpload")
	public Map<String, Object> sendFileUpload(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request, String groupid) throws Exception {
		String path = "/" + new Date().getTime();
		InputStream input = null;

		input = file.getInputStream();
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
		mapAll.put(request.getSession().getId(), listImei);
		System.out.println("list is ---" + listImei);
		System.out.println("error is ---" + errorImei);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("error", errorImei);
		return map;
		// --------------------------------------输出imei号；

	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("basicController/sendFileUpload1")
	public Map<String, Object> sendFileUpload1(@RequestParam("file1") CommonsMultipartFile file, HttpServletRequest request, String groupid) throws Exception {
		String path = "/" + new Date().getTime();
		InputStream input = null;

		input = file.getInputStream();
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
		mapAll.put(request.getSession().getId(), listImei);
		System.out.println("list is ---" + listImei);
		System.out.println("error is ---" + errorImei);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("error", errorImei);
		return map;
		// --------------------------------------输出imei号；

	}

	// ------------------------------------------------------移动发货申请/修改
	@ResponseBody
	@RequestMapping(value = "basicController/sendApplication")
	public Map<String, Object> sendApplication(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = spareService.sendApplication(json, request, response);
		return JsonFormat.jsonDecode2(list, "申请成功", "申请参数错误");
	}

	// -----------------------------------------------------发货确定
	@ResponseBody
	@RequestMapping(value = "basicController/sendApplicationConfirm")
	public Map<String, Object> sendApplicationConfirm(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		System.out.println("----" + json);
		Object list = spareService.sendApplicationConfirm(json, request, mapAll.get(request.getSession().getId()));
		System.out.println("000000"+list);
		return JsonFormat.jsonDecode2(list, "发货确认成功", "申请参数错误");
	}

	// -----------------------------------------------------添加发货确定
	@ResponseBody
	@RequestMapping(value = "basicController/addSendApplicationConfirm")
	public Map<String, Object> addSendApplicationConfirm(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		System.out.println("----" + json);
		Object list = spareService.addSendApplicationConfirm(json, request, mapAll.get(request.getSession().getId()));
		return JsonFormat.jsonDecode2(list, "发货确认成功", "申请参数错误");
	}
    //是否确认收货；
	@ResponseBody
	@RequestMapping(value = "basicController/goodsConfirm")
	public Map<String, Object> goodsConfirm(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		System.out.println("----" + json);
		Object list = spareService.goodsConfirm(json, request);
		return JsonFormat.jsonDecode2(list, "发货确认成功", "申请参数错误");
	}
	
	
	
	
	
	// ----------------------------------------------------发货申请单修改；
	@ResponseBody
	@RequestMapping(value = "basicController/sendApplicationEdit")
	public Map<String, Object> sendApplicationEdit(@RequestBody Map<String, String> json, HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null || ("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		Object list = spareService.sendApplicationEdit(json, request, mapAll.get(request.getSession().getId()));
		return JsonFormat.jsonDecode2(list, "修改确认成功", "参数错误");
	}

	// --------------------------------------------------显示操作日志；
	@ResponseBody
	@RequestMapping(value = "basicController/spareShowLog")
	public Map<String, Object> spareShowLog(@RequestBody Map<String, String> json,HttpServletRequest request, HttpServletResponse response) throws Exception {
		if (json == null ||("").equals(json)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = spareService.spareShowLog(json.get("flag"),json.get("recordId"));
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}
	
	
	
	
	

	// --------------------------------------------------显示全国各地区的发货数量，已安装，已激活，微信绑定，
	@ResponseBody
	@RequestMapping(value = "basicController/spareShow")
	public Map<String, Object> spareShow(HttpServletRequest request, HttpServletResponse response, String code) throws Exception {
		if (code == null || ("").equals(code)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = spareService.spareShow(request, code);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}

	// 各省地区；
	// --------------------------------------------------显示全国各地区的发货数量，已安装，已激活，微信绑定，
	@ResponseBody
	@RequestMapping(value = "basicController/spareShowMap")
	public Map<String, Object> spareShowMap(HttpServletRequest request, HttpServletResponse response, String code) throws Exception {
		if (code == null || ("").equals(code)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = spareService.spareShowMap(request, code);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}

	// 各市地区；
	@ResponseBody
	@RequestMapping(value = "basicController/spareShowProvinceMap")
	public Map<String, Object> spareShowProvinceMap(HttpServletRequest request, HttpServletResponse response, String code) throws Exception {
		if (code == null || ("").equals(code)) {
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
		List<Map<String, Object>> list = spareService.spareShowProvinceMap(request, code);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}

	/*
	 * 公共接口；
	 */
	// 地图编码；
	@ResponseBody
	@RequestMapping(value = "basicController/code_region")
	public List<Map<String, Object>> codeRegion(String code) throws Exception {
		System.out.println("cityid is --------------------" + code);
		List<Map<String, Object>> list;
		list = spareService.codeRegion(code);
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "basicController/code_region1")
	public List<Map<String, Object>> codeRegion1(String code) throws Exception {

		List<Map<String, Object>> list;
		list = spareService.codeRegion1(code);
		return list;
	}

	// 根据编码查询地址；
	@ResponseBody
	@RequestMapping(value = "basicController/code_region2")
	public List<Map<String, Object>> codeRegion2(String code) throws Exception {
		List<Map<String, Object>> list;
		list = spareService.codeRegion2(code);
		return list;
	}

	// 根据省名查地区编码；
	@ResponseBody
	@RequestMapping(value = "basicController/codeRegion3")
	public Map<String, Object> codeRegion3(String name) throws Exception {
		List<Map<String, Object>> list;
		list = spareService.codeRegion3(name);
		return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	}

	//删除交换机信息；
	@ResponseBody
	@RequestMapping(value = "basicController/deleteSpareChange")
	public Map<String, Object> deleteSpareChange(String changId) throws Exception {
		//List<Map<String, Object>> list;
		if(changId==null||("").equals(changId))
		{
			return JsonFormat.jsonDecode("1", "参数不能为空", null);
		}
	Object	list = spareService.deleteSpareChange(changId);
		//return JsonFormat.jsonDecode1(list, "查询成功", "没有数据或参数错误");
	    return JsonFormat.jsonDecode2(list, "删除成功", "没有数据或参数错误");
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
