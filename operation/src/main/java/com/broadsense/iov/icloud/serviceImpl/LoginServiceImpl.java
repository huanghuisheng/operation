package com.broadsense.iov.icloud.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.broadsense.iov.icloud.service.LoginService;


@Service("loginService")
public class LoginServiceImpl extends BasicService implements LoginService {
	// private final static Logger LOGGER = LoggerFactory.getLogger(LoginAction.class);
	//登录验证；
	public 	List<Map<String, Object>> loginValidation(  String userName,String userPassword) throws Exception{
	
		
		return loginDao.loginValidation(userName,userPassword);
}   
	
}
	
