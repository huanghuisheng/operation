package com.broadsense.iov.icloud.serviceImpl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.broadsense.iov.icloud.dao.AfterSaleDao;
import com.broadsense.iov.icloud.dao.BasicDao;
import com.broadsense.iov.icloud.dao.DeviceDao;
import com.broadsense.iov.icloud.dao.GroupDao;
import com.broadsense.iov.icloud.dao.LoginDao;
import com.broadsense.iov.icloud.dao.SpareDao;



@Service("basicService")

public class BasicService<T> {
	 private final static Logger LOGGER = Logger.getLogger(BasicService.class);
	 
	 @Resource(name="loginDao")
	 public LoginDao loginDao; 

	 @Resource(name="deviceDao")
	 public DeviceDao deviceDao; 
	 
	 @Resource(name="groupDao")
	 public GroupDao groupDao; 
	  
	 @Resource(name="spareDao")
	 public SpareDao spareDao; 
	
	 @Resource(name="afterSaleDao")
	 public AfterSaleDao afterSaleDao; 
	 
	 
	 
	 
	 
	 
	 
}
