<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>实时库存</title>
<link href="" rel="SHORTCUT ICON" />
<style type="text/css">
  .x-form-layout-table{
	table-layout: fixed;
  }
</style>
</head>
<body>
	<script type="text/javascript">
	
	Ext.onReady(function() {
		Ext.QuickTips.init();
		//自动引入其他需要的js
		Ext.require(["Ext.container.*",
		             "Ext.grid.*", 
		             "Ext.toolbar.Paging", 
		             "Ext.form.*",
					 "Ext.data.*" ]);
		//建立Model模型对象
		Ext.define("Inventory",{
			extend:"Ext.data.Model",
			fields:[
				{name: "fnumber"}, 
				{name: "fname"}, 
				{name: "fmodel"},
				{name: "stockName"},
				{name: "stockNumber"},
				{name: "fkfDateStr"},
				{name: "fkfPeriod"},
				{name: "unit"},
				{name: "fqty"},
				{name: "fcostPrice"}
			]
		});
		
		//建立数据Store
		var inventoryStore=Ext.create("Ext.data.Store", {
	        pageSize: SystemConstant.commonSize,
	        model:"Inventory",
	        remoteSort:true,
			proxy: {
	            type:"ajax",
	            actionMethods: {
                	read: 'POST'
           		},
			    url: "${ctx}/hg/getInventory.action",
			    reader: {
				     totalProperty: "totalSize",
				     root: "list"
			    },
	        simpleSortMode :true
	        }
		});
		
		var cm=[
	                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
	                {header: "物料代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
	                {header: "物料名称",width: 140,dataIndex: "fname",menuDisabled: true,sortable :false},
	                {header: "规格型号",width:100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
	                {header: "仓库代码",width: 120,dataIndex: "stockNumber",menuDisabled: true,sortable :false},
	                {header: "仓库名称",width: 120,dataIndex: "stockName",menuDisabled: true,sortable :false},
	                {header: "生产/采购日期",width: 100,dataIndex: "fkfDateStr",menuDisabled: true,sortable :false},
	                {header: "保质期",width: 70,dataIndex: "fkfPeriod",menuDisabled: true,sortable :false},
	                {header: "基本计量单位",width: 100,dataIndex: "unit",menuDisabled: true,sortable :false},
	                {header: "基本单位数量",width: 100,dataIndex: "fqty",menuDisabled: true,sortable :false},
	                {header: "最新进价",width: 100,dataIndex: "fcostPrice",menuDisabled: true,sortable :false}
	             ];
		
		//grid组件
		var inventoryGrid =  Ext.create("Ext.grid.Panel",{
			title:'实时库存',
			border:false,
			columnLines: true,
			layout:"fit",
			region: "center",
			width: "100%",
			height: document.body.clientHeight,
			id: "inventoryGrid",
			bbar:  Ext.create("Ext.PagingToolbar", {
				store: inventoryStore,
				displayInfo: true,
				displayMsg: SystemConstant.displayMsg,
				emptyMsg: SystemConstant.emptyMsg
			}),
			columns:cm,
	     	forceFit : true,
			store: inventoryStore,
			autoScroll: true,
			stripeRows: true
		});
		inventoryStore.load({params:{start:0,limit:SystemConstant.commonSize}});
		
		var treeStore = Ext.create('Ext.data.TreeStore', {
		    root: {
		        expanded: true,
		        nodeId: "",
		        text: "仓库",
		        leaf: false,
		        children: [
		            {nodeId: "001", text: "001(免税仓库)", leaf: true },
		            {nodeId: "110", text: "100(机场免税店)", leaf: true},
		            {nodeId: "111", text: "111(免税品待检仓)", leaf: true }
		        ]
		    }
		});
		
		var treePanel = Ext.create('Ext.tree.Panel', {
		    title: '仓库信息',
		    region: "west",
		    layout:'fit',
		    width: 200,
		    store: treeStore,
		    rootVisible: true
		});
		
		treePanel.on("itemclick",function(view,record,item,index,e,opts){
			var proxy = inventoryStore.getProxy();
            proxy.setExtraParam("stockNumber", record.raw.nodeId);
            inventoryStore.loadPage(1);
		});
		
		Ext.create("Ext.container.Viewport", {
		    layout: "border",
			items: [treePanel, inventoryGrid]
		});
		
	});
	</script>
</body>
</html>