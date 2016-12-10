package com.broadsense.iov.icloud.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.entity.DeviceClient;
import com.tonetime.commons.database.helper.DbHelper;
import com.tonetime.commons.database.helper.JdbcCallback;

public interface AfterSaleService {
	//安装网点数据统计；
	public Map<String, Object> afterSaleWebSiteList( String region, String offset, String order, String sort) throws Exception;
	public List<Map<String, Object>> afterSaleWebSiteImeiList( String webSiteId) throws Exception;

	
	// 备用机换机统计信息
	public Map<String, Object> afterSaleChangList(String region, String offset, String order, String sort) throws Exception;

	// 备用机换机统计-查询备用imei信息
	public Map<String, Object> searchAfterSaleChang( String afterSaleImei,String region) throws Exception;

	// 备用机换机统计-模糊查询备用imei信息
	public List<Map<String, Object>> fuzzySearchAfterSaleChang( String afterSaleImei) throws Exception;
	
	// 备用机换机统计-编辑备用机信息；
	public Object afterSaleChangEdit(Map<String, String> json,HttpServletRequest request) throws Exception ;
	
	// 备用机换机统计-备用机更换信息；
	public Object afterSaleImieChang(Map<String, String> json,HttpServletRequest request) throws Exception;
	
	
    //--------------------------------------------------发货统计
	//发货信息显示
	public Map<String, Object> afterSaleSendList(String region, String offset, String order, String sort) throws Exception;
	//发货申请；
	public Object sendAfterSale(Map<String, String> json,HttpServletRequest request, List<String> listImei) throws Exception;
	
	//发货申请单修改
	public Object sendAfterSaleEdit(Map<String, String> json,HttpServletRequest request, List<String> listImei) throws Exception;
	
	
	
	
	//--------------------------------------------------导出数据；
	public void afterSaleExport( List<Map<String,Object>> listImei,HttpServletResponse response) throws Exception;
	public void sendAfterSaleExport( List<Map<String,Object>> listImei,HttpServletResponse response) throws Exception;

	
	//--------------------------------------------------显示日志；
	public List<Map<String, Object>> afterSaleShowLog(String flag,String recordId) throws Exception;
	
	
	//删除交换机信息；
	public Object deleteSpareAsChange(String changId) throws Exception ;
	
	
	//添加售后网点
	public Object addAfterSaleWebSite(Map<String,String> json, HttpServletRequest request, HttpServletResponse response) throws Exception ;
	
	//删除网点；
	public Object deleteAfterSaleWebSite(String webSiteId) throws Exception;
	
	
	
	
}
