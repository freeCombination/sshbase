<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../common/taglibs.jsp"%>
<%@include file="../common/index_css.jsp"%>
<html>
<head>
<title>开发架构系统</title>
</head>
<body>
	<table width="100%" border="0">
		<tr>
			<td width="100%" height="100%" valign="top">
				<div class="container_right">
					<div class="container_right_title">
						<span class="FontStyle">快捷入口</span>
					</div>
					<div class="container_right_icon">
						<a href="${ctx}/hg/toSellBills.action" target="frame_Center"><img src="${ctx}/images/index/right_icon.png" /></a>
						<div>出入库查询</div>
					</div>
					<div class="container_right_icon">
						<a href="${ctx}/hg/toInventory.action" target="frame_Center"><img src="${ctx}/images/index/right_icon.png" /></a>
						<div>实时库存查询</div>
					</div>
					<div class="container_right_icon">
						<a href="${ctx}/hg/toRetailBills.action" target="frame_Center"><img src="${ctx}/images/index/right_icon.png" /></a>
						<div>零售单查询</div>
					</div>
					<div class="container_right_icon">
						<a href="${ctx}/hg/toTransSummary.action" target="frame_Center"><img src="${ctx}/images/index/right_icon.png" /></a>
						<div>收发汇总查询</div>
					</div>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>