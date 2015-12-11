package com.hed.sshbase.hg.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hed.sshbase.common.dao.IBaseDao2;
import com.hed.sshbase.common.util.StringUtil;
import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.service.IDataMonitorService;
import com.hed.sshbase.hg.vo.SellBillsVo;

/**
 * 数据监控Service
 */
@Service("monitorService")
public class DataMonitorServiceImpl implements IDataMonitorService {

	@Autowired
    @Qualifier("baseDao2")
    private IBaseDao2 baseDao2;
	
	@Override
	public ListVo<SellBillsVo> getSellDeliveryBills(Map<String, String> paramMap) {
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
				+ " WHERE 1 = 1 ";
		
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

}
