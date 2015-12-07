package com.hed.sshbase.hg.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hed.sshbase.common.dao.IBaseDao2;
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
		
		String sql = " SELECT "
				+ " t2.FInterID finterId, t1.Fdate fdate, t1.FSupplyID fsupplyId, t1.FDCStockID fdCStockId, "
				+ " t2.FItemName fitemName, t2.FUnitID funitId, t2.FBatchNo fbatchNo,"
				+ " t2.Fauxqty fauxqty, t2.Fauxprice fauxprice, t2.Famount famount, t1.FDeptID fdeptId, "
				+ " t1.FEmpID fempId, t2.FConsignPrice fconsignPrice, t2.FConsignAmount fconsignAmount,"
				+ " t3.FName fname, t3.FNumber fnumber, t4.FName deptName, t5.FName userName, t6.FName unit,"
				+ " t7.FName ghcustom, t8.FName stockName, t1.FBillNo fbillNo"
				+ " FROM ICStockBill t1 LEFT JOIN ICStockBillEntry t2 "
				+ " ON t1.FInterID=t2.FInterID "
				+ " LEFT JOIN t_Item t3 ON t3.FItemID = t2.FItemID"
				+ " LEFT JOIN t_Department t4 ON t4.FItemID = t1.FDeptID"
				+ " LEFT JOIN t_Emp t5 ON t5.FItemID = t1.FEmpID"
				+ " LEFT JOIN t_MeasureUnit t6 ON t6.FItemID = t2.FUnitID"
				+ " LEFT JOIN t_Organization t7 ON t7.FItemID = t1.FSupplyID"
				+ " LEFT JOIN t_Stock t8 ON t8.FItemID = t1.FDCStockID"
				+ " WHERE t1.FTranType=21 "
				+ " order by t1.Fdate desc";
		
		String countSql = " SELECT count(*)"
				+ " FROM ICStockBill t1 LEFT JOIN ICStockBillEntry t2 "
				+ " ON t1.FInterID=t2.FInterID "
				+ " LEFT JOIN t_Item t3 ON t3.FItemID = t2.FItemID"
				+ " LEFT JOIN t_Department t4 ON t4.FItemID = t1.FDeptID"
				+ " LEFT JOIN t_Emp t5 ON t5.FItemID = t1.FEmpID"
				+ " LEFT JOIN t_MeasureUnit t6 ON t6.FItemID = t2.FUnitID"
				+ " LEFT JOIN t_Organization t7 ON t7.FItemID = t1.FSupplyID"
				+ " LEFT JOIN t_Stock t8 ON t8.FItemID = t1.FDCStockID"
				+ " WHERE t1.FTranType=21 ";
		
		int count = baseDao2.getTotalCountNativeQuery(countSql, new Object[]{});
		List<SellBillsVo> lst = (List<SellBillsVo>)baseDao2.executeNativeSQLForBean(start, limit, sql, SellBillsVo.class);
		
		ListVo<SellBillsVo> volst = new ListVo<SellBillsVo>();
		volst.setTotalSize(count);
		volst.setList(lst);
		return volst;
	}

}
