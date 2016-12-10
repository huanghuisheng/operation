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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.entity.DeviceClient;
import com.broadsense.iov.icloud.util.JsonFormat;

@Controller
public class GroupController extends BasicController{
	private static Logger logger = Logger.getLogger(GroupController.class);
	@ResponseBody
	@RequestMapping(value = "basicController/addGroup")
	public Map<String, Object> addGroup(HttpServletRequest request, HttpServletResponse response, String groupName) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = groupService.firstAccoutSaveGroup(request, groupName);
		String state = null;
		if (list.size() > 0) {
			state = "0";
		} else {
			state = "1";
		}
		return JsonFormat.jsonDecode(state, "无", list);
	}

	@ResponseBody
	@RequestMapping(value = "basicController/deleteGroup")
	public Map<String, Object> deleteGroup(HttpServletRequest request, HttpServletResponse response, String groupid) throws Exception {
		// 设置两个标签；
		Map<String, Object> listMap = new HashMap<String, Object>();
		String state = groupService.firstAccoutDeleteGroup(request, Integer.valueOf(groupid));
		listMap.put("code", state);
		return listMap;
	}

	@ResponseBody
	@RequestMapping(value = "basicController/updateGroup")
	public Map<String, Object> updateGroup(HttpServletRequest request, HttpServletResponse response, String groupid, String groupName) throws Exception {
		// 设置两个标签；
		String state = groupService.firstAccoutUpdateGroup(request, Integer.valueOf(groupid), groupName);
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("code", state);
		return listMap;

	}

	// 显示分组信息；
	@ResponseBody
	@RequestMapping(value = "basicController/showGroup")
	public Map<String, Object> showGroup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = groupService.firstAccoutShowGroup(request);
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("result", list);
		listMap.put("code", "0");
		return listMap;

	}
	// ---------------------------------------------------------获取单个分组名称
	@ResponseBody
	@RequestMapping(value = "basicController/singleShowGroupName")
	public Map<String, Object> singleShowGroupName(HttpServletRequest request, HttpServletResponse response, String groupId) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = groupService.singleShowGroupName(request, groupId);
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("result", list);
		listMap.put("state", "0");
		return listMap;

	}

	// ------------------------------------------------------------------------设备管理；
	// 单个设备导入；
	@ResponseBody
	@RequestMapping(value = "basicController/addDeviceImei")
	public Map<String, Object> addDeviceImei(HttpServletRequest request, HttpServletResponse response, String imei, String groupid) throws Exception {
		// 设置两个标签；

		String state = null;
		List<Map<String, Object>> list = null;
		list = groupService.addDeviceImei(request, imei, Integer.valueOf(groupid));
		if (list.size() > 0) {
			state = "0";
		} else {
			state = "1";
		}
		return JsonFormat.jsonDecode(state, "", list);

	}

	// 单个设备更新；
	@ResponseBody
	@RequestMapping(value = "basicController/updateDeviceImei")
	public Map<String, Object> updateDeviceImei(HttpServletRequest request, HttpServletResponse response, String imei, String groupid, String id) throws Exception {
		// 设置两个标签；
		String state = null;
		state = groupService.updateDeviceImei(request, imei, Integer.valueOf(groupid), Integer.valueOf(id));
		return JsonFormat.jsonDecode(state, "", null);

	}

	@ResponseBody
	@RequestMapping(value = "basicController/deleteDeviceImei")
	public Map<String, Object> deleteDeviceImei(HttpServletRequest request, HttpServletResponse response, String imei, String groupid) throws Exception {
		// 设置两个标签；
		String state = null;
		state = groupService.deleteDeviceImei(request, imei, Integer.valueOf(groupid));
		return JsonFormat.jsonDecode(state, "", null);
	}
	
	// ---------------------------下载模板1
	@ResponseBody
	@RequestMapping(value = "basicController/firstFileDownload")
	public ResponseEntity<byte[]> firstFileDownload(HttpServletRequest request) throws IOException {

		String cp11111 = request.getSession().getServletContext().getRealPath("/");
		String path1 = request.getContextPath();
		String path = cp11111 + "/basicFile/01.xlsx";
		File file = new File(path);
		HttpHeaders headers = new HttpHeaders();
		String fileName = new String("批量导入.xlsx".getBytes("UTF-8"), "iso-8859-1");// 为了解决中文名称乱码问题
		headers.setContentDispositionFormData("attachment", fileName);
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}

	// ----------------------------批量导入
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping("basicController/fileUpload2")
	public Map<String, Object> fileUpload2(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request, String groupid) throws Exception {
		String path1 = request.getContextPath();
		String cp11111 = request.getSession().getServletContext().getRealPath("/");
		String path = "/" + new Date().getTime();
		InputStream input = file.getInputStream();
		Workbook wb = null;
		// 根据文件格式(2003或者2007)来初始化
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
		System.out.println("list is ---" + listImei);
		System.out.println("list size is ---" + listImei.size());
		System.out.println("error is ---" + errorImei);
		System.out.println("groupid is ---" + groupid);
		
		// --------------------------------------输出imei号；
		List<Map<String, Object>> list = groupService.addDeviceImeiGroup(request, listImei, Integer.valueOf(groupid));
		String state = null;
	
		
		String msg=null;
		if (list.size() > 0) {
			state = "0";
			msg = "查询成功";
		} else {
			state = "1";
			msg = "没有账号";
		}
		return JsonFormat.jsonDecode(state, msg, list);
		
		//return "redirect:/group/firstDeviceImei?groupId=" + groupid;
		 
      
	}

	// ------------------------------------------------------------------------------显示分组imei号
	@ResponseBody
	@RequestMapping(value = "basicController/showGroupImei")
	public Map<String, Object> showGroupImei(HttpServletRequest request, HttpServletResponse response, String groupId, String offset) throws Exception {
		// 设置两个标签；
		Map<String, Object> listMap = groupService.showGroupImei(request, groupId, Integer.valueOf(offset));
		return listMap;
	}

	// ------------------------------------------------------------------------用户账号管理

	// 显示用户账号
	@ResponseBody
	@RequestMapping(value = "basicController/showAdminAccout")
	public Map<String, Object> showAdminAccout(HttpServletRequest request) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = groupService.showAdminAccout(request);
		String state = null;
		String msg = null;
		if (list.size() > 0) {
			state = "0";
			msg = "查询成功";
		} else {
			state = "1";
			msg = "没有账号";
		}
		return JsonFormat.jsonDecode(state, msg, list);
	}

	@ResponseBody
	@RequestMapping(value = "basicController/addAdminAccout")
	public Map<String, Object> addAdminAccout(@ModelAttribute(" Administrator ") Administrator admin, HttpServletRequest request) throws Exception {
		// 设置两个标签；

		List<Map<String, Object>> list = groupService.addAdminAccount(request, admin);
		String state = null;
		String msg = null;
		if (list.size() > 0) {
			state = "0";
			msg = "添加成功";
		} else {
			state = "1";
			msg = "参数不能为空";
		}

		return JsonFormat.jsonDecode(state, msg, list);

	}

	@ResponseBody
	@RequestMapping(value = "basicController/deleteAdminAccount")
	public Map<String, Object> deleteAdminAccount(HttpServletRequest request, String adminID) throws Exception {
		// 设置两个标签；

		String state = groupService.deleteAdminAccount(request, adminID);

		return JsonFormat.jsonDecode(state, "", null);

	}

	@ResponseBody
	@RequestMapping(value = "basicController/updateAdminAccount")
	public Map<String, Object> updateAdminAccount(@ModelAttribute(" Administrator ") Administrator admin, HttpServletRequest request) throws Exception {
		// 设置两个标签；

		String state = groupService.updateAdminAccount(request, admin);

		return JsonFormat.jsonDecode(state, "", null);

	}

	// ---------------------------------------一级账号个人用户管理；
	@ResponseBody
	@RequestMapping(value = "basicController/updatePersonalAdminAccount")
	public Map<String, Object> updatePersonalAdminAccount(HttpServletRequest request, String adminName) throws Exception {
		// 设置两个标签；

		String state = groupService.updatePersonalAdminAccount(request, adminName);
		return JsonFormat.jsonDecode(state, "", null);
	}

	@ResponseBody
	@RequestMapping(value = "basicController/updatePersonalAdminAccount1")
	public Map<String, Object> updatePersonalAdminAccount(HttpServletRequest request, String oldAdminPass, String adminPass1) throws Exception {
		// 设置两个标签；

		String state = groupService.updatePersonalAdminAccount1(request, oldAdminPass, adminPass1);
		return JsonFormat.jsonDecode(state, "", null);
	}
	
	// ------------------------------------日志查询；
	@ResponseBody
	@RequestMapping(value = "basicController/searchOperationlog")
	public Map<String, Object> searchOperationlog(HttpServletRequest request, String offset, String name, String type, String time1, String time2) throws Exception {
		// 设置两个标签
		Map<String, Object> map = groupService.searchOperationlog(request, offset, name, type, time1, time2);
		return map;
	}

	// ---------------------------------显示操作日志；
	@ResponseBody
	@RequestMapping(value = "basicController/showOperationlog")
	public Map<String, Object> showOperationlog(HttpServletRequest request, String offset, String order, String sort) throws Exception {
		// 设置两个标签
		Map<String, Object> map = groupService.showOperationlog(request, offset, order, sort);
		return map;
	}
	
	
	//---------------------------------------------2级用户管理
		//----------------------------------------------------------------设备管理
		//新增单一设备；
		@ResponseBody
		@RequestMapping(value = "basicController/addDeviceClient")
		public void addDeviceClient(@ModelAttribute("DeviceClient") DeviceClient deviceClient, HttpServletRequest request)
				throws Exception {
			// 设置两个标签；
			Administrator administrator = (Administrator) request.getSession().getAttribute("administrator");
			groupService.addDeviceClient(request, deviceClient);

		}
		  
		@ResponseBody
		@RequestMapping(value = "basicController/deleteDeviceClient")
		public void deleteDeviceClient(HttpServletRequest request,
				String deviceClientId) throws Exception {
			// 设置两个标签；

			Administrator administrator = (Administrator) request.getSession()
					.getAttribute("administrator");
			groupService.deleteDeviceClient(request, deviceClientId);

		}
		
		
		  @ResponseBody
			@RequestMapping(value="basicController/updateDeviceClient")
			public void updateDeviceClient(@ModelAttribute("DeviceClient") DeviceClient deviceClient,HttpServletRequest request) throws Exception {
		   //设置两个标签；		    	
			Administrator administrator = (Administrator) request.getSession()
					.getAttribute("administrator"); 	
			groupService.updateDeviceClient(request, deviceClient);
		    	
			}
		  

		  //-----------------------------------------------------------------imei号批量导入；
		    @ResponseBody
		    @RequestMapping("basicController/secondFileUpload")  
		    public Map<String, Object>  fileUpload(@RequestParam("file") CommonsMultipartFile file,HttpServletRequest request) throws Exception {	      
		   
			InputStream input = file.getInputStream();
			Workbook wb = null;
			// 根据文件格式(2003或者2007)来初始化

			wb = new XSSFWorkbook(input);

			Sheet sheet = wb.getSheetAt(0); // 获得第一个表单
			List<List> listImei1 = new ArrayList<List>();

			int rows = sheet.getPhysicalNumberOfRows();
			System.out.println("--rows is "+rows);
			// 遍历行
			for (int i = 1; i < rows; i++) {
				// 读取左上端单元格

				Row row = sheet.getRow(i);
				// 行不为空
				if (row != null) {
					// 获取到Excel文件中的所有的列
					int cells = row.getPhysicalNumberOfCells();
					String value = "";
					// Map<String,Object> map=new HashMap<String,Object>();
					List listImei = new ArrayList<Object>();
					// 遍历列
					for (int j = 0; j < 4; j++) {
						// 获取到列的值
						Cell cell = row.getCell(j);
						
						if (cell != null) {
							switch (cell.getCellType()) {
							// 根据cell中的类型来输出数据
							case HSSFCell.CELL_TYPE_NUMERIC:
								DecimalFormat df = new DecimalFormat("0");
								String whatYourWant = df.format(cell.getNumericCellValue());
								listImei.add(whatYourWant);
								System.out.println("----string-1-----"+whatYourWant);
								break;
							case HSSFCell.CELL_TYPE_STRING:
								// System.out.println("-1"+cell.getStringCellValue());
								if(cell.getStringCellValue()==null||("").equals(cell.getStringCellValue())){
									listImei.add("");			
								}else
								{
									listImei.add(cell.getStringCellValue());	
								}
								System.out.println("----string-2-----"+cell.getStringCellValue());
								
								break;
							case HSSFCell.CELL_TYPE_BOOLEAN:
								// System.out.println("-1"+cell.getBooleanCellValue());
								listImei.add(cell.getBooleanCellValue());
								System.out.println("----string3------"+cell.getBooleanCellValue());
								break;
							case HSSFCell.CELL_TYPE_FORMULA:
								// System.out.println("-1"+cell.getCellFormula());
								listImei.add(cell.getCellFormula());
								System.out.println("----string4------"+cell.getCellFormula());
								break;
							default:
								listImei.add("");
								System.out.println("----string5------");
								break;
							}
						}else{
							listImei.add(" ");
							System.out.println("sssss cell");
						}
							
					}
					listImei1.add(listImei);
				}
			}
	  
			groupService.addDeviceClientGroup(request, listImei1);
			// return null;
			//return "redirect:/group/secondDeviceClient";
		
			return  JsonFormat.jsonDecode("0", "无", null);
		    }
		    

		  
		  @ResponseBody
			@RequestMapping(value="basicController/fileDownload")
		  public ResponseEntity<byte[]> download(HttpServletRequest request) throws IOException { 
			  
			String cp11111 = request.getSession().getServletContext().getRealPath("/");
			String path1 = request.getContextPath();
			String path = cp11111 + "/basicFile/02.xlsx";

			File file = new File(path);
			HttpHeaders headers = new HttpHeaders();
			String fileName = new String("批量.xlsx".getBytes("UTF-8"), "iso-8859-1");// 为了解决中文名称乱码问题
			headers.setContentDispositionFormData("attachment", fileName);
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file),headers, HttpStatus.CREATED);
			
		    }    

		  
		  
		  
		  
		  
		  
		  //---------------------------------------2级账号个人用户管理；
		    @ResponseBody
		   	@RequestMapping(value="basicController/updatePersonalClientAccount")
		   	public void updatePersonalClientAccount(HttpServletRequest request,String adminName ) throws Exception {
		      //设置两个标签；	
		    	 groupService.updatePersonalAdminAccount(request, adminName);
		   	}
		    
		    
		    
		    @ResponseBody
		   	@RequestMapping(value="basicController/updatePersonalClientAccount1")
		   	public void updatePersonalClientAccount1(HttpServletRequest request,String oldAdminPass,String adminPass1) throws Exception {
		      //设置两个标签；	
		    	 Administrator administrator=(Administrator) request.getSession().getAttribute("administrator"); 
		    	 
		    	 groupService.updatePersonalAdminAccount1(request, oldAdminPass,adminPass1);
		    	 
		   	}   
		    
		    //----------------------------------显示二级账号
		  //显示用户账号
		    @ResponseBody
		   	@RequestMapping(value="basicController/showSecondeClientAccout")
		   	public Map<String,Object> showSecondeAdminAccout(HttpServletRequest request,String offset) throws Exception {
		      //设置两个标签；	
		      Map<String, Object> list=   groupService.showSecondeClientAccout(request,Integer.valueOf(offset));
		      return list;
		   	} 
	
	
		    
		    
		    // ------------------------------------------分组实时模糊查询
	@ResponseBody
	@RequestMapping(value = "basicController/fuzzySearch")
	public Map<String, Object> fuzzySearch(HttpServletRequest request,
			String search, String groupid) throws Exception {
		// 设置两个标签；
		List<Map<String, Object>> list = null;
		list = groupService.fuzzySearch(request, search, groupid);
		String state = null;
		if (list.size() > 0) {
			state = "0";
		} else {
			state = "1";
		}
		return JsonFormat.jsonDecode(state, "无", list);
	}
	
	
	//-------------------------------------------------------二级用户查询；
	@ResponseBody
	@RequestMapping(value="basicController/secondSearch")
	public Map<String,Object> secondSearch(HttpServletRequest request, HttpServletResponse response ,String search ) throws Exception {
   //设置两个标签；	    	
    Map<String,Object> list=null;	    	
       System.out.println("搜索内容是-------"+search);	
    	list= groupService.secondSearch(request, search);
      return list;    	
	}
	
	
		    
		    
		    
		
	
	
	
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
		    
	
	
}
