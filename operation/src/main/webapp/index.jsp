<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="com.tonetime.commons.util.*"%>
<%@page import="java.net.URLDecoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isELIgnored="false"%>
<%  
  /* 请求转发 */
  request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
 // request.getRequestDispatcher(path).forward(request, response);
  
%>






















