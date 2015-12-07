package com.hed.sshbase.hg.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 销售出库单VO
 */
public class SellBillsVo implements Serializable{

	private static final long serialVersionUID = -8358458975728084150L;
    
	// 产品代码 e
	private Integer finterId;
	// 日期 h
	private Date fdate;
	
	// 审核标志
	
	// 购货单位 h
	private Integer fsupplyId;
	// 发货仓库 h
	private Integer fdCStockId;
	
	private String fitemName;
	
	// 规格型号 e TODO 表体数据表不存在这个字段
	private String fitemModel;
	// 单位 e
	private Integer funitId;
	// 批号 e
	private String fbatchNo;
	// 实发数量 e
	private BigDecimal fauxqty;
	// 单位成本 e
	private BigDecimal fauxprice;
	// 成本 e
	private BigDecimal famount;
	// 部门 h
	private Integer fdeptId;
	// 业务员 h
	private Integer fempId;
	// 销售单价 e
	private BigDecimal fconsignPrice;
	// 销售金额 e
	private BigDecimal fconsignAmount;
	
	// 产品名称 e
	private String fname;
	// 产品长代码
	private String fnumber;
	private String deptName;
	private String userName;
	private String unit;
	private String ghcustom;
	private String stockName;
	// 单据编号
	private String fbillNo;
	
	public Integer getFinterId() {
		return finterId;
	}
	public void setFinterId(Integer finterId) {
		this.finterId = finterId;
	}
	public Date getFdate() {
		return fdate;
	}
	public void setFdate(Date fdate) {
		this.fdate = fdate;
	}
	public Integer getFsupplyId() {
		return fsupplyId;
	}
	public void setFsupplyId(Integer fsupplyId) {
		this.fsupplyId = fsupplyId;
	}
	public Integer getFdCStockId() {
		return fdCStockId;
	}
	public void setFdCStockId(Integer fdCStockId) {
		this.fdCStockId = fdCStockId;
	}
	public String getFitemName() {
		return fitemName;
	}
	public void setFitemName(String fitemName) {
		this.fitemName = fitemName;
	}
	public String getFitemModel() {
		return fitemModel;
	}
	public void setFitemModel(String fitemModel) {
		this.fitemModel = fitemModel;
	}
	public Integer getFunitId() {
		return funitId;
	}
	public void setFunitId(Integer funitId) {
		this.funitId = funitId;
	}
	public String getFbatchNo() {
		return fbatchNo;
	}
	public void setFbatchNo(String fbatchNo) {
		this.fbatchNo = fbatchNo;
	}
	public BigDecimal getFauxqty() {
		return fauxqty;
	}
	public void setFauxqty(BigDecimal fauxqty) {
		this.fauxqty = fauxqty;
	}
	public BigDecimal getFauxprice() {
		return fauxprice;
	}
	public void setFauxprice(BigDecimal fauxprice) {
		this.fauxprice = fauxprice;
	}
	public BigDecimal getFamount() {
		return famount;
	}
	public void setFamount(BigDecimal famount) {
		this.famount = famount;
	}
	public Integer getFdeptId() {
		return fdeptId;
	}
	public void setFdeptId(Integer fdeptId) {
		this.fdeptId = fdeptId;
	}
	public Integer getFempId() {
		return fempId;
	}
	public void setFempId(Integer fempId) {
		this.fempId = fempId;
	}
	public BigDecimal getFconsignPrice() {
		return fconsignPrice;
	}
	public void setFconsignPrice(BigDecimal fconsignPrice) {
		this.fconsignPrice = fconsignPrice;
	}
	public BigDecimal getFconsignAmount() {
		return fconsignAmount;
	}
	public void setFconsignAmount(BigDecimal fconsignAmount) {
		this.fconsignAmount = fconsignAmount;
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
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getGhcustom() {
		return ghcustom;
	}
	public void setGhcustom(String ghcustom) {
		this.ghcustom = ghcustom;
	}
	public String getStockName() {
		return stockName;
	}
	public void setStockName(String stockName) {
		this.stockName = stockName;
	}
	public String getFbillNo() {
		return fbillNo;
	}
	public void setFbillNo(String fbillNo) {
		this.fbillNo = fbillNo;
	}
	
}
