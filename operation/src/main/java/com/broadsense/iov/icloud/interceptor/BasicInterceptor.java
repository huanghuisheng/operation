package com.broadsense.iov.icloud.interceptor;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BasicInterceptor extends HttpServlet {

	// 处理 GET 方法请求的方法
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			jumpRequest(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 处理 POST 方法请求的方法
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			jumpRequest(request, response);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 截取有效的URL路徑
	public String[] getUrl(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 设置响应内容类型
		String uri = request.getRequestURI();
		StringBuffer url = request.getRequestURL();
		String contextPath = request.getContextPath();
		int a = contextPath.length();
		uri = uri.substring(a + 1);
		String[] array = uri.split("/");
		return array;
	}
	
	//判斷是否有登錄
	@SuppressWarnings("unused")
	public boolean verification(HttpServletRequest request, HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("userId")) {
				return true;
			}
		}
		return false;
	}
	//判断跳转方式；
	public void jumpRequest(HttpServletRequest request, HttpServletResponse response) throws Exception, IOException {
		// 判断是否有权限；
		boolean flag = verification(request, response);
		if (flag == false) {
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
		String[] url = getUrl(request, response);
		if ("controller".equals(url[0])) {
			request.getRequestDispatcher("/basicController/" + url[1]).forward(request, response);
		} else if ("device".equals(url[0])) {
			System.out.println("-----------");
			request.getRequestDispatcher("/WEB-INF/device/" + url[1] + ".jsp").forward(request, response);
		} else if ("group".equals(url[0])) {
			request.getRequestDispatcher("/WEB-INF/group/" + url[1] + ".jsp").forward(request, response);
		}
		else if ("spare".equals(url[0])) {
			request.getRequestDispatcher("/WEB-INF/spare/" + url[1] + ".jsp").forward(request, response);
		}
		else if ("spareAs".equals(url[0])) {
			request.getRequestDispatcher("/WEB-INF/spareAs/" + url[1] + ".jsp").forward(request, response);
		}
		else if ("deviceAll".equals(url[0])) {
			request.getRequestDispatcher("/WEB-INF/deviceAll/" + url[1] + ".jsp").forward(request, response);
		}
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}

