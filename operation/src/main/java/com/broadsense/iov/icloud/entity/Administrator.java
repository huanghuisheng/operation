package com.broadsense.iov.icloud.entity;

import com.broadsense.iov.icloud.convert.JavaBean;

public class Administrator {
	
@JavaBean(dbfieldname="n_id")	
private int	adminId;

@JavaBean(dbfieldname="c_name")
private String	adminName;

@JavaBean(dbfieldname="c_password")
private String	adminPassword;

@JavaBean(dbfieldname="c_type")
private String	adminType;

@JavaBean(dbfieldname="c_group")
private String	adminGroup;

@JavaBean(dbfieldname="c_department")
private String	adminDepartment;

@JavaBean(dbfieldname="c_role")
private String	adminRole;

@JavaBean(dbfieldname="c_telephone")
private String	adminTelephone;

@JavaBean(dbfieldname="c_remark")
private String	adminRemark;

public int getAdminId() {
	return adminId;
}

public void setAdminId(int adminId) {
	this.adminId = adminId;
}

public String getAdminName() {
	return adminName;
}

public void setAdminName(String adminName) {
	this.adminName = adminName;
}

public String getAdminPassword() {
	return adminPassword;
}

public void setAdminPassword(String adminPassword) {
	this.adminPassword = adminPassword;
}

public String getAdminType() {
	return adminType;
}

public void setAdminType(String adminType) {
	this.adminType = adminType;
}

public String getAdminGroup() {
	return adminGroup;
}

public void setAdminGroup(String adminGroup) {
	this.adminGroup = adminGroup;
}

public String getAdminDepartment() {
	return adminDepartment;
}

public void setAdminDepartment(String adminDepartment) {
	this.adminDepartment = adminDepartment;
}

public String getAdminRole() {
	return adminRole;
}

public void setAdminRole(String adminRole) {
	this.adminRole = adminRole;
}

public String getAdminTelephone() {
	return adminTelephone;
}

public void setAdminTelephone(String adminTelephone) {
	this.adminTelephone = adminTelephone;
}

public String getAdminRemark() {
	return adminRemark;
}

public void setAdminRemark(String adminRemark) {
	this.adminRemark = adminRemark;
}

	
}
