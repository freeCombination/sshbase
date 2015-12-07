package com.hed.sshbase.hg.service;

import java.util.Map;

import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.vo.SellBillsVo;

/**
 * 数据监控Service接口
 */
public interface IDataMonitorService {
    
	/**
	 * 获取销售出库单
	 * @return
	 */
	public ListVo<SellBillsVo> getSellDeliveryBills(Map<String, String> paramMap);
}
