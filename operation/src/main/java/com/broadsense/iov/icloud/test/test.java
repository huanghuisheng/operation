package com.broadsense.iov.icloud.test;

import java.util.HashMap;
import java.util.Map;

import com.broadsense.iov.icloud.dao.BasicDao;

public class test {

	
	
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		BasicDao basicDao =new BasicDao();
		Map<String, Object> spareMap = new HashMap<String, Object>();
        //地区，备用机IMEI号，model，发货id
		spareMap.put("c_name", 1);
		
	    Object spareObject=basicDao.basicInsertData("iov_spare_log",spareMap);
		System.out.println("sssss----"+spareObject);
		
	}

}
