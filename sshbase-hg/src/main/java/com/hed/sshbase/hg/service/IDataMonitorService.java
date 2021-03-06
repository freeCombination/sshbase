package com.hed.sshbase.hg.service;

import java.util.List;
import java.util.Map;

import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.vo.GysVo;
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
	 * 查询零售单结算方式
	 */
	public ListVo<SellBillsVo> getRetailSettleType(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询收发汇总
	 */
	public ListVo<TransSummaryVo> getTransSummary(Map<String, String> paramMap, ListVo<TransSummaryVo> voLst,
			Map<String, String> paramMapInsession)  throws Exception;
	
	/**
	 * 查询物料
	 */
	public ListVo<SellBillsVo> getGoodsInfo(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询供应商
	 */
	public ListVo<GysVo> getGysInfo(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询购货单位
	 */
	public List<GysVo> getGhdwInfo()  throws Exception;
	
	/*********************出入监管准单***********************************/
	
	/**
	 * 查询出监管准单
	 */
	public ListVo<SellBillsVo> getOutSupervise(Map<String, String> paramMap)  throws Exception;
	
	/**
	 * 查询入监管准单
	 */
	public ListVo<SellBillsVo> getInSupervise(Map<String, String> paramMap)  throws Exception;
}
