package com.hed.sshbase.hg.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 销售出库单VO
 */
public class SellBillsVo implements Serializable{

	private static final long serialVersionUID = -8358458975728084150L;
    
	private Integer finterId;
	// 日期 h
	private Date fdate;
	
	// 审核标志
	private String fcheckFlag;
	// 购货单位 h
	private Integer fsupplyId;
	// 发货仓库 h
	private Integer fdCStockId;
	
	private String fitemName;
	
	// 规格型号 
	private String fmodel;
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
	// 条形码
	private String fbarCode;
	
	// 产品代码
	private String fshortNumber;
	// 辅助属性
	
	// 应发数量
	private BigDecimal fauxQtyMust;
	// 辅助单位
	private String fsecUnitName;
	// 换算率
	private BigDecimal fsecCoefficient;
	// 辅助数量
	private BigDecimal fsecQty;
	// 计划单价
	private BigDecimal fauxPlanPrice;
	// 计划价金额
	private BigDecimal fplanAmount;
	// 备注
	private String fnote;
	// 生产/采购日期
	private Date fkfDate;
	// 保质期(天)
	private Integer fkfPeriod;
	// 有效期至
	private Date fperiodDate;
	// 仓位
	
	// 折扣率(%)
	private BigDecimal fdiscountRate;
	// 源单单号
	private String fsourceBillNo;
	// 合同单号
	private String fcontractBillNo;
	// 订单单号
	private String forderBillNo;
	// 订单分录
	private Integer forderEntryId;
	// 辅助单位开票数量
	private BigDecimal fsecInvoiceQty;
	// 开票数量
	private BigDecimal fauxQtyInvoice;
	// 客户订单号
	private String fclientOrderNo;
	// 对账确认意见(表体)
	private String fconfirmMemEntry;
	// 订单行号
	private Integer fclientEntryId;
	// 检验是否良品
	private Integer fchkPassItem;
	// 收款日期
	private Date fsettleDate;
	// 交货地点
	private String ffetchAdd;
	// 整单折扣率
	private BigDecimal fholisticDiscountRate;
	// 销售方式
	private Integer fsaleStyle;
	// 摘要
	private String fexplanation;
	// 源单类型
	private Integer fselTranType;
	
	
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
	public String getFmodel() {
		return fmodel;
	}
	public void setFmodel(String fmodel) {
		this.fmodel = fmodel;
	}
	public String getFcheckFlag() {
		return fcheckFlag;
	}
	public void setFcheckFlag(String fcheckFlag) {
		this.fcheckFlag = fcheckFlag;
	}
	public String getFbarCode() {
		return fbarCode;
	}
	public void setFbarCode(String fbarCode) {
		this.fbarCode = fbarCode;
	}
	public String getFshortNumber() {
		return fshortNumber;
	}
	public void setFshortNumber(String fshortNumber) {
		this.fshortNumber = fshortNumber;
	}
	public BigDecimal getFauxQtyMust() {
		return fauxQtyMust;
	}
	public void setFauxQtyMust(BigDecimal fauxQtyMust) {
		this.fauxQtyMust = fauxQtyMust;
	}
	public BigDecimal getFsecCoefficient() {
		return fsecCoefficient;
	}
	public void setFsecCoefficient(BigDecimal fsecCoefficient) {
		this.fsecCoefficient = fsecCoefficient;
	}
	public BigDecimal getFsecQty() {
		return fsecQty;
	}
	public void setFsecQty(BigDecimal fsecQty) {
		this.fsecQty = fsecQty;
	}
	public BigDecimal getFauxPlanPrice() {
		return fauxPlanPrice;
	}
	public void setFauxPlanPrice(BigDecimal fauxPlanPrice) {
		this.fauxPlanPrice = fauxPlanPrice;
	}
	public BigDecimal getFplanAmount() {
		return fplanAmount;
	}
	public void setFplanAmount(BigDecimal fplanAmount) {
		this.fplanAmount = fplanAmount;
	}
	public String getFnote() {
		return fnote;
	}
	public void setFnote(String fnote) {
		this.fnote = fnote;
	}
	public Date getFkfDate() {
		return fkfDate;
	}
	public void setFkfDate(Date fkfDate) {
		this.fkfDate = fkfDate;
	}
	public Integer getFkfPeriod() {
		return fkfPeriod;
	}
	public void setFkfPeriod(Integer fkfPeriod) {
		this.fkfPeriod = fkfPeriod;
	}
	public Date getFperiodDate() {
		return fperiodDate;
	}
	public void setFperiodDate(Date fperiodDate) {
		this.fperiodDate = fperiodDate;
	}
	public BigDecimal getFdiscountRate() {
		return fdiscountRate;
	}
	public void setFdiscountRate(BigDecimal fdiscountRate) {
		this.fdiscountRate = fdiscountRate;
	}
	public String getFsourceBillNo() {
		return fsourceBillNo;
	}
	public void setFsourceBillNo(String fsourceBillNo) {
		this.fsourceBillNo = fsourceBillNo;
	}
	public String getFcontractBillNo() {
		return fcontractBillNo;
	}
	public void setFcontractBillNo(String fcontractBillNo) {
		this.fcontractBillNo = fcontractBillNo;
	}
	public String getForderBillNo() {
		return forderBillNo;
	}
	public void setForderBillNo(String forderBillNo) {
		this.forderBillNo = forderBillNo;
	}
	public Integer getForderEntryId() {
		return forderEntryId;
	}
	public void setForderEntryId(Integer forderEntryId) {
		this.forderEntryId = forderEntryId;
	}
	public BigDecimal getFsecInvoiceQty() {
		return fsecInvoiceQty;
	}
	public void setFsecInvoiceQty(BigDecimal fsecInvoiceQty) {
		this.fsecInvoiceQty = fsecInvoiceQty;
	}
	public BigDecimal getFauxQtyInvoice() {
		return fauxQtyInvoice;
	}
	public void setFauxQtyInvoice(BigDecimal fauxQtyInvoice) {
		this.fauxQtyInvoice = fauxQtyInvoice;
	}
	public String getFclientOrderNo() {
		return fclientOrderNo;
	}
	public void setFclientOrderNo(String fclientOrderNo) {
		this.fclientOrderNo = fclientOrderNo;
	}
	public String getFconfirmMemEntry() {
		return fconfirmMemEntry;
	}
	public void setFconfirmMemEntry(String fconfirmMemEntry) {
		this.fconfirmMemEntry = fconfirmMemEntry;
	}
	public Integer getFclientEntryId() {
		return fclientEntryId;
	}
	public void setFclientEntryId(Integer fclientEntryId) {
		this.fclientEntryId = fclientEntryId;
	}
	public Integer getFchkPassItem() {
		return fchkPassItem;
	}
	public void setFchkPassItem(Integer fchkPassItem) {
		this.fchkPassItem = fchkPassItem;
	}
	public String getFsecUnitName() {
		return fsecUnitName;
	}
	public void setFsecUnitName(String fsecUnitName) {
		this.fsecUnitName = fsecUnitName;
	}
	public Date getFsettleDate() {
		return fsettleDate;
	}
	public void setFsettleDate(Date fsettleDate) {
		this.fsettleDate = fsettleDate;
	}
	public String getFfetchAdd() {
		return ffetchAdd;
	}
	public void setFfetchAdd(String ffetchAdd) {
		this.ffetchAdd = ffetchAdd;
	}
	public BigDecimal getFholisticDiscountRate() {
		return fholisticDiscountRate;
	}
	public void setFholisticDiscountRate(BigDecimal fholisticDiscountRate) {
		this.fholisticDiscountRate = fholisticDiscountRate;
	}
	public Integer getFsaleStyle() {
		return fsaleStyle;
	}
	public void setFsaleStyle(Integer fsaleStyle) {
		this.fsaleStyle = fsaleStyle;
	}
	public String getFexplanation() {
		return fexplanation;
	}
	public void setFexplanation(String fexplanation) {
		this.fexplanation = fexplanation;
	}
	public Integer getFselTranType() {
		return fselTranType;
	}
	public void setFselTranType(Integer fselTranType) {
		this.fselTranType = fselTranType;
	}
	
}
