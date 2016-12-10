package com.broadsense.iov.icloud.util;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class JsonFormat {
	private String state;
	private String msg;
	private List<Map<String, Object>> list;
	public static Map<String, Object> jsonDecode(String state, String msg, List<Map<String, Object>> list) {
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("state", state);
		listMap.put("msg", msg);
		listMap.put("result", list);
		return listMap;

	}

	public static Map<String, Object> jsonDecode1(List<Map<String, Object>> list, String successMsg, String errorMsg) {
		String state = null;
		String message = null;
		if (list.size() > 0) {
			state = "0";
			message = successMsg;
		} else {
			state = "1";
			message = errorMsg;
		}
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("state", state);
		listMap.put("msg", message);
		listMap.put("result", list);
		return listMap;
	}
	
	public static Map<String, Object> jsonDecode2(Object list, String successMsg, String errorMsg) {
		String state = null;
		String message = null;
		if (!list.equals("0")) {
			state = "0";
			message = successMsg;
		} else {
			state = "1";
			message = errorMsg;
		}
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("state", state);
		listMap.put("msg", message);
		listMap.put("result", list);
		return listMap;
	}

}
