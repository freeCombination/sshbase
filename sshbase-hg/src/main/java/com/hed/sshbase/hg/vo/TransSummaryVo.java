package com.hed.sshbase.hg.vo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 收发汇总VO
 */
public class TransSummaryVo implements Serializable{

	private static final long serialVersionUID = -4256348263426090795L;

	private String spdm;
	private String sfrq;
	private String spmc;
	private String ggxh;
	private String txm;
	private String unit;
	private BigDecimal cqsl;
	private BigDecimal bqrksl;
	private BigDecimal bqcksl;
	private BigDecimal bqjcsl;
	private String sfck;
	
	public String getSpdm() {
		return spdm;
	}
	public void setSpdm(String spdm) {
		this.spdm = spdm;
	}
	public String getSfrq() {
		return sfrq;
	}
	public void setSfrq(String sfrq) {
		this.sfrq = sfrq;
	}
	public String getSpmc() {
		return spmc;
	}
	public void setSpmc(String spmc) {
		this.spmc = spmc;
	}
	public String getGgxh() {
		return ggxh;
	}
	public void setGgxh(String ggxh) {
		this.ggxh = ggxh;
	}
	public String getTxm() {
		return txm;
	}
	public void setTxm(String txm) {
		this.txm = txm;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public BigDecimal getCqsl() {
		return cqsl;
	}
	public void setCqsl(BigDecimal cqsl) {
		this.cqsl = cqsl;
	}
	public BigDecimal getBqrksl() {
		return bqrksl;
	}
	public void setBqrksl(BigDecimal bqrksl) {
		this.bqrksl = bqrksl;
	}
	public BigDecimal getBqcksl() {
		return bqcksl;
	}
	public void setBqcksl(BigDecimal bqcksl) {
		this.bqcksl = bqcksl;
	}
	public BigDecimal getBqjcsl() {
		return bqjcsl;
	}
	public void setBqjcsl(BigDecimal bqjcsl) {
		this.bqjcsl = bqjcsl;
	}
	public String getSfck() {
		return sfck;
	}
	public void setSfck(String sfck) {
		this.sfck = sfck;
	}
}
