package com.broadsense.iov.icloud.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.broadsense.iov.icloud.convert.BeanUtils;
import com.broadsense.iov.icloud.dao.BasicDao;
import com.broadsense.iov.icloud.entity.Administrator;
import com.broadsense.iov.icloud.util.GetAddress;
import com.broadsense.iov.icloud.util.JsonFormat;

@Controller
public class LoginController extends BasicController {
	private  static Logger LOGGER = Logger.getLogger(LoginController.class);
	public static List<Object> logonAccounts;
	public LoginController() {
		if (logonAccounts == null) {
			logonAccounts = new ArrayList<Object>();
		}
	}
	List<Map<String, Object>> list;
	List<Map<String, Object>> list1 = new ArrayList<Map<String, Object>>();
	Map<String, Object> map = new HashMap<String, Object>();
	//拦截所有访问页面的请求；
	//跳转页面
	@RequestMapping(value ="index.do")
	public String index(HttpServletRequest request, String offset, String name, String type, String time1,String time2) throws Exception {
		// 设置两个标签
		return "index";
	}
	// 登录验证；
	@ResponseBody
	@RequestMapping(value = "user/login")
	public Map<String, Object> user(String userName, String userPassword, String remember, HttpServletRequest request, HttpServletResponse response) throws Exception {
		List<Map<String, Object>> user = loginService.loginValidation(userName, userPassword);
		List<Map<String, Object>> listMsg = new ArrayList<Map<String, Object>>();
		// list转实体类
		BeanUtils<Administrator> beanUtils = new BeanUtils<Administrator>();
		List<Administrator> administrator = beanUtils.ListMap2JavaBean(user, Administrator.class);
		Map<String, Object> mapMsg = new HashMap<String, Object>();
		String state = null;
		if (user.size() > 0) {
			String sessionId = request.getSession(true).getId();
			HttpSession session = request.getSession(true);
			request.getSession().setAttribute("username", userName);
			request.getSession().setAttribute("userpassword", userPassword);
			request.getSession().setAttribute("adminId", administrator.get(0).getAdminId());
			request.getSession().setAttribute("adminType", administrator.get(0).getAdminType());
			request.getSession().setAttribute("adminGroup", administrator.get(0).getAdminGroup());
			request.getSession().setAttribute("adminDepartment", administrator.get(0).getAdminDepartment());
			request.getSession().setAttribute("adminRole", administrator.get(0).getAdminRole());
			// 获取用户端cookie
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				boolean flag = false;
				for (int i = 0; i < cookies.length; i++) {
					Cookie cookie = cookies[i];
					String name = cookie.getName();
					System.out.println("cookie name is " + name);
					if (cookie.getName().equals("userId")) {
						flag = true;
					}
				}
				if (flag == false) {
					Cookie cookie = new Cookie("userId", String.valueOf(administrator.get(0).getAdminId()));
					cookie.setPath("/");
					response.addCookie(cookie);
					// 插入日志；
					Date day = new Date();
					String address = GetAddress.getIpAddr(request);
					BasicDao.operationLogInsertData(userName, address, "user_login", "运营后台", day, administrator.get(0).getAdminDepartment());
				}
				Cookie[] cookies1 = request.getCookies();
			} else {
				Cookie cookie = new Cookie("userId", String.valueOf(administrator.get(0).getAdminId()));
				cookie.setPath("/");
				response.addCookie(cookie);
				// 插入日志；
				Date day = new Date();
				String address = GetAddress.getIpAddr(request);
				System.out.println("ip地址是" + address);
				BasicDao.operationLogInsertData(userName, address, "user_login", "运营后台", day, administrator.get(0).getAdminDepartment());
			}
			// ------------------------------------------用户跳转问题；
			String contextPath = request.getContextPath();
			// 保存全局路径；
			
			request.getSession().setAttribute("contextPath", contextPath);
			request.getSession().setAttribute("contextPath2", contextPath + "/group/");
			request.getSession().setAttribute("contextPath1", contextPath + "/device/");
			request.getSession().setAttribute("contextPath3", contextPath + "/spare/");
			request.getSession().setAttribute("contextPath4", contextPath + "/spareAs/");
			request.getSession().setAttribute("contextPath5", contextPath + "/deviceAll/");
			state = "0";
			mapMsg.put("jsp", "/device/deviceControl");
			listMsg.add(mapMsg);
			return JsonFormat.jsonDecode(state, "存在用户", listMsg);

		} else {
			state = "1";
			mapMsg.put("jsp", "index.jsp");
			listMsg.add(mapMsg);
			return JsonFormat.jsonDecode(state, "不存在此用户", listMsg);
		}
	}
	// 注销
	@ResponseBody
	@RequestMapping(value = "basicController/closeAccount")
	public Map<String, Object> closeAccount(HttpServletRequest request,HttpServletResponse response) throws Throwable {
		String userName = String.valueOf(request.getSession().getAttribute("username"));
		String adminDepartment = String.valueOf(request.getSession().getAttribute("adminDepartment"));
		//删除cookie
		//获取用户端cookie
		Cookie[] cookies	=request.getCookies();
	      if (cookies != null)  
	      {  
	          for (int i = 0; i < cookies.length; i++)  
	          {  
	        	  Cookie cookie = cookies[i];
	       		  String name=	cookie.getName();
	              if (cookie.getName().equals("userId"))  
	              {  
					Cookie cookie1 = new Cookie(cookie.getName(), null);
					cookie1.setPath("/");// 设置成跟写入cookies一样的
					cookie1.setMaxAge(0);
					response.addCookie(cookie1);
					// 插入日志；
					Date day = new Date();
					String address = GetAddress.getIpAddr(request);
					BasicDao.operationLogInsertData(userName, address,"user_dropout", "运营后台", day, adminDepartment);
	              }  
	          }  
	      }
	      return JsonFormat.jsonDecode("0", "无", null);


	}

}
