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

public interface SpareService {
	// 备用机换机统计信息
	public Map<String, Object> spareChangList( String region,String offset, String order, String sort) throws Exception;

	// 备用机换机统计-查询备用imei信息
	public Map<String, Object> searchSpareChang( String spareImei,String code) throws Exception;

	// 备用机换机统计-模糊查询备用imei信息
	public List<Map<String, Object>> fuzzySearchSpareChang( String spareImei,String region) throws Exception;
	
	// 备用机换机统计-编辑备用机信息；
	public Object spareChangEdit(Map<String, String> json,HttpServletRequest request) throws Exception ;
	
	// 备用机换机统计-备用机更换信息；
	public Object spareImieChang(Map<String, String> json,HttpServletRequest request) throws Exception;
	
	
    //--------------------------------------------------发货统计
	//发货信息显示
	public Map<String, Object> spareSendList( String region,String offset, String order, String sort) throws Exception;
	//发货申请；
	public Object sendApplication(Map<String, String> json,HttpServletRequest request, HttpServletResponse response) throws Exception;
	//发货申请确定；
	public Object sendApplicationConfirm(Map<String, String> json,HttpServletRequest request, List<String> listImei) throws Exception;
	
	//添加；
	public Object addSendApplicationConfirm(Map<String, String> json,HttpServletRequest request, List<String> listImei) throws Exception;
	
	//发货申请单修改
	public Object sendApplicationEdit(Map<String, String> json,HttpServletRequest request, List<String> listImei) throws Exception;
	//是否确认收货
	public Object goodsConfirm( Map<String, String> json, HttpServletRequest request) throws Exception;
	
	
	
	//--------------------------------------------------导出数据；
	public void spareExport( List<Map<String,Object>> listImei,HttpServletResponse response) throws Exception;
	public void sendSpareExport( List<Map<String,Object>> listImei,HttpServletResponse response) throws Exception;
	
	
	//--------------------------------------------------显示日志；
	public List<Map<String, Object>> spareShowLog(String flag,String recordId) throws Exception;
	
	//--------------------------------------------------显示全国各地区的发货数量，已安装，已激活，微信绑定，
	public List<Map<String, Object>> spareShow(HttpServletRequest request,String code) throws Exception;
	
	 //显示各省的信息；
	  //--------------------------------------------------显示全国各地区的发货数量，已安装，已激活，微信绑定，
	 public List<Map<String, Object>> spareShowMap(HttpServletRequest request,String code) throws Exception;
	//显示各市的信息；
	 public List<Map<String, Object>> spareShowProvinceMap(HttpServletRequest request,String code) throws Exception;
	 
		/*
		 * 公共接口；
		 * */
		//地图编码；
		public List<Map<String, Object>> codeRegion(String flag) throws Exception;
		public List<Map<String, Object>> codeRegion1(String flag) throws Exception;
		public List<Map<String, Object>> codeRegion2(String flag) throws Exception;
		public List<Map<String, Object>> codeRegion3(String name) throws Exception;
	 
	 
	 
		//删除交换机信息；

		public Object deleteSpareChange(String changId) throws Exception ;
	 
	 
	 
	 
	 
	 
	 
	 
	
}
