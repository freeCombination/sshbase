package com.hed.sshbase.hg.service.impl;

import java.math.BigDecimal;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.classic.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import com.hed.sshbase.common.dao.IBaseDao2;
import com.hed.sshbase.common.util.DateUtil;
import com.hed.sshbase.common.util.StringUtil;
import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.service.IDataMonitorService;
import com.hed.sshbase.hg.vo.GysVo;
import com.hed.sshbase.hg.vo.SellBillsVo;
import com.hed.sshbase.hg.vo.TransSummaryVo;

/**
 * 数据监控Service
 */
@Service("monitorService")
public class DataMonitorServiceImpl implements IDataMonitorService {

	@Autowired
    @Qualifier("baseDao2")
    private IBaseDao2 baseDao2;
	
	@Override
	public ListVo<SellBillsVo> getSellDeliveryBills(Map<String, String> paramMap) throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        String startDate = paramMap.get("startDate");
        String endDate = paramMap.get("endDate");
        String billsType = paramMap.get("billsType");
        String fnumberStart = paramMap.get("fnumberStart");
        String fnumberEnd = paramMap.get("fnumberEnd");
        
        String queryDate = paramMap.get("queryDate");
        String fbillNo = paramMap.get("fbillNo");
        String gysId = paramMap.get("gysId");
        String purchaseUnitId = paramMap.get("purchaseUnitId");
        String dcckNo = paramMap.get("dcckNo");
        
        String billsId = paramMap.get("billsId");
        String forDetail = paramMap.get("forDetail");
		
		String sql = " SELECT "
				+ " t1.FTranType ftranType,"
				+ " t2.FInterID finterId, t1.Fdate fdate, t1.FSupplyID fsupplyId, t1.FDCStockID fdCStockId, "
				+ " t2.FItemName fitemName, t2.FUnitID funitId, t2.FBatchNo fbatchNo,"
				+ " t2.Fauxqty fauxqty, t2.Fauxprice fauxprice, t2.Famount famount, t1.FDeptID fdeptId, "
				+ " t1.FEmpID fempId, t2.FConsignPrice fconsignPrice, t2.FConsignAmount fconsignAmount, "
				+ " t9.FName fname, t9.FNumber fnumber, t4.FName deptName, t5.FName userName, t6.FName unit, "
				+ " t7.FName ghcustom, t8.FName stockName, t1.FBillNo fbillNo, t9.FModel fmodel, t2.FBarCode fbarCode, "
				+ " t9.FShortNumber fshortNumber, t2.FAuxQtyMust fauxQtyMust, "
				+ " t2.FSecCoefficient fsecCoefficient, t2.FSecQty fsecQty, t2.FAuxPlanPrice fauxPlanPrice, "
				+ " t2.FPlanAmount fplanAmount, t2.Fnote fnote, t2.FKFDate fkfDate, t2.FKFPeriod fkfPeriod, "
				+ " t2.FPeriodDate fperiodDate, t2.FDiscountRate fdiscountRate, t2.FSourceBillNo fsourceBillNo, "
				+ " t2.FContractBillNo fcontractBillNo, t2.FOrderBillNo forderBillNo, t2.FOrderEntryID forderEntryId, "
				+ " t2.FSecInvoiceQty fsecInvoiceQty, t2.FAuxQtyInvoice fauxQtyInvoice, t2.FClientOrderNo fclientOrderNo, "
				+ " t2.FConfirmMemEntry fconfirmMemEntry, t2.FClientEntryID fclientEntryId, t2.FChkPassItem fchkPassItem, "
				+ " t1.FSettleDate fsettleDate, t1.FFetchAdd ffetchAdd, t1.FHolisticDiscountRate fholisticDiscountRate, "
				+ " t1.FSaleStyle fsaleStyle, t1.FExplanation fexplanation, t1.FSelTranType fselTranType, "
				+ " t1.FFManagerID ffmanagerId, t2.FItemID fitemId, t11.FName fsupplyName, t12.FName fitemTypeName, "
				+ " t13.FName fcomBrandName, t2.FEntrySelfA0164 fentrySelfA0164, t2.FEntrySelfA0162 fentrySelfA0162, "
				+ " t2.FEntrySelfA0163 fentrySelfA0163, t2.FEntrySelfA0165 fentrySelfA0165, t2.FEntrySelfA0166 fentrySelfA0166, "
				+ " t14.FName fsManagerName, t15.FName fscStockName, t16.FName fdcStockName ";
		
		String countSql = " SELECT count(*)";
		String totalSql = " SELECT SUM(ISNULL(t2.Fauxqty, 0)) tc, SUM(ISNULL(t2.FConsignAmount, 0)) ta";
		String commonSql = " FROM ICStockBill t1 LEFT JOIN ICStockBillEntry t2 "
				+ " ON t1.FInterID=t2.FInterID "
				+ " LEFT JOIN t_Department t4 ON t4.FItemID = t1.FDeptID"
				+ " LEFT JOIN t_Emp t5 ON t5.FItemID = t1.FEmpID"
				+ " LEFT JOIN t_MeasureUnit t6 ON t6.FItemID = t2.FUnitID"
				+ " LEFT JOIN t_Organization t7 ON t7.FItemID = t1.FSupplyID"
				+ " LEFT JOIN t_Stock t8 ON t8.FItemID = t1.FDCStockID"
				+ " LEFT JOIN t_ICItem t9 ON t9.FItemID = t2.FItemID"
				+ " LEFT JOIN t_Supplier t11 ON t11.FItemID = t1.FSupplyID"
				+ " LEFT JOIN t_ComCategory t12 ON t12.FItemID = t2.FComCategoryID"
				+ " LEFT JOIN t_ComBrand t13 ON t13.FItemID =  t2.FComBrandID"
				+ " LEFT JOIN t_Emp t14 ON t14.FItemID = t1.FSManagerID"
				+ " LEFT JOIN t_Stock t15 ON t15.FItemID = t2.FSCStockID"
				+ " LEFT JOIN t_Stock t16 ON t16.FItemID = t2.FDCStockID"
				+ " WHERE t9.FNumber like '1.%' and t1.FTranType in (1, 21, 41)";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(billsType) && !"-1".equals(billsType)) {
				commonSql += " and t1.FTranType=" + billsType;
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
			
			if (StringUtil.isNotBlank(fnumberStart) && StringUtil.isNotBlank(fnumberEnd)) {
				if (fnumberStart.compareTo(fnumberEnd) < 0) {
					String temp = fnumberStart;
					fnumberStart = fnumberEnd;
					fnumberEnd = temp;
				}
			}
			
			if (StringUtil.isNotBlank(fnumberStart)) {
				commonSql += " and t9.FNumber >= '" + fnumberStart + "'";
			}
			
			if (StringUtil.isNotBlank(fnumberEnd)) {
				commonSql += " and t9.FNumber <= '" + fnumberEnd + "'";
			}
			
			if (StringUtil.isNotBlank(queryDate)) {
				commonSql += " and t1.Fdate=convert(datetime,'" + queryDate + "')";
			}
			
			if (StringUtil.isNotBlank(fbillNo)) {
				commonSql += " and t1.FBillNo like '%" + fbillNo + "%'";
			}
			
			if (StringUtil.isNotBlank(purchaseUnitId) && !"-1".equals(purchaseUnitId)) {
				commonSql += " and t7.FItemID = " + purchaseUnitId;
			}
			
			if (StringUtil.isNotBlank(gysId) && !"-1".equals(gysId)) {
				commonSql += " and t11.FItemID = " + gysId;
			}
			
			if (StringUtil.isNotBlank(dcckNo) && !"-1".equals(dcckNo)) {
				commonSql += " and t15.FNumber ='" + dcckNo + "'";
			}
		}
		
		List<Object[]> totalCountLst = (List<Object[]>)baseDao2.executeNativeQuery(totalSql + commonSql);
		BigDecimal totalCount = new BigDecimal(0);
		BigDecimal totalAmount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalCountLst)) {
			totalCount = (BigDecimal)totalCountLst.get(0)[0];
			totalAmount = (BigDecimal)totalCountLst.get(0)[1];
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		commonSql += " order by t1.Fdate desc";
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		if (!CollectionUtils.isEmpty(lst)) {
			SellBillsVo vo = lst.get(0);
			vo.setTotalCount(totalCount);
			vo.setTotalAmount(totalAmount);
		}
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}

	@Override
	public ListVo<SellBillsVo> getInventory(Map<String, String> paramMap)  throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String stockNumber = paramMap.get("stockNumber");
        String showZero = paramMap.get("showZero");
        String fnumberStart = paramMap.get("fnumberStart");
        String fnumberEnd = paramMap.get("fnumberEnd");
		
		String sql = " SELECT "
				+ " t2.FNumber fnumber, t2.FName fname, t3.FModel fmodel, t4.FName stockName, "
				+ " t4.FNumber stockNumber, t1.FKFDate fkfDateStr, t1.FKFPeriod fkfPeriod, t5.FName unit,"
				+ " t1.FQty fqty, t1.FCostPrice fcostPrice";
		// 分页总条数
		String countSql = " SELECT count(*)";
		// 统计基本单位数量
		String totalCountSql = " SELECT SUM(ISNULL(t1.FQty, 0))";
		
		String commonSql = " FROM ICInventory t1 "
				+ " LEFT JOIN t_Item t2 ON t2.FItemID = t1.FItemID "
				+ " LEFT JOIN t_ICItem t3 ON t3.FItemID = t1.FItemID"
				+ " LEFT JOIN t_Stock t4 ON t4.FItemID = t1.FStockID"
				+ " LEFT JOIN t_MeasureUnit t5 ON t5.FItemID = t3.FUnitID"
				+ " WHERE t2.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(stockNumber)) {
			commonSql += " and t4.FNumber='" + stockNumber + "'";
		}
		else {
			commonSql += " and t4.FNumber in ('001', '110', '111')";
		}
		
		if (StringUtil.isBlank(showZero) || !"true".equals(showZero)) {
			commonSql += " and t1.FQty > 0 ";
		}
		
		if (StringUtil.isNotBlank(fnumberStart) && StringUtil.isNotBlank(fnumberEnd)) {
			if (fnumberStart.compareTo(fnumberEnd) < 0) {
				String temp = fnumberStart;
				fnumberStart = fnumberEnd;
				fnumberEnd = temp;
			}
		}
		
		if (StringUtil.isNotBlank(fnumberStart)) {
			commonSql += " and t2.FNumber >= '" + fnumberStart + "'";
		}
		
		if (StringUtil.isNotBlank(fnumberEnd)) {
			commonSql += " and t2.FNumber <= '" + fnumberEnd + "'";
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		List<Object> totalCountLst = (List<Object>)baseDao2.executeNativeQuery(totalCountSql + commonSql);
		BigDecimal totalCount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalCountLst)) {
			totalCount = (BigDecimal)totalCountLst.get(0);
		}
		
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		if (!CollectionUtils.isEmpty(lst)) {
			SellBillsVo vo = lst.get(0);
			vo.setTotalCount(totalCount);
		}
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
	
	@Override
	public ListVo<SellBillsVo> getRetail(Map<String, String> paramMap)  throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String startDate = paramMap.get("startDate");
        String endDate = paramMap.get("endDate");
        String billsId = paramMap.get("billsId");
        String forDetail = paramMap.get("forDetail");
        String fbillNo = paramMap.get("fbillNo");
		
		String sql = " SELECT "
				+ " t1.FBillNO fbillNo, t1.FDate fdate, t1.FBillType fbillType, t1.FBranchShop fbranchShop, t8.FName fcashier, "
				+ " t1.FPOS fpos, t1.FTotalAmount ftotalAmount, t1.FDiscountAmount fdiscountAmount, "
				+ " t1.FReceAmount freceAmount, convert(varchar(19), t1.FBeginTime, 20) fbeginTime, "
				+ " convert(varchar(19), t1.FEndTime, 20) fendTime, t1.FCollectMode fcollectMode, "
				+ " t12.FName fsettleName, "
				+ " t10.FSettleAmount fsettleAmount, t10.FAmount famountxf, t11.FName fcurrency, t10.FRate frate, "
				+ " t10.FCardType fcardType, t10.FCardNO fcardNo, t10.FReferenceNO freferenceNo, "
				+ " t15.FCustomName fcustomName, "
				+ " t15.FAddress faddress, t15.FLinkman flinkman, t15.FLinkTel flinkTel, t15.FLinkPhone flinkPhone, "
				+ " t15.FReserve1 freserve1, t15.FReserve2 freserve2, t15.FReserve3 freserve3 ";
		
		String countSql = " SELECT count(*)";
		//String totalAmountSql = " SELECT SUM(ISNULL(t1.FTotalAmount, 0)) total, SUM(ISNULL(t1.FReceAmount, 0)) totalSs";
		String tempSql1 = " SELECT tt1.FID, max(tt2.FSettleAmount) FSettleAmount, MAX(tt2.FSettleID) FSettleID, "
				+ " max(tt2.FAmount) FAmount, max(tt2.FRate) FRate, MAX(tt2.FCurrency) FCurrency, "
				+ " max(tt2.FCardType) FCardType, max(tt2.FCardNO) FCardNO, max(tt2.FReferenceNO) FReferenceNO"
				+ " FROM T_LS_Retail tt1 "
				+ " LEFT JOIN t_LS_RetailEntry2 tt2 ON tt2.FID = tt1.FID "
				+ " where 1 = 1";
		String tempSql2 = " SELECT tt1.FID, max(tt2.FCustomName) FCustomName, "
				+ " max(tt2.FAddress) FAddress, max(tt2.FLinkman) FLinkman, "
				+ " max(tt2.FLinkTel) FLinkTel, max(tt2.FLinkPhone) FLinkPhone, max(tt2.FReserve1) FReserve1,"
				+ " max(tt2.FReserve2) FReserve2, max(tt2.FReserve3) FReserve3"
				+ " FROM T_LS_Retail tt1 "
				+ " LEFT JOIN t_LS_Custom tt2 ON tt2.FID = tt1.FID "
				+ " where 1 = 1";
		String tempSql3 = " SELECT tt1.FID "
				+ " FROM T_LS_Retail tt1 "
				+ " LEFT JOIN T_LS_RetailEntry tt3 ON tt3.FID = tt1.FID "
				+ " LEFT JOIN t_Item tt5 ON tt5.FItemID = tt3.FItemID "
				+ " WHERE tt5.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			tempSql1 += " and tt1.FBillNo='" + billsId + "'";
			tempSql2 += " and tt1.FBillNo='" + billsId + "'";
			tempSql3 += " and tt1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(fbillNo)) {
				tempSql1 += " and tt1.FBillNo like '%" + fbillNo + "%'";
				tempSql2 += " and tt1.FBillNo like '%" + fbillNo + "%'";
				tempSql3 += " and tt1.FBillNo like '%" + fbillNo + "%'";
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				tempSql1 += " and tt1.Fdate>=convert(datetime,'" + startDate + "')";
				tempSql2 += " and tt1.Fdate>=convert(datetime,'" + startDate + "')";
				tempSql3 += " and tt1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				tempSql1 += " and tt1.Fdate<=convert(datetime,'" + endDate + "')";
				tempSql2 += " and tt1.Fdate<=convert(datetime,'" + endDate + "')";
				tempSql3 += " and tt1.Fdate<=convert(datetime,'" + endDate + "')";
			}
		}
		
		tempSql1 += " group by tt1.FID";
		tempSql2 += " group by tt1.FID";
		tempSql3 += " group by tt1.FID";
		
		String commonSql = " FROM T_LS_Retail t1 "
				+ " LEFT JOIN t_Emp t8 ON t8.FItemID = t1.FCashier"
				+ " LEFT JOIN (" + tempSql1 + ") t10 ON t10.FID = t1.FID"
				+ " LEFT JOIN vw_LS_Currency t11 ON t11.FID = t10.FCurrency"
				+ " LEFT JOIN t_LS_Settle t12 ON t12.FID = t10.FSettleID"
				+ " LEFT JOIN (" + tempSql2 + ") t15 ON t15.FID = t1.FID"
				+ " INNER JOIN (" + tempSql3 + ") t16 ON t16.FID = t1.FID"
				+ " WHERE 1 = 1 ";
		
		/*String totalCountSql = " SELECT SUM(ISNULL(t3.FQty, 0))"
				+ " FROM T_LS_Retail t1 "
				+ " LEFT JOIN T_LS_RetailEntry t3 ON t3.FID = t1.FID"
				+ " LEFT JOIN t_Item t5 ON t5.FItemID = t3.FItemID"
				+ " WHERE t5.FNumber like '1.%' ";*/
		
		String totalCountSql1 = " SELECT SUM(ISNULL(t2.Fauxqty, 0)) tc, SUM(ISNULL(t2.FConsignAmount, 0)) ta"
				+ " FROM ICStockBill t1 "
				+ " LEFT JOIN ICStockBillEntry t2  ON t1.FInterID=t2.FInterID "
				+ " LEFT JOIN t_ICItem t9 ON t9.FItemID = t2.FItemID "
				+ " WHERE t9.FNumber like '1.%' "
				+ " and t1.FTranType=21 ";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
			//totalCountSql += " and t1.FBillNo='" + billsId + "'";
			totalCountSql1 += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(fbillNo)) {
				commonSql += " and t1.FBillNo like '%" + fbillNo + "%'";
				//totalCountSql += " and t1.FBillNo like '%" + fbillNo + "%'";
				totalCountSql1 += " and t1.FBillNo like '%" + fbillNo + "%'";
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
				//totalCountSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
				totalCountSql1 += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
				//totalCountSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
				totalCountSql1 += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
		}
		
		List<Object> totalCountLst = (List<Object>)baseDao2.executeNativeQuery(totalCountSql1);
		BigDecimal totalCount = new BigDecimal(0);
		BigDecimal totalAmount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalCountLst)) {
			totalCount = (BigDecimal)((Object[])totalCountLst.get(0))[0];
			totalAmount = (BigDecimal)((Object[])totalCountLst.get(0))[1];
		}
		
		/*List<Object> totalAmoutLst = (List<Object>)baseDao2.executeNativeQuery(totalAmountSql + commonSql);
		BigDecimal totalAmount = new BigDecimal(0);
		BigDecimal totalAmountSs = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalAmoutLst)) {
			totalAmount = (BigDecimal)((Object[])totalAmoutLst.get(0))[0];
			totalAmountSs = (BigDecimal)((Object[])totalAmoutLst.get(0))[1];
		}*/
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		commonSql += "order by t1.Fdate desc";
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		if (!CollectionUtils.isEmpty(lst)) {
			SellBillsVo vo = lst.get(0);
			vo.setTotalCount(totalCount);
			vo.setTotalAmount(totalAmount);
			//vo.setTotalAmountSs(totalAmountSs);
		}
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
	
	@Override
	public ListVo<SellBillsVo> getRetailGoods(Map<String, String> paramMap)  throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String billsId = paramMap.get("billsId");
		
		String sql = " SELECT "
				+ " t1.FBillNO fbillNo, t1.FDate fdate, t1.FBillType fbillType, t1.FBranchShop fbranchShop, t8.FName fcashier, "
				+ " t1.FPOS fpos, t1.FTotalAmount ftotalAmount, t1.FDiscountAmount fdiscountAmount, "
				+ " t1.FReceAmount freceAmount, convert(varchar(19), t1.FBeginTime, 20) fbeginTime, "
				+ " convert(varchar(19), t1.FEndTime, 20) fendTime, t1.FCollectMode fcollectMode, "
				+ " t4.FName stockName, t5.FName fname, t5.FNumber fnumber, t3.FBarcode fbarCode, "
				+ " t6.FName unit, t3.FQty fqty, t3.FPrice fprice, t3.FDiscountPrice fdiscountPrice, t3.FAmount famount,"
				+ " t3.FBalAmount fbalAmount, t3.FDiscountRate fdiscountRate, t3.FDiscountReason fdiscountReason, t7.FName userName, "
				+ " t3.FBatchNO fbatchNo, t3.FKFDate fkfDateStr, t3.FKFPeriod fkfPeriod ";
		
		String countSql = " SELECT count(*)";
		String commonSql = " FROM T_LS_Retail t1 "
				+ " LEFT JOIN T_LS_RetailEntry t3 ON t3.FID = t1.FID"
				+ " LEFT JOIN t_Stock t4 ON t4.FItemID = t3.FStock"
				+ " LEFT JOIN t_Item t5 ON t5.FItemID = t3.FItemID"
				+ " LEFT JOIN t_MeasureUnit t6 ON t6.FItemID = t3.FSaleUnitID"
				+ " LEFT JOIN t_Emp t7 ON t7.FItemID = t3.FSalesMan"
				+ " LEFT JOIN t_Emp t8 ON t8.FItemID = t1.FCashier"
				+ " WHERE t5.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
	
	@Override
	public ListVo<SellBillsVo> getRetailSettleType(Map<String, String> paramMap)  throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String startDate = paramMap.get("startDate");
        String endDate = paramMap.get("endDate");
        String billsId = paramMap.get("billsId");
        String forDetail = paramMap.get("forDetail");
        String fbillNo = paramMap.get("fbillNo");
		
		String sql = " SELECT "
				+ " t1.FBillNO fbillNo, t1.FDate fdate, t1.FBillType fbillType, t1.FBranchShop fbranchShop, t8.FName fcashier, "
				+ " t1.FPOS fpos, t1.FTotalAmount ftotalAmount, t1.FDiscountAmount fdiscountAmount, "
				+ " t1.FReceAmount freceAmount, convert(varchar(19), t1.FBeginTime, 20) fbeginTime, "
				+ " convert(varchar(19), t1.FEndTime, 20) fendTime, t1.FCollectMode fcollectMode, "
				+ " t12.FName fsettleName, "
				+ " t10.FSettleAmount fsettleAmount, t10.FAmount famountxf, t11.FName fcurrency, t10.FRate frate, "
				+ " t10.FCardType fcardType, t10.FCardNO fcardNo, t10.FReferenceNO freferenceNo, "
				+ " t15.FCustomName fcustomName, "
				+ " t15.FAddress faddress, t15.FLinkman flinkman, t15.FLinkTel flinkTel, t15.FLinkPhone flinkPhone, "
				+ " t15.FReserve1 freserve1, t15.FReserve2 freserve2, t15.FReserve3 freserve3 ";
		
		String countSql = " SELECT count(*)";
		String totalAmountSql = " SELECT SUM(ISNULL(t1.FTotalAmount, 0))";
		String commonSql = " FROM T_LS_Retail t1 "
				+ " LEFT JOIN t_Emp t8 ON t8.FItemID = t1.FCashier"
				+ " LEFT JOIN t_LS_RetailEntry2 t10 ON t10.FID = t1.FID"
				+ " LEFT JOIN vw_LS_Currency t11 ON t11.FID = t10.FCurrency"
				+ " LEFT JOIN t_LS_Settle t12 ON t12.FID = t10.FSettleID"
				+ " LEFT JOIN t_LS_Custom t15 ON t15.FID = t1.FID"
				+ " WHERE 1 = 1 ";
		
		String totalCountSql = " SELECT SUM(ISNULL(t3.FQty, 0))"
				+ " FROM T_LS_Retail t1 "
				+ " LEFT JOIN T_LS_RetailEntry t3 ON t3.FID = t1.FID"
				+ " LEFT JOIN t_Item t5 ON t5.FItemID = t3.FItemID"
				+ " WHERE t5.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
			totalCountSql += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(fbillNo)) {
				commonSql += " and t1.FBillNo like '%" + fbillNo + "%'";
				totalCountSql += " and t1.FBillNo like '%" + fbillNo + "%'";
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
				totalCountSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
				totalCountSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
		}
		
		List<Object> totalCountLst = (List<Object>)baseDao2.executeNativeQuery(totalCountSql);
		BigDecimal totalCount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalCountLst)) {
			totalCount = (BigDecimal)totalCountLst.get(0);
		}
		
		List<Object> totalAmoutLst = (List<Object>)baseDao2.executeNativeQuery(totalAmountSql + commonSql);
		BigDecimal totalAmount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalAmoutLst)) {
			totalAmount = (BigDecimal)totalAmoutLst.get(0);
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		commonSql += "order by t1.Fdate desc";
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		if (!CollectionUtils.isEmpty(lst)) {
			SellBillsVo vo = lst.get(0);
			vo.setTotalCount(totalCount);
			vo.setTotalAmount(totalAmount);
		}
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}

	@Override
	public ListVo<TransSummaryVo> getTransSummary(Map<String, String> paramMap, ListVo<TransSummaryVo> voLstInSession,
			Map<String, String> paramMapInsession) throws Exception {
		
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        String startDate = paramMap.get("startDate");
        String endDate = paramMap.get("endDate");
        String stockInfo = paramMap.get("stockInfo");
        String stockInfo2 = paramMap.get("stockInfo2");
        String fnumberStart = paramMap.get("fnumberStart");
        String fnumberEnd = paramMap.get("fnumberEnd");
		
		ListVo<TransSummaryVo> voLst = new ListVo<TransSummaryVo>();
		List<TransSummaryVo> list = new ArrayList<TransSummaryVo>();
		
		if (voLstInSession == null || (voLstInSession != null && voLstInSession.getList() == null)
				 || (voLstInSession != null && voLstInSession.getList() != null && voLstInSession.getList().size() <= 0)
				 || !startDate.equals(paramMapInsession.get("startDate")) || !endDate.equals(paramMapInsession.get("endDate"))
				 || !stockInfo.equals(paramMapInsession.get("stockInfo")) || !stockInfo2.equals(paramMapInsession.get("stockInfo2"))
				 || !fnumberStart.equals(paramMapInsession.get("fnumberStart")) || !fnumberEnd.equals(paramMapInsession.get("fnumberEnd"))) {
			
			Session session = baseDao2.getHibernateTemp().getSessionFactory().openSession();
			Connection conn = null;
			ResultSet rs = null;
			CallableStatement cs = null;
			if (session != null) {
				conn = session.connection();
				cs = conn.prepareCall("{Call cd_wlsfhzb(?, ?, ?, ?, ?, ?)}");
				cs.setDate(1, new Date(DateUtil.stringToDate(startDate, "yyyy-MM-dd").getTime())); //CallableStatement的参数设置下标从1 开始 
				cs.setDate(2, new Date(DateUtil.stringToDate(endDate, "yyyy-MM-dd").getTime()));
				if (StringUtil.isBlank(stockInfo) || "-1".equals(stockInfo)) {
					cs.setString(3, "");
				}
				else {
					cs.setString(3, stockInfo);
				}
				
				if (StringUtil.isBlank(stockInfo2) || "-1".equals(stockInfo2)) {
					cs.setString(4, "");
				}
				else {
					cs.setString(4, stockInfo2);
				}
				
				if (StringUtil.isBlank(fnumberStart)) {
					cs.setString(5, "");
				}
				else {
					cs.setString(5, fnumberStart);
				}
				
				if (StringUtil.isBlank(fnumberEnd)) {
					cs.setString(6, "");
				}
				else {
					cs.setString(6, fnumberEnd);
				}
				
				//cs.registerOutParameter(3, Types.INTEGER);
				rs = cs.executeQuery();
				//cs.getInt(3);
				
				TransSummaryVo vo = null;
				while(rs.next()){
			        vo = new TransSummaryVo();
					// 收发日期
			        //vo.setSfrq("");
			        vo.setSpdm(rs.getString("FNumber"));
			        vo.setSpmc(rs.getString("FName"));
			        vo.setGgxh(rs.getString("FModel"));
			        vo.setUnit(rs.getString("FUnitName"));
			        vo.setTxm(rs.getString("FGoodsBarCode"));
			        vo.setCqsl(rs.getBigDecimal("FBegQty"));
			        vo.setBqrksl(rs.getBigDecimal("FInQty"));
			        vo.setBqcksl(rs.getBigDecimal("FOutQty"));
			        vo.setBqjcsl(rs.getBigDecimal("FEndQty"));
			        // 收发仓库
			        //vo.setSfck(rs.getString(""));
			        list.add(vo);
			    }
				
				rs.close();
				cs.close();
				session.close();
			}
			
			voLst.setTotalSize(list.size());
			voLst.setList(list);
		}
		else {
			int total = voLstInSession.getTotalSize();
			voLst.setTotalSize(total);
			
			List<TransSummaryVo> listInSession = voLstInSession.getList();
			int end = start + limit;
			for (int i = start; i < end && i < total ; i++) {
				list.add(listInSession.get(i));
			}
			voLst.setList(list);
		}
		
		return voLst;
	}
	
	@Override
	public ListVo<SellBillsVo> getGoodsInfo(Map<String, String> paramMap)  throws Exception {
		
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String goodsName = paramMap.get("goodsName");
        
        String sql = " select"
        		+ " t1.FNumber fnumber, "
        		+ " t1.FName fname, "
        		+ " t1.FModel fmodel, "
        		+ " t2.FName unit, "
        		+ " t1.FGoodsBarCode fbarCode "
        		+ " from t_ICItem t1"
        		+ " left join t_MeasureUnit t2 on t2.FItemID = t1.FUnitID"
        		+ " where t1.FNumber like '1.%'";
        
        String countSql = " select count(*) "
        		+ " from t_ICItem t1"
        		+ " left join t_MeasureUnit t2 on t2.FItemID = t1.FUnitID"
        		+ " where t1.FNumber like '1.%'";
        
        if (StringUtil.isNotBlank(goodsName)) {
        	sql += " and t1.FName like '%" + goodsName + "%'";
        	countSql += " and t1.FName like '%" + goodsName + "%'";
        }
        
        int count = baseDao2.getTotalCountNativeQuery(countSql, new Object[]{});
		
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql, SellBillsVo.class);
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
	
	@Override
	public ListVo<GysVo> getGysInfo(Map<String, String> paramMap)  throws Exception {
		
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String gysName = paramMap.get("gysName");
        
        String sql = " select "
        		+ " FItemID fitemId, "
        		+ " FName fname, "
        		+ " FNumber fnumber, "
        		+ " FAddress faddress "
        		+ " FROM t_Supplier ";
        
        String countSql = " select count(*) FROM t_Supplier ";
        
        if (StringUtil.isNotBlank(gysName)) {
        	sql += " where FName like '%" + gysName + "%'";
        	countSql += " where FName like '%" + gysName + "%'";
        }
        
        int count = baseDao2.getTotalCountNativeQuery(countSql, new Object[]{});
		
        sql += " ORDER BY FItemID ";
		List<GysVo> lst = (List<GysVo>)baseDao2.executeNativeSQLForBean(start, limit, sql, GysVo.class);
		
		ListVo<GysVo> volst = new ListVo<GysVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
	
	@Override
	public List<GysVo> getGhdwInfo()  throws Exception {
		
        String sql = " select FItemID fitemId, FName fname from t_Organization ORDER BY FItemID";
		List<GysVo> lst = (List<GysVo>)baseDao2.executeNativeSQLForBean(sql, GysVo.class);
		
		return lst;
	}
	
	/*********************出入监管准单***********************************/
	
	@Override
	public ListVo<SellBillsVo> getOutSupervise(Map<String, String> paramMap)  throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String startDate = paramMap.get("startDate");
        String endDate = paramMap.get("endDate");
        String billsId = paramMap.get("billsId");
        String forDetail = paramMap.get("forDetail");
        String fbillNo = paramMap.get("fbillNo");
		
        String sql = " SELECT "
				+ " t1.FBillNo fbillNo, t2.FName fscStockName, t3.FName fdcStockName, t1.FText ftext, "
				+ " t1.FText1 ftext1, t1.FText2 ftext2, t4.FName userName, t1.FDate fdate, "
				+ " t5.FName fcardType, t7.FNumber fnumber, t7.FName fname, t7.FModel fmodel, "
				+ " t8.FName unit, t6.FQty fauxqty ";
		
		String countSql = " SELECT count(*)";
		
		String commonSql = " from t_BOS200000000 t1 "
				+ " inner join t_BOS200000000Entry2 t6 on t6.FID = t1.FID"
				+ " left join t_Item t2 on t2.FItemID = t1.FBase"
				+ " left join t_Item t3 on t3.FItemID = t1.FBase1"
				+ " left join t_Item t4 on t4.FItemID = t1.FBiller"
				+ " left join t_Item t5 on t5.FItemID = t1.FClassID_SRC"
				+ " left join t_ICItem t7 on t7.FItemID = t6.FBase2"
				+ " left join t_MeasureUnit t8 on t8.FItemID = t6.FBase3"
				+ " WHERE 1 = 1 ";
		
		String totalCountSql = " SELECT SUM(ISNULL(t6.FQty, 0))"
				+ " from t_BOS200000000 t1 "
				+ " inner join t_BOS200000000Entry2 t6 on t6.FID = t1.FID"
				+ " left join t_ICItem t7 on t7.FItemID = t6.FBase2"
				+ " WHERE t7.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
			totalCountSql += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(fbillNo)) {
				commonSql += " and t1.FBillNo like '%" + fbillNo + "%'";
				totalCountSql += " and t1.FBillNo like '%" + fbillNo + "%'";
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
				totalCountSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
				totalCountSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
		}
		
		List<Object> totalCountLst = (List<Object>)baseDao2.executeNativeQuery(totalCountSql);
		BigDecimal totalCount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalCountLst)) {
			totalCount = (BigDecimal)totalCountLst.get(0);
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		commonSql += "order by t1.Fdate desc";
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		if (!CollectionUtils.isEmpty(lst)) {
			SellBillsVo vo = lst.get(0);
			vo.setTotalCount(totalCount);
		}
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
	
	@Override
	public ListVo<SellBillsVo> getInSupervise(Map<String, String> paramMap)  throws Exception {
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
        
        String startDate = paramMap.get("startDate");
        String endDate = paramMap.get("endDate");
        String billsId = paramMap.get("billsId");
        String forDetail = paramMap.get("forDetail");
        String fbillNo = paramMap.get("fbillNo");
		
        String sql = " SELECT "
				+ " t1.FBillNo fbillNo, t2.FName fscStockName, t3.FName fdcStockName, t1.FText ftext, "
				+ " t1.FText1 ftext1, t1.FText2 ftext2, t4.FName userName, t1.FDate fdate, "
				+ " t5.FName fcardType, t7.FNumber fnumber, t7.FName fname, t7.FModel fmodel, "
				+ " t8.FName unit, t6.FQty fauxqty ";
		
		String countSql = " SELECT count(*)";
		
		String commonSql = " from t_BOS200000001 t1 "
				+ " inner join t_BOS200000001Entry2 t6 on t6.FID = t1.FID"
				+ " left join t_Item t2 on t2.FItemID = t1.FBase"
				+ " left join t_Item t3 on t3.FItemID = t1.FBase1"
				+ " left join t_Item t4 on t4.FItemID = t1.FBiller"
				+ " left join t_Item t5 on t5.FItemID = t1.FClassID_SRC"
				+ " left join t_ICItem t7 on t7.FItemID = t6.FBase2"
				+ " left join t_MeasureUnit t8 on t8.FItemID = t6.FBase3"
				+ " WHERE 1 = 1 ";
		
		String totalCountSql = " SELECT SUM(ISNULL(t6.FQty, 0))"
				+ " from t_BOS200000001 t1 "
				+ " inner join t_BOS200000001Entry2 t6 on t6.FID = t1.FID"
				+ " left join t_ICItem t7 on t7.FItemID = t6.FBase2"
				+ " WHERE t7.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
			totalCountSql += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(fbillNo)) {
				commonSql += " and t1.FBillNo like '%" + fbillNo + "%'";
				totalCountSql += " and t1.FBillNo like '%" + fbillNo + "%'";
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
				totalCountSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
				totalCountSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
		}
		
		List<Object> totalCountLst = (List<Object>)baseDao2.executeNativeQuery(totalCountSql);
		BigDecimal totalCount = new BigDecimal(0);
		if (!CollectionUtils.isEmpty(totalCountLst)) {
			totalCount = (BigDecimal)totalCountLst.get(0);
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		commonSql += "order by t1.Fdate desc";
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		if (!CollectionUtils.isEmpty(lst)) {
			SellBillsVo vo = lst.get(0);
			vo.setTotalCount(totalCount);
		}
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}
}
