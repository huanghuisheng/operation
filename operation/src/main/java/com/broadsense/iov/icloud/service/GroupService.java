package com.broadsense.iov.icloud.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.entity.DeviceClient;

public interface GroupService {
	// ------------------------------------日志查询；
	public Map<String, Object> searchOperationlog(HttpServletRequest request, String offset, String name, String type, String time1, String time2) throws Exception;

	// ---------------------------------显示操作日志；
	public Map<String, Object> showOperationlog(HttpServletRequest request, String offset, String order, String sort) throws Exception;

	// 添加分组
	public List<Map<String, Object>> firstAccoutSaveGroup(HttpServletRequest request, String groupName) throws Exception;

	// 删除分组；
	public String firstAccoutDeleteGroup(HttpServletRequest request, int groupid) throws Exception;
	// 更新分组；
	public String firstAccoutUpdateGroup(HttpServletRequest request, int groupid, String groupName) throws Exception;

	// 显示分组信息；
	public List<Map<String, Object>> firstAccoutShowGroup(HttpServletRequest request) throws Exception;

	// 单个分组信息
	public List<Map<String, Object>> singleShowGroupName(HttpServletRequest request, String groudId) throws Exception;

	 //--------------------------------------------------------账号管理；
    public List<Map<String, Object>> addAdminAccount( HttpServletRequest request, Administrator admin) throws Exception;
    public String deleteAdminAccount( HttpServletRequest request, String adminId) throws Exception;
    public String updateAdminAccount( HttpServletRequest request, Administrator admin) throws Exception;
    
    //显示用户账号
   	public List<Map<String,Object>> showAdminAccout(HttpServletRequest request) throws Exception ;
    //---------------------------------------------------------个人账号管理；
    public String updatePersonalAdminAccount( HttpServletRequest request, String adminName) throws Exception;
    public String updatePersonalAdminAccount1( HttpServletRequest request, String oldAdminPass,String adminPass1) throws Exception; 

    //---------------------------------------------------------设备管理；
    public List<Map<String, Object>> addDeviceImei( HttpServletRequest request,String imei,int groupid) throws Exception;
    public List<Map<String, Object>> addDeviceImeiGroup( HttpServletRequest request,List imei,int groupid) throws Exception;
    
    
    
    public String updateDeviceImei( HttpServletRequest request,String imei,int groupid,int id) throws Exception;
    
    public String deleteDeviceImei( HttpServletRequest request,String imei,int groupid) throws Exception;
    
    //显示分组imei号

   	public Map<String, Object> showGroupImei(HttpServletRequest request,String groupid,int offset) throws Exception ;
    

   	
  //------------------------------------------------------二级用户设备管理
	 
  	//显示二级账号；
      public Map<String,Object> showSecondeClientAccout(HttpServletRequest request,int offset) throws Exception ;
  	 //添加设备-用户
  	 public void addDeviceClient( HttpServletRequest request , DeviceClient deviceClient) throws Exception;
  	 public void deleteDeviceClient(HttpServletRequest request , String deviceClientId) throws Exception;
  	 public void updateDeviceClient( HttpServletRequest request , DeviceClient deviceClient) throws Exception;
  	 //批量导入用户
  	 public void addDeviceClientGroup( HttpServletRequest request , List<List> list) throws Exception;
  	 
  	 
   	
   	//分组模糊查询；
 	public List<Map<String, Object>> fuzzySearch(HttpServletRequest request,String search,String groupid ) throws Exception ;
   	
   	
   	
   	
   	
 	//-------------------------------------------------------二级用户查询；
 	public Map<String,Object> secondSearch(HttpServletRequest request, String search ) throws Exception;	
   	
   	
   	
   	
   	
   	
   	
   	

}
