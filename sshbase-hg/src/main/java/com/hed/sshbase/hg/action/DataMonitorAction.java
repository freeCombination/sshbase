package com.hed.sshbase.hg.action;

import java.util.Map;

import javax.annotation.Resource;

import com.hed.sshbase.common.action.BaseAction;
import com.hed.sshbase.common.util.JsonUtil;
import com.hed.sshbase.common.util.RequestUtil;
import com.hed.sshbase.common.vo.ListVo;
import com.hed.sshbase.hg.service.IDataMonitorService;
import com.hed.sshbase.hg.vo.SellBillsVo;

/**
 * 数据监控Action
 */
public class DataMonitorAction extends BaseAction {

	private static final long serialVersionUID = 9084410616136027777L;

	@Resource
    private IDataMonitorService monitorService;
	
	private String billsName;
	private String billsId;
	private String ftranType;
	
	public String getBillsName() {
		return billsName;
	}
	public void setBillsName(String billsName) {
		this.billsName = billsName;
	}
	public String getBillsId() {
		return billsId;
	}
	public void setBillsId(String billsId) {
		this.billsId = billsId;
	}
	public String getFtranType() {
		return ftranType;
	}
	public void setFtranType(String ftranType) {
		this.ftranType = ftranType;
	}
	
	/**
	 * 获取出入库单
	 */
	public String getSellDeliveryBills() {
        try {
            Map<String, String> params = RequestUtil.getParameterMap(getRequest());
            ListVo<SellBillsVo> volst = monitorService.getSellDeliveryBills(params);
            
            JsonUtil.outJson(volst);
            
        } catch (Exception e) {
            JsonUtil.outJson("{success:false,msg:'获取出入库单失败！'}");
            this.excepAndLogHandle(DataMonitorAction.class, "获取出入库单", e, false);
            return LOGIN;
        }
        return null;
    }
	
	public String toSellBillsDetail() {
		return SUCCESS;
	}
	
	/**
	 * 查询实时库存
	 */
	public String getInventory() {
        try {
            Map<String, String> params = RequestUtil.getParameterMap(getRequest());
            ListVo<SellBillsVo> volst = monitorService.getInventory(params);
            
            JsonUtil.outJson(volst);
            
        } catch (Exception e) {
            JsonUtil.outJson("{success:false,msg:'查询实时库存失败！'}");
            this.excepAndLogHandle(DataMonitorAction.class, "查询实时库存", e, false);
            return LOGIN;
        }
        return null;
    }
}
