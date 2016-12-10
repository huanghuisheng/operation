package com.broadsense.iov.icloud.service;

import java.util.List;
import java.util.Map;



public interface LoginService  {

	
	//登录验证；
	public 	List<Map<String, Object>> loginValidation(  String userName,String userPassword) throws Exception;

	
}
	
	
	
