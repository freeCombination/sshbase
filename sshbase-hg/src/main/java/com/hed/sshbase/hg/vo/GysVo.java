package com.hed.sshbase.hg.vo;

import java.io.Serializable;

/**
 * 收发汇总VO
 */
public class GysVo implements Serializable{

	private static final long serialVersionUID = -1974128842955215182L;
	
	private Integer fitemId;
	private String fname;
	private String fnumber;
	private String faddress;
	
	public Integer getFitemId() {
		return fitemId;
	}
	public void setFitemId(Integer fitemId) {
		this.fitemId = fitemId;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getFnumber() {
		return fnumber;
	}
	public void setFnumber(String fnumber) {
		this.fnumber = fnumber;
	}
	public String getFaddress() {
		return faddress;
	}
	public void setFaddress(String faddress) {
		this.faddress = faddress;
	}
}
