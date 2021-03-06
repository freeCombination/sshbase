package com.hed.sshbase.hg.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 销售出库单VO
 */
public class SellBillsVo implements Serializable{

	private static final long serialVersionUID = -8358458975728084150L;
    
	private Short ftranType;
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
	
	/*其他出库 *****************************/
	// 领料部门(deptName)
	// 数量(实发数量 fauxqty)
	// 单价(单位成本 fauxprice)
	// 金额(成本 famount)
	// 领料
	private Integer ffmanagerId;
	// 商品编码
	private Integer fitemId;
	// 商品名称(fitemName)
	// 商品类别
	private String fitemTypeName;
	// 商品品牌
	private String fcomBrandName;
	
	// 应出库数量(应发数量 fauxQtyMust)
	// 实出库数量(实发数量 fauxqty)
	
	/*外购入库*****************************/
	// 供应商
	private String fsupplyName;
	// 收料仓库(stockName)
	// 单价(fauxprice)
	// 应收数量
	// 实收数量(fauxqty)
	// 金额(famount)
	// 销售价格
	private String fentrySelfA0164;
	// 销售价金额
	private BigDecimal fentrySelfA0162;
	// 进销价差额
	private BigDecimal fentrySelfA0163;
	// 关联数量
	private BigDecimal fentrySelfA0165;
	// 是否关联完毕
	private Integer fentrySelfA0166;
	// 门店销售价
	
	/*其他入库*****************************/
	// 保管
	private String fsManagerName;
	
	/*调拨单*****************************/
	// 调出仓库
	private String fscStockName;
	// 调入仓库
	private String fdcStockName;
	
	/*实时库存*****************************/
	// 仓库代码
	private String stockNumber;
	// 基本单位数量
	private BigDecimal fqty;
	private BigDecimal fcostPrice;
	// 生产/采购日期
	private String fkfDateStr;
	
	/*零售单*****************************/
	// 单据类型
	private Character fbillType;
	// 分店
	private Integer fbranchShop;
	// 收银员
	private String fcashier;
	// POS机
	private Integer fpos;
	// 班次
	private String fshift;
	// 总金额
	private BigDecimal ftotalAmount;
	// 折扣金额
	private BigDecimal fdiscountAmount;
	// 实收金额
	private BigDecimal freceAmount;
	// 销售开始时间
	private String fbeginTime;
	// 销售结束时间
	private String fendTime;
	// 收款性质
	private Integer fcollectMode;
	// 客户名称
	private String customName;
	// 原价
	private BigDecimal fprice;
	// 实价
	private BigDecimal fdiscountPrice;
	// 实付金额
	private BigDecimal fbalAmount;
	// 商品打折率(折扣率(%))
	// 打折原因
	private Integer fdiscountReason;
	// 营业员(userName)
	// 结算方式
	private String fsettleName;
	// 结算金额
	private BigDecimal fsettleAmount;
	// 币别
	private String fcurrency;
	// 汇率
	private BigDecimal frate;
	// 卡类别
	private String fcardType;
	// 卡号码
	private String fcardNo;
	// 银行卡交易参考号
	private String freferenceNo;
	// 卡号
	private String fcardNumber;
	private BigDecimal famountxf;
	
	// 卡类型
	private String fcardTypeName;
	// 卡种类
	
	// 账户名称
	private Short faccount;
	// 子账户号
	private Integer faccountSubId;
	// 顾客姓名
	private String fcustomName;
	// 地址
	private String faddress;
	// 联系人
	private String flinkman;
	// 电话
	private String flinkTel;
	// 移动电话
	private String flinkPhone;
	// 顾客备注1
	private String freserve1;
	// 退货原因
	private String freserve2;
	// 纸质单号
	private String freserve3;
	
	
	private BigDecimal totalCount;
	private BigDecimal totalAmount;
	private BigDecimal totalAmountSs;
	
	/*********************出入监管准单***********************************/
	private String ftext;
	private String ftext1;
	private String ftext2;
	
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
	public Integer getFfmanagerId() {
		return ffmanagerId;
	}
	public void setFfmanagerId(Integer ffmanagerId) {
		this.ffmanagerId = ffmanagerId;
	}
	public Integer getFitemId() {
		return fitemId;
	}
	public void setFitemId(Integer fitemId) {
		this.fitemId = fitemId;
	}
	public String getFcomBrandName() {
		return fcomBrandName;
	}
	public void setFcomBrandName(String fcomBrandName) {
		this.fcomBrandName = fcomBrandName;
	}
	public Short getFtranType() {
		return ftranType;
	}
	public void setFtranType(Short ftranType) {
		this.ftranType = ftranType;
	}
	public String getFitemTypeName() {
		return fitemTypeName;
	}
	public void setFitemTypeName(String fitemTypeName) {
		this.fitemTypeName = fitemTypeName;
	}
	public String getFsupplyName() {
		return fsupplyName;
	}
	public void setFsupplyName(String fsupplyName) {
		this.fsupplyName = fsupplyName;
	}
	public String getFentrySelfA0164() {
		return fentrySelfA0164;
	}
	public void setFentrySelfA0164(String fentrySelfA0164) {
		this.fentrySelfA0164 = fentrySelfA0164;
	}
	public BigDecimal getFentrySelfA0162() {
		return fentrySelfA0162;
	}
	public void setFentrySelfA0162(BigDecimal fentrySelfA0162) {
		this.fentrySelfA0162 = fentrySelfA0162;
	}
	public BigDecimal getFentrySelfA0163() {
		return fentrySelfA0163;
	}
	public void setFentrySelfA0163(BigDecimal fentrySelfA0163) {
		this.fentrySelfA0163 = fentrySelfA0163;
	}
	public BigDecimal getFentrySelfA0165() {
		return fentrySelfA0165;
	}
	public void setFentrySelfA0165(BigDecimal fentrySelfA0165) {
		this.fentrySelfA0165 = fentrySelfA0165;
	}
	public Integer getFentrySelfA0166() {
		return fentrySelfA0166;
	}
	public void setFentrySelfA0166(Integer fentrySelfA0166) {
		this.fentrySelfA0166 = fentrySelfA0166;
	}
	public String getFsManagerName() {
		return fsManagerName;
	}
	public void setFsManagerName(String fsManagerName) {
		this.fsManagerName = fsManagerName;
	}
	public String getStockNumber() {
		return stockNumber;
	}
	public void setStockNumber(String stockNumber) {
		this.stockNumber = stockNumber;
	}
	public BigDecimal getFqty() {
		return fqty;
	}
	public void setFqty(BigDecimal fqty) {
		this.fqty = fqty;
	}
	public BigDecimal getFcostPrice() {
		return fcostPrice;
	}
	public void setFcostPrice(BigDecimal fcostPrice) {
		this.fcostPrice = fcostPrice;
	}
	public String getFkfDateStr() {
		return fkfDateStr;
	}
	public void setFkfDateStr(String fkfDateStr) {
		this.fkfDateStr = fkfDateStr;
	}
	public Character getFbillType() {
		return fbillType;
	}
	public void setFbillType(Character fbillType) {
		this.fbillType = fbillType;
	}
	public Integer getFbranchShop() {
		return fbranchShop;
	}
	public void setFbranchShop(Integer fbranchShop) {
		this.fbranchShop = fbranchShop;
	}
	public String getFcashier() {
		return fcashier;
	}
	public void setFcashier(String fcashier) {
		this.fcashier = fcashier;
	}
	public Integer getFpos() {
		return fpos;
	}
	public void setFpos(Integer fpos) {
		this.fpos = fpos;
	}
	public String getFshift() {
		return fshift;
	}
	public void setFshift(String fshift) {
		this.fshift = fshift;
	}
	public BigDecimal getFtotalAmount() {
		return ftotalAmount;
	}
	public void setFtotalAmount(BigDecimal ftotalAmount) {
		this.ftotalAmount = ftotalAmount;
	}
	public BigDecimal getFdiscountAmount() {
		return fdiscountAmount;
	}
	public void setFdiscountAmount(BigDecimal fdiscountAmount) {
		this.fdiscountAmount = fdiscountAmount;
	}
	public BigDecimal getFreceAmount() {
		return freceAmount;
	}
	public void setFreceAmount(BigDecimal freceAmount) {
		this.freceAmount = freceAmount;
	}
	public String getFbeginTime() {
		return fbeginTime;
	}
	public void setFbeginTime(String fbeginTime) {
		this.fbeginTime = fbeginTime;
	}
	public String getFendTime() {
		return fendTime;
	}
	public void setFendTime(String fendTime) {
		this.fendTime = fendTime;
	}
	public Integer getFcollectMode() {
		return fcollectMode;
	}
	public void setFcollectMode(Integer fcollectMode) {
		this.fcollectMode = fcollectMode;
	}
	public String getCustomName() {
		return customName;
	}
	public void setCustomName(String customName) {
		this.customName = customName;
	}
	public BigDecimal getFprice() {
		return fprice;
	}
	public void setFprice(BigDecimal fprice) {
		this.fprice = fprice;
	}
	public BigDecimal getFdiscountPrice() {
		return fdiscountPrice;
	}
	public void setFdiscountPrice(BigDecimal fdiscountPrice) {
		this.fdiscountPrice = fdiscountPrice;
	}
	public BigDecimal getFbalAmount() {
		return fbalAmount;
	}
	public void setFbalAmount(BigDecimal fbalAmount) {
		this.fbalAmount = fbalAmount;
	}
	public Integer getFdiscountReason() {
		return fdiscountReason;
	}
	public void setFdiscountReason(Integer fdiscountReason) {
		this.fdiscountReason = fdiscountReason;
	}
	public String getFsettleName() {
		return fsettleName;
	}
	public void setFsettleName(String fsettleName) {
		this.fsettleName = fsettleName;
	}
	public BigDecimal getFsettleAmount() {
		return fsettleAmount;
	}
	public void setFsettleAmount(BigDecimal fsettleAmount) {
		this.fsettleAmount = fsettleAmount;
	}
	public String getFcurrency() {
		return fcurrency;
	}
	public void setFcurrency(String fcurrency) {
		this.fcurrency = fcurrency;
	}
	public BigDecimal getFrate() {
		return frate;
	}
	public void setFrate(BigDecimal frate) {
		this.frate = frate;
	}
	public String getFcardType() {
		return fcardType;
	}
	public void setFcardType(String fcardType) {
		this.fcardType = fcardType;
	}
	public String getFcardNo() {
		return fcardNo;
	}
	public void setFcardNo(String fcardNo) {
		this.fcardNo = fcardNo;
	}
	public String getFreferenceNo() {
		return freferenceNo;
	}
	public void setFreferenceNo(String freferenceNo) {
		this.freferenceNo = freferenceNo;
	}
	public String getFcardNumber() {
		return fcardNumber;
	}
	public void setFcardNumber(String fcardNumber) {
		this.fcardNumber = fcardNumber;
	}
	public BigDecimal getFamountxf() {
		return famountxf;
	}
	public void setFamountxf(BigDecimal famountxf) {
		this.famountxf = famountxf;
	}
	public String getFcardTypeName() {
		return fcardTypeName;
	}
	public void setFcardTypeName(String fcardTypeName) {
		this.fcardTypeName = fcardTypeName;
	}
	public Short getFaccount() {
		return faccount;
	}
	public void setFaccount(Short faccount) {
		this.faccount = faccount;
	}
	public Integer getFaccountSubId() {
		return faccountSubId;
	}
	public void setFaccountSubId(Integer faccountSubId) {
		this.faccountSubId = faccountSubId;
	}
	public String getFcustomName() {
		return fcustomName;
	}
	public void setFcustomName(String fcustomName) {
		this.fcustomName = fcustomName;
	}
	public String getFaddress() {
		return faddress;
	}
	public void setFaddress(String faddress) {
		this.faddress = faddress;
	}
	public String getFlinkman() {
		return flinkman;
	}
	public void setFlinkman(String flinkman) {
		this.flinkman = flinkman;
	}
	public String getFlinkTel() {
		return flinkTel;
	}
	public void setFlinkTel(String flinkTel) {
		this.flinkTel = flinkTel;
	}
	public String getFlinkPhone() {
		return flinkPhone;
	}
	public void setFlinkPhone(String flinkPhone) {
		this.flinkPhone = flinkPhone;
	}
	public String getFreserve1() {
		return freserve1;
	}
	public void setFreserve1(String freserve1) {
		this.freserve1 = freserve1;
	}
	public String getFreserve2() {
		return freserve2;
	}
	public void setFreserve2(String freserve2) {
		this.freserve2 = freserve2;
	}
	public String getFreserve3() {
		return freserve3;
	}
	public void setFreserve3(String freserve3) {
		this.freserve3 = freserve3;
	}
	public String getFscStockName() {
		return fscStockName;
	}
	public void setFscStockName(String fscStockName) {
		this.fscStockName = fscStockName;
	}
	public String getFdcStockName() {
		return fdcStockName;
	}
	public void setFdcStockName(String fdcStockName) {
		this.fdcStockName = fdcStockName;
	}
	public BigDecimal getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(BigDecimal totalCount) {
		this.totalCount = totalCount;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	public String getFtext() {
		return ftext;
	}
	public void setFtext(String ftext) {
		this.ftext = ftext;
	}
	public String getFtext1() {
		return ftext1;
	}
	public void setFtext1(String ftext1) {
		this.ftext1 = ftext1;
	}
	public String getFtext2() {
		return ftext2;
	}
	public void setFtext2(String ftext2) {
		this.ftext2 = ftext2;
	}
	public BigDecimal getTotalAmountSs() {
		return totalAmountSs;
	}
	public void setTotalAmountSs(BigDecimal totalAmountSs) {
		this.totalAmountSs = totalAmountSs;
	}
	
}
