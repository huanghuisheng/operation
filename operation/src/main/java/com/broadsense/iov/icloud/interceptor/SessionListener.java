package com.broadsense.iov.icloud.interceptor;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.broadsense.iov.icloud.controller.SpareController;



public class SessionListener implements HttpSessionListener {
	public void sessionCreated(HttpSessionEvent event) {
		HttpSession ses = event.getSession();
		String id = ses.getId() + ses.getCreationTime();
		System.out.println("session create" + event.getSession().getId());
		// SummerConstant.UserMap.put(id, Boolean.TRUE); //添加用户
	}

	public void sessionDestroyed(HttpSessionEvent event) {
		HttpSession ses = event.getSession();
		String id = ses.getId() + ses.getCreationTime();
		System.out.println("session destroy" + event.getSession().getId());
		List<String> list=SpareController.mapAll.get(event.getSession().getId());
		synchronized (this) {
			if (list != null || !("").equals(list)) {
				SpareController.mapAll.remove(event.getSession().getId());
			}

		}

	}
}
