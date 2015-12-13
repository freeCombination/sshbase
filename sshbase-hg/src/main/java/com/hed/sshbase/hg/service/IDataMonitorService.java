package com.hed.sshbase.hg.service;

import java.util.Map;

import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.vo.SellBillsVo;

/**
 * 数据监控Service接口
 */
public interface IDataMonitorService {
    
	/**
	 * 查询实时库存
	 */
	public ListVo<SellBillsVo> getSellDeliveryBills(Map<String, String> paramMap) throws Exception;
	
	/**
	 * 查询实时库存
	 */
	public ListVo<SellBillsVo> getInventory(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询零售单
	 */
	public ListVo<SellBillsVo> getRetail(Map<String, String> paramMap)  throws Exception;
}
