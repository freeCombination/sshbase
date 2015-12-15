package com.hed.sshbase.hg.service.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;
import org.hibernate.classic.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hed.sshbase.common.dao.IBaseDao2;
import com.hed.sshbase.common.util.StringUtil;
import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.service.IDataMonitorService;
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
        String queryDate = paramMap.get("queryDate");
        String billsType = paramMap.get("billsType");
        String checkFlag = paramMap.get("checkFlag");
        
        String billsId = paramMap.get("billsId");
        String forDetail = paramMap.get("forDetail");
		
		String sql = " SELECT "
				+ " t1.FTranType ftranType,"
				+ " t2.FInterID finterId, t1.Fdate fdate, t1.FSupplyID fsupplyId, t1.FDCStockID fdCStockId, "
				+ " t2.FItemName fitemName, t2.FUnitID funitId, t2.FBatchNo fbatchNo,"
				+ " t2.Fauxqty fauxqty, t2.Fauxprice fauxprice, t2.Famount famount, t1.FDeptID fdeptId, "
				+ " t1.FEmpID fempId, t2.FConsignPrice fconsignPrice, t2.FConsignAmount fconsignAmount, "
				+ " t3.FName fname, t3.FNumber fnumber, t4.FName deptName, t5.FName userName, t6.FName unit, "
				+ " t7.FName ghcustom, t8.FName stockName, t1.FBillNo fbillNo, t9.FModel fmodel, t2.FBarCode fbarCode, "
				+ " t9.FShortNumber fshortNumber, t2.FAuxQtyMust fauxQtyMust, t10.FName fsecUnitName, "
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
				+ " t14.FName fsManagerName";
		
		String countSql = " SELECT count(*)";
		String commonSql = " FROM ICStockBill t1 LEFT JOIN ICStockBillEntry t2 "
				+ " ON t1.FInterID=t2.FInterID "
				+ " LEFT JOIN t_Item t3 ON t3.FItemID = t2.FItemID"
				+ " LEFT JOIN t_Department t4 ON t4.FItemID = t1.FDeptID"
				+ " LEFT JOIN t_Emp t5 ON t5.FItemID = t1.FEmpID"
				+ " LEFT JOIN t_MeasureUnit t6 ON t6.FItemID = t2.FUnitID"
				+ " LEFT JOIN t_Organization t7 ON t7.FItemID = t1.FSupplyID"
				+ " LEFT JOIN t_Stock t8 ON t8.FItemID = t1.FDCStockID"
				+ " LEFT JOIN t_ICItem t9 ON t9.FItemID = t2.FItemID"
				+ " LEFT JOIN t_MeasureUnit t10 ON t10.FItemID = t9.FSecUnitID" // 对不对
				+ " LEFT JOIN t_Supplier t11 ON t11.FItemID = t1.FSupplyID"
				+ " LEFT JOIN t_ComCategory t12 ON t12.FItemID = t2.FComCategoryID"
				+ " LEFT JOIN t_ComBrand t13 ON t13.FItemID =  t2.FComBrandID"
				+ " LEFT JOIN t_Emp t14 ON t14.FItemID = t1.FSManagerID"
				+ " WHERE t3.FNumber like '1.%' and t1.FTranType in (1, 10, 21, 29)";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(billsType) && !"-1".equals(billsType)) {
				commonSql += " and t1.FTranType=" + billsType;
			}
			
			if (StringUtil.isNotBlank(checkFlag) && !"A".equals(checkFlag)) {
				commonSql += " and t9.FModel='" + checkFlag + "'";
			}
			
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
			
			if (StringUtil.isNotBlank(queryDate)) {
				commonSql += " and t1.Fdate=convert(datetime,'" + queryDate + "')";
			}
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		commonSql += "order by t1.Fdate desc";
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
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
		
		String sql = " SELECT "
				+ " t2.FNumber fnumber, t2.FName fname, t3.FModel fmodel, t4.FName stockName, "
				+ " t4.FNumber stockNumber, t1.FKFDate fkfDateStr, t1.FKFPeriod fkfPeriod, t5.FName unit,"
				+ " t1.FQty fqty, t1.FCostPrice fcostPrice";
		
		String countSql = " SELECT count(*)";
		String commonSql = " FROM ICInventory t1 "
				+ " LEFT JOIN t_Item t2 ON t2.FItemID = t1.FItemID "
				+ " LEFT JOIN t_ICItem t3 ON t3.FItemID = t1.FItemID"
				+ " LEFT JOIN t_Stock t4 ON t4.FItemID = t1.FStockID"
				+ " LEFT JOIN t_MeasureUnit t5 ON t5.FItemID = t3.FUnitID"
				+ " WHERE  t2.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(stockNumber)) {
			commonSql += " and t4.FNumber='" + stockNumber + "'";
		}
		else {
			commonSql += " and t4.FNumber in ('001', '110', '111')";
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
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
		
		String sql = " SELECT "
				+ " t1.FBillNO fbillNo, t1.FDate fdate, t1.FBillType fbillType, t1.FBranchShop fbranchShop, t8.FName fcashier, "
				+ " t1.FPOS fpos, t9.FName fshift, t1.FTotalAmount ftotalAmount, t1.FDiscountAmount fdiscountAmount, "
				+ " t1.FReceAmount freceAmount, convert(varchar(19), t1.FBeginTime, 20) fbeginTime, "
				+ " convert(varchar(19), t1.FEndTime, 20) fendTime, t1.FCollectMode fcollectMode, "
				+ " t2.FName customName, t4.FName stockName, t5.FName fname, t5.FNumber fnumber, t3.FBarcode fbarCode, "
				+ " t6.FName unit, t3.FQty fqty, t3.FPrice fprice, t3.FDiscountPrice fdiscountPrice, t3.FAmount famount,"
				+ " t3.FBalAmount fbalAmount, t3.FDiscountRate fdiscountRate, t3.FDiscountReason fdiscountReason, t7.FName userName, "
				+ " t3.FBatchNO fbatchNo, t3.FKFDate fkfDateStr, t3.FKFPeriod fkfPeriod, t12.FName fsettleName, "
				+ " t10.FSettleAmount fsettleAmount, t10.FAmount famountxf, t11.FName fcurrency, t10.FRate frate, "
				+ " t10.FCardType fcardType, t10.FCardNO fcardNo, t10.FReferenceNO freferenceNo, t13.FCardNumber fcardNumber, "
				+ " t14.FName fcardTypeName, t13.FAccount faccount, t13.FAccountSubID faccountSubId, t15.FCustomName fcustomName, "
				+ " t15.FAddress faddress, t15.FLinkman flinkman, t15.FLinkTel flinkTel, t15.FLinkPhone flinkPhone, "
				+ " t15.FReserve1 freserve1, t15.FReserve2 freserve2, t15.FReserve3 freserve3 ";
		
		String countSql = " SELECT count(*)";
		String commonSql = " FROM T_LS_Retail t1 "
				+ " LEFT JOIN t_Organization t2 ON t2.FItemID = t1.OrganizationID "
				+ " LEFT JOIN T_LS_RetailEntry t3 ON t3.FID = t1.FID"
				+ " LEFT JOIN t_Stock t4 ON t4.FItemID = t3.FStock"
				+ " LEFT JOIN t_Item t5 ON t5.FItemID = t3.FItemID"
				+ " LEFT JOIN t_MeasureUnit t6 ON t6.FItemID = t3.FSaleUnitID"
				+ " LEFT JOIN t_Emp t7 ON t7.FItemID = t3.FSalesMan"
				+ " LEFT JOIN t_Emp t8 ON t8.FItemID = t1.FCashier"
				+ " LEFT JOIN VW_LS_Shift t9 ON t9.FID = t1.FShift"
				+ " LEFT JOIN t_LS_RetailEntry2 t10 ON t10.FID = t1.FID"
				+ " LEFT JOIN vw_LS_Currency t11 ON t11.FID = t10.FCurrency"
				+ " LEFT JOIN t_LS_Settle t12 ON t12.FID = t10.FSettleID"
				+ " LEFT JOIN ICVIPActionList t13 ON t13.FID = t1.FID"
				+ " LEFT JOIN ICVIPCardType t14 ON t14.FID = t13.FCardTypeID"
				+ " LEFT JOIN t_LS_Custom t15 ON t15.FID = t1.FID"
				+ " WHERE t5.FNumber like '1.%' ";
		
		if (StringUtil.isNotBlank(forDetail) && "forDetail".equals(forDetail) && StringUtil.isNotBlank(billsId)) {
			commonSql += " and t1.FBillNo='" + billsId + "'";
		}
		else {
			if (StringUtil.isNotBlank(startDate)) {
				commonSql += " and t1.Fdate>=convert(datetime,'" + startDate + "')";
			}
			
			if (StringUtil.isNotBlank(endDate)) {
				commonSql += " and t1.Fdate<=convert(datetime,'" + endDate + "')";
			}
		}
		
		int count = baseDao2.getTotalCountNativeQuery(countSql + commonSql, new Object[]{});
		
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql + commonSql, SellBillsVo.class);
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}

	@Override
	public ListVo<TransSummaryVo> getTransSummary(Map<String, String> paramMap) throws Exception {
		
		int start = NumberUtils.toInt(paramMap.get("start"));
        int limit = NumberUtils.toInt(paramMap.get("limit"));
		
		ListVo<TransSummaryVo> voLst = new ListVo<TransSummaryVo>();
		int count = 0;
		List<TransSummaryVo> list = new ArrayList<TransSummaryVo>();
		
		Session session = baseDao2.getHibernateTemp().getSessionFactory().openSession();
		Connection conn = null;
		ResultSet rs = null;
		CallableStatement cs = null;
		if (session != null) {
			conn = session.connection();
			cs = conn.prepareCall("{Call cd_wlsfhzb(?, ?)}");
			cs.setString(1, "2015-12-30"); //CallableStatement的参数设置下标从1 开始 
			cs.setString(2, "2015-12-30");
			//cs.registerOutParameter(3, Types.INTEGER);
			rs = cs.executeQuery();
			//cs.getInt(3);
			
			TransSummaryVo vo = null;
			while(rs.next()){
		        vo = new TransSummaryVo();
				
		        
		        System.out.println(rs.getString("商品名称"));
		    }
			
			rs.close();
			cs.close();
			session.close();
		}
		
		voLst.setTotalSize(count);
		voLst.setList(list);
		
		return voLst;
	}
}
