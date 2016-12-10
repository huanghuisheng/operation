package com.broadsense.iov.icloud.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.broadsense.iov.icloud.service.AfterSaleService;
import com.broadsense.iov.icloud.service.DeviceService;
import com.broadsense.iov.icloud.service.GroupService;
import com.broadsense.iov.icloud.service.LoginService;
import com.broadsense.iov.icloud.service.SpareService;
import com.broadsense.iov.icloud.serviceImpl.DeviceServiceImpl;


@Controller("BasicController")
public class BasicController{ 
	
	@Resource(name="loginService")
	 public LoginService loginService; 

	@Resource(name="deviceService")
	 public DeviceService deviceService; 
	
	@Resource(name="groupService")
	 public GroupService groupService; 
	
	@Resource(name="spareService")
	 public SpareService spareService; 
	
	@Resource(name="afterSaleService")
	 public AfterSaleService afterSaleService; 
	
}
