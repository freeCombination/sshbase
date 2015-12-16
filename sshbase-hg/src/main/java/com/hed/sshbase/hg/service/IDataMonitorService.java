package com.hed.sshbase.hg.service;

import java.util.Map;

import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.vo.SellBillsVo;
import com.hed.sshbase.hg.vo.TransSummaryVo;

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
	
	/**
	 * 查询零售单商品
	 */
	public ListVo<SellBillsVo> getRetailGoods(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询收发汇总
	 */
	public ListVo<TransSummaryVo> getTransSummary(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询物料
	 */
	public ListVo<SellBillsVo> getGoodsInfo(Map<String, String> paramMap)  throws Exception;
}
