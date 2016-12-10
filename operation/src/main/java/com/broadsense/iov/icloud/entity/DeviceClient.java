package com.broadsense.iov.icloud.entity;

import com.broadsense.iov.icloud.convert.JavaBean;

public class DeviceClient {
	
@JavaBean(dbfieldname="n_id")
private int	clientId;
@JavaBean(dbfieldname="c_client_name")
private String clientName;
@JavaBean(dbfieldname="c_imei")
private  String clientImei;
@JavaBean(dbfieldname="c_car_number")
private String carNumber;
@JavaBean(dbfieldname="c_remark")
private String clientRemark;

@JavaBean(dbfieldname="c_group")
private String imeiRroup;





public int getClientId() {
	return clientId;
}
public void setClientId(int clientId) {
	this.clientId = clientId;
}
public String getClientName() {
	return clientName;
}
public void setClientName(String clientName) {
	this.clientName = clientName;
}
public String getClientImei() {
	return clientImei;
}
public void setClientImei(String clientImei) {
	this.clientImei = clientImei;
}
public String getCarNumber() {
	return carNumber;
}
public void setCarNumber(String carNumber) {
	this.carNumber = carNumber;
}
public String getClientRemark() {
	return clientRemark;
}
public void setClientRemark(String clientRemark) {
	this.clientRemark = clientRemark;
}
public String getImeiRroup() {
	return imeiRroup;
}
public void setImeiRroup(String imeiRroup) {
	this.imeiRroup = imeiRroup;
}




}
