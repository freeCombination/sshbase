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
	
	/**
	 * 获取销售出库单
	 * @return
	 */
	public String getSellDeliveryBills() {
        try {
            Map<String, String> params = RequestUtil.getParameterMap(getRequest());
            ListVo<SellBillsVo> volst = monitorService.getSellDeliveryBills(params);
            
            JsonUtil.outJson(volst);
            
        } catch (Exception e) {
            JsonUtil.outJson("{success:false,msg:'获取销售出库单失败！'}");
            this.excepAndLogHandle(DataMonitorAction.class, "获取销售出库单", e, false);
            return LOGIN;
        }
        return null;
    }
	
	public String toSellBillsDetail() {
		return SUCCESS;
	}
}
