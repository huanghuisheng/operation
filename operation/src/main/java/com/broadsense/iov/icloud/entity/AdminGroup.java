package com.broadsense.iov.icloud.entity;

import com.broadsense.iov.icloud.convert.JavaBean;

public class AdminGroup {
	
@JavaBean(dbfieldname="n_id")
private int	groupId;

@JavaBean(dbfieldname="c_group_name")
private String groupName;


@JavaBean(dbfieldname="c_imei")
private String groupImei;


public int getGroupId() {
	return groupId;
}


public void setGroupId(int groupId) {
	this.groupId = groupId;
}


public String getGroupName() {
	return groupName;
}


public void setGroupName(String groupName) {
	this.groupName = groupName;
}


public String getGroupImei() {
	return groupImei;
}


public void setGroupImei(String groupImei) {
	this.groupImei = groupImei;
}




}