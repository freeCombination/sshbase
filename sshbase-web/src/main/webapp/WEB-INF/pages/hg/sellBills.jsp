<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>销售出库单</title>
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
		
		var sdate = '';
		var edate = '';
		var btype = '';
		var fnumberStart = '';
		var fnumberEnd = '';
		
		//建立Model模型对象
		Ext.define("SellBills",{
			extend:"Ext.data.Model",
			fields:[
				{name: "finterId"},
				{name: "fdate"}, 
				{name: "fsupplyId"},
				{name: "fdCStockId"},
				{name: "fitemName"},
				{name: "fmodel"},
				{name: "funitId"},
                {name: "fbatchNo"},
                {name: "fauxqty"}, 
                {name: "fauxprice"},
                {name: "famount"},
                {name: "fdeptId"},
                {name: "fempId"},
                {name: "fconsignPrice"},
                {name: "fconsignAmount"},
                {name: "fname"},
                {name: "fnumber"},
                {name: "deptName"}, 
                {name: "userName"}, 
                {name: "unit"},
                {name: "ghcustom"},
                {name: "stockName"},
                {name: "fbillNo"},
                {name: "fcheckFlag"},
                {name: "fbarCode"},
                
                {name: "ffmanagerId"},
                {name: "fsupplyName"},
                {name: "fsManagerName"},
                {name: "ftranType"},
                {name: "fscStockName"},
                {name: "fdcStockName"}
			]
		});
		
		//建立数据Store
		var sellBillsStore=Ext.create("Ext.data.Store", {
	        pageSize: SystemConstant.commonSize,
	        model:"SellBills",
			proxy: {
	            type:"ajax",
	            actionMethods: {
                	read: 'POST'
           		},
			    url: "${ctx}/hg/getSellDeliveryBills.action",
			    reader: {
				     totalProperty: "totalSize",
				     root: "list"
			    },
	            simpleSortMode :true
	        }
		});
		
		// 销售出库
		var cm=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "审核标志",width: 90,dataIndex: "fcheckFlag",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                //{header: "发货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "产品长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "产品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "购货单位",width: 100,dataIndex: "ghcustom",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                //{header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                {header: "实发数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                //{header: "单位成本",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                //{header: "成本",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "部门",width: 100,dataIndex: "deptName",menuDisabled: true,sortable :false},
                {header: "业务员",width: 90,dataIndex: "userName",menuDisabled: true,sortable :false},
                {header: "销售单价",width: 100,dataIndex: "fconsignPrice",menuDisabled: true,sortable :false},
                {header: "销售金额",width: 100,dataIndex: "fconsignAmount",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
             ];
		
		// 其他出库
		var cm2=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "审核标志",width: 90,dataIndex: "fcheckFlag",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "产品长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "产品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "领料部门",width:100,dataIndex: "deptName",menuDisabled: true,sortable :false},
                {header: "发货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                {header: "数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "单价",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "金额",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "领料",width: 100,dataIndex: "ffmanagerId",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
             ];
		
		// 外购入库
        var cm3=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "制单日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "审核标志",width: 90,dataIndex: "fcheckFlag",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                //{header: "收料仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "物料长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "物料名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "供应商",width: 100,dataIndex: "fsupplyName",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                //{header: "单价",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "实收数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                //{header: "金额",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "部门",width: 100,dataIndex: "deptName",menuDisabled: true,sortable :false},
                {header: "业务员",width: 90,dataIndex: "userName",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
                //{header: "门店销售价",width: 100,dataIndex: "",menuDisabled: true,sortable :false}
             ];
		
        // 其他入库
        var cm4=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "审核标志",width: 90,dataIndex: "fcheckFlag",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "收货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "物料长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "物料名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "实收数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "单价",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "金额",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                {header: "保管",width: 90,dataIndex: "fsManagerName",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
             ];
		
		var cm5=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "审核标志",width: 90,dataIndex: "fcheckFlag",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "产品长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "产品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                //{header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                //{header: "单位成本",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                //{header: "成本",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "部门",width: 100,dataIndex: "deptName",menuDisabled: true,sortable :false},
                {header: "业务员",width: 90,dataIndex: "userName",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
             ];
		
		// 调拨单
		var cm6=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "产品长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "产品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "调出仓库",width: 100,dataIndex: "fscStockName",menuDisabled: true,sortable :false},
                {header: "调入仓库",width: 100,dataIndex: "fdcStockName",menuDisabled: true,sortable :false},
                {header: "数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "条形码",width: 120,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
             ];
		
		//grid组件
		var sellBillsGrid =  Ext.create("Ext.grid.Panel",{
			title:'出入库',
			border:false,
			columnLines: true,
			layout:"fit",
			region: "center",
			width: "100%",
			height: document.body.clientHeight,
			id: "sellBillsGrid",
			bbar:  Ext.create("Ext.PagingToolbar", {
				store: sellBillsStore,
				displayInfo: true,
				displayMsg: SystemConstant.displayMsg,
				emptyMsg: SystemConstant.emptyMsg
			}),
			columns:cm5,
	     	forceFit : true,
			store: sellBillsStore,
			autoScroll: true,
			stripeRows: true,
			tbar: [
	        {
                xtype:'label',
                id:'createDate',
                html:'日期'
            },
			{
				width: 90,
				xtype: 'textfield',
				readOnly:true,
		        //value:getFirstDay(),
		        id:'queryDate',
		        listeners:{
		            "afterrender":function(com,eOpts){
	                    var startTime=Ext.getDom("queryDate-inputEl");
	                    startTime.initcfg={dateFmt:'yyyy-MM-dd',disabledDates:[]};
	                    startTime.style.cssText='background: url(\'${ctx }/scripts/my97DatePicker/skin/datePicker.gif\') no-repeat right #FFF;';
	                    startTime.onclick=function(){
	                        WdatePicker({dateFmt:'yyyy-MM-dd'});
	                        //,maxDate:'#F{$dp.$D(\'endDate-inputEl\')}'
	                    };
		            }
		        }
			},
			{
                xtype:'label',
                html:'&nbsp;&nbsp;单据编号'
            },
			{
				id:'billsNo',
				width: 120,
                xtype: 'textfield'
			},
			{
                xtype:'label',
                hidden:true,
                id:'purchaseUnitLabel',
                html:'&nbsp;&nbsp;购货单位'
            },
            {
                id:'purchaseUnit',
                hidden:true,
                width: 160,
                xtype: 'combo',
                displayField: 'fname',
                valueField: 'fitemId',
                store:Ext.create('Ext.data.Store', {
                    fields:['fname', 'fitemId'],
                    proxy: {
                        type: 'ajax',
                        actionMethods: {
                            read: 'POST'
                        },
                        url: '${ctx}/hg/getGhdwInfo.action',
                        reader: {
                            type: 'json'
                        }
                    },
                    autoLoad: true,
                    listeners:{
                        load:function(store, records){
                            var obj = {fitemId:-1, fname:'全部'};
                            store.insert(0, obj);
                        }
                    }
                })
            },
            {
            	xtype:'label',
            	id:'deliverStockLabel',
            	hidden:true,
            	html:'&nbsp;&nbsp;发货仓库'
            },
            {
                id:'deliverStock',
                hidden:true,
                width: 120,
                xtype: 'textfield'
            },
            {
                xtype:'label',
                id:'gysNameLabel',
                hidden:true,
                html:'&nbsp;&nbsp;供应商'
            },
            {
                id:'gysNameText',
                hidden:true,
                width: 260,
                readOnly:true,
                xtype: 'textfield',
                listeners: {
                    focus: function(){
                        getGys('gysNameText', 'gysNameHidden');
                    }
                }
            },
            {
                id:'gysNameHidden',
                hidden:true,
                xtype: 'textfield'
            },
            {
                xtype:'label',
                id:'shckNameLabel',
                hidden:true,
                html:'&nbsp;&nbsp;收货仓库'
            },
            {
                id:'shckNameText',
                hidden:true,
                width: 120,
                xtype: 'textfield'
            },
            {
                xtype:'label',
                id:'dcckNameLabel',
                hidden:true,
                html:'&nbsp;&nbsp;调出仓库'
            },
            {
                id:'dcckNameText',
                hidden:true,
                width: 120,
                xtype: 'combo',
                displayField: 'display',
                valueField: 'value',
                store:Ext.create('Ext.data.Store', {
                    fields:['display', 'value'],
                    data:[
                        {'display':'全部', 'value':'-1'},
                        {'display':'001(免税仓库)', 'value':'001'},
                        {'display':'100(机场免税店)', 'value':'100'},
                        {'display':'111(免税品待检仓)', 'value':'111'}
                    ]
                })
            },'&nbsp;',
			{
				id:'searchDicBtn',
				xtype:'button',
				disabled:false,
				text:'查询',
				iconCls:'search-button',
				handler:function(){
					var proxy = sellBillsStore.getProxy();
					proxy.setExtraParam("queryDate",Ext.getCmp("queryDate").getValue());
					proxy.setExtraParam("fbillNo",Ext.getCmp("billsNo").getValue());
					proxy.setExtraParam("gysId",Ext.getCmp("gysNameHidden").getValue());
					proxy.setExtraParam("purchaseUnitId",Ext.getCmp("purchaseUnit").getValue());
					proxy.setExtraParam("dcckNo",Ext.getCmp("dcckNameText").getValue());
					sellBillsStore.loadPage(1);
				}
			},'->',
			{
                xtype:'button',
                text:'过滤',
                iconCls:'privilege-button',
                handler:function(){
                	query();
                }
			}],
			listeners:{
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					openwin(record.get('fbillNo'), record.get('ftranType'));
				}
			}
		});
		//sellBillsStore.load({params:{start:0,limit:SystemConstant.commonSize}});
		
		query();
		
		Ext.create("Ext.container.Viewport", {
		    layout: "border",
			items: [sellBillsGrid]
		});
		
		function query(){
			var queryPanel = Ext.create('Ext.form.Panel', {
	            border: false,
	            layout: 'column',
	            fieldDefaults: {
	                labelWidth: 75,
	                width: 170,
	                labelAlign: 'right',
	                anchor: '100%'
	            },
	            items: [
				{
				    xtype:'fieldset',
				    padding: '5 0 0 0',
				    collapsible: false,
				    layout: 'column',
				    width: '100%',
				    items :[
				        {
				            columnWidth: .5,
				            border: false,
				            items: [{
				                fieldLabel: '单据类型',
				                xtype: 'combo',
				                id:'billsType',
				                displayField: 'display',
				                valueField: 'value',
				                store:Ext.create('Ext.data.Store', {
				                    fields:['display', 'value'],
				                    data:[
				                        {'display':'全部', 'value':-1},
				                        {'display':'外购入库', 'value':1},
				                        //{'display':'其他入库', 'value':10},
				                        {'display':'零售单', 'value':21},
				                        //{'display':'其他出库', 'value':29}
				                        {'display':'调拨单', 'value':41}
				                    ]
				                })
				            }]
				        }
				    ]
				},
	            {
	                xtype:'fieldset',
	                padding: '5 0 0 0',
	                collapsible: false,
	                layout: 'column',
	                width: '100%',
	                items :[
	                    {
	                        columnWidth: .5,
	                        border: false,
	                        items: [{
	                            xtype: 'textfield',
	                            fieldLabel: '起始日期',
	                            id:'startDate',
	                            readOnly:true,
	                            listeners:{
	                                "afterrender":function(com,eOpts){
	                                    var startTime=Ext.getDom("startDate-inputEl");
	                                    startTime.initcfg={dateFmt:'yyyy-MM-dd',disabledDates:[]};
	                                    startTime.style.cssText='background: url(\'${ctx }/scripts/my97DatePicker/skin/datePicker.gif\') no-repeat right #FFF;';
	                                    startTime.onclick=function(){
	                                        WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate-inputEl\')}'});
	                                    };
	                                }
	                            }
	                        }]
	                    },
	                    {
	                        columnWidth: .5,
	                        border: false,
	                        items: [{
	                            xtype: 'textfield',
	                            fieldLabel: '截止日期 ',
	                            id:'endDate',
	                            readOnly:true,
	                            listeners:{
	                                "afterrender":function(com,eOpts){
	                                    var endTime=Ext.getDom("endDate-inputEl");
	                                    endTime.initcfg={dateFmt:'yyyy-MM-dd',disabledDates:[]};
	                                    endTime.style.cssText='background: url(\'${ctx }/scripts/my97DatePicker/skin/datePicker.gif\') no-repeat right #FFF;';
	                                    endTime.onclick=function(){
	                                        WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate-inputEl\')}'});
	                                    };
	                                }
	                            }
	                        }]
	                    }
	                ]
	            },
	            {
	                xtype:'fieldset',
	                padding: '5 0 0 0',
	                collapsible: false,
	                layout: 'column',
	                width: '100%',
	                items :[
	                    {
	                        columnWidth: .5,
	                        border: false,
	                        items: [{
	                        	fieldLabel: '物料代码',
	                        	readOnly:true,
                                xtype: 'textfield',
                                id:'fnumberStart',
                                listeners: {
                                	focus: function(){
                                		getFnumber('fnumberStart');
                                    }
                                }
	                        }]
	                    },
	                    {
                            columnWidth: .5,
                            border: false,
                            items: [{
                                fieldLabel: ' 至 ',
                                readOnly:true,
                                xtype: 'textfield',
                                id:'fnumberEnd',
                                listeners: {
                                    focus: function(){
                                    	getFnumber('fnumberEnd');
                                    }
                                }
                            }]
                        }
	                ]
	            }]
	        });
	        
	        var queryWin = Ext.create('Ext.window.Window', {
	            bodyStyle: 'padding:5px 5px 5px 5px; background-color:white;',
	            title: '条件',
	            closable: true,
	            resizable: false,
	            buttonAlign: "right",
	            width: 380,
	            modal: true,
	            layout: 'fit',
	            constrain: true, //设置只能在窗口范围内拖动
	            closeAction: 'destroy',
	            items: [queryPanel],
	            buttons: [{
	                text: '确定',
	                id: 'sureBtn',
	                handler: function() {
	                	Ext.getCmp("queryDate").setValue('');
	                	Ext.getCmp("billsNo").setValue('');
	                	Ext.getCmp("gysNameText").setValue('');
	                	Ext.getCmp("gysNameHidden").setValue('');
	                    Ext.getCmp("purchaseUnit").setValue('');
	                    Ext.getCmp("dcckNameText").setValue('');
	                	
	                	sdate = Ext.getCmp('startDate').getValue();
                        edate = Ext.getCmp('endDate').getValue();
                        btype = Ext.getCmp('billsType').getValue();
                        fnumberStart = Ext.getCmp('fnumberStart').getValue();
                        fnumberEnd = Ext.getCmp('fnumberEnd').getValue();
                        
                        var billsName = '出入库';
                        if (21 == btype) {
                            billsName = '零售单';
                            Ext.getCmp('purchaseUnit').setVisible(true);
                            Ext.getCmp('purchaseUnit').setValue(-1);
                            Ext.getCmp('purchaseUnitLabel').setVisible(true);
                            Ext.getCmp('deliverStock').setVisible(false);
                            Ext.getCmp('deliverStockLabel').setVisible(false);
                            Ext.getCmp('gysNameLabel').setVisible(false);
                            Ext.getCmp('gysNameText').setVisible(false);
                            Ext.getCmp('shckNameLabel').setVisible(false);
                            Ext.getCmp('shckNameText').setVisible(false);
                            Ext.getCmp('dcckNameLabel').setVisible(false);
                            Ext.getCmp('dcckNameText').setVisible(false);
                            sellBillsGrid.reconfigure(sellBillsStore, cm);
                        }
                        else if (29 == btype) {
                            billsName = '其他出库';
                            Ext.getCmp('purchaseUnit').setVisible(false);
                            Ext.getCmp('purchaseUnitLabel').setVisible(false);
                            Ext.getCmp('deliverStock').setVisible(true);
                            Ext.getCmp('deliverStockLabel').setVisible(true);
                            Ext.getCmp('gysNameLabel').setVisible(false);
                            Ext.getCmp('gysNameText').setVisible(false);
                            Ext.getCmp('shckNameLabel').setVisible(false);
                            Ext.getCmp('shckNameText').setVisible(false);
                            Ext.getCmp('dcckNameLabel').setVisible(false);
                            Ext.getCmp('dcckNameText').setVisible(false);
                            sellBillsGrid.reconfigure(sellBillsStore, cm2);
                        }
                        else if (1 == btype) {
                        	Ext.getCmp('purchaseUnit').setVisible(false);
                            Ext.getCmp('purchaseUnitLabel').setVisible(false);
                            Ext.getCmp('deliverStock').setVisible(false);
                            Ext.getCmp('deliverStockLabel').setVisible(false);
                            Ext.getCmp('gysNameLabel').setVisible(true);
                            Ext.getCmp('gysNameText').setVisible(true);
                            Ext.getCmp('shckNameLabel').setVisible(false);
                            Ext.getCmp('shckNameText').setVisible(false);
                            Ext.getCmp('dcckNameLabel').setVisible(false);
                            Ext.getCmp('dcckNameText').setVisible(false);
                            billsName = '外购入库';
                            sellBillsGrid.reconfigure(sellBillsStore, cm3);
                        }
                        else if (10 == btype) {
                        	Ext.getCmp('purchaseUnit').setVisible(false);
                            Ext.getCmp('purchaseUnitLabel').setVisible(false);
                            Ext.getCmp('deliverStock').setVisible(false);
                            Ext.getCmp('deliverStockLabel').setVisible(false);
                            Ext.getCmp('gysNameLabel').setVisible(false);
                            Ext.getCmp('gysNameText').setVisible(false);
                            Ext.getCmp('shckNameLabel').setVisible(true);
                            Ext.getCmp('shckNameText').setVisible(true);
                            Ext.getCmp('dcckNameLabel').setVisible(false);
                            Ext.getCmp('dcckNameText').setVisible(false);
                            billsName = '其他入库';
                            sellBillsGrid.reconfigure(sellBillsStore, cm4);
                        }
                        else if (41 == btype) {
                        	Ext.getCmp('purchaseUnit').setVisible(false);
                            Ext.getCmp('purchaseUnitLabel').setVisible(false);
                            Ext.getCmp('deliverStock').setVisible(false);
                            Ext.getCmp('deliverStockLabel').setVisible(false);
                            Ext.getCmp('gysNameLabel').setVisible(false);
                            Ext.getCmp('gysNameText').setVisible(false);
                            Ext.getCmp('shckNameLabel').setVisible(false);
                            Ext.getCmp('shckNameText').setVisible(false);
                            Ext.getCmp('dcckNameLabel').setVisible(true);
                            Ext.getCmp('dcckNameText').setVisible(true);
                            Ext.getCmp('dcckNameText').setValue('-1');
                            billsName = '调拨单';
                            sellBillsGrid.reconfigure(sellBillsStore, cm6);
                        }
                        else if (-1 == btype) {
                            billsName = '出入库';
                            Ext.getCmp('purchaseUnit').setVisible(false);
                            Ext.getCmp('purchaseUnitLabel').setVisible(false);
                            Ext.getCmp('deliverStock').setVisible(false);
                            Ext.getCmp('deliverStockLabel').setVisible(false);
                            Ext.getCmp('gysNameLabel').setVisible(false);
                            Ext.getCmp('gysNameText').setVisible(false);
                            Ext.getCmp('shckNameLabel').setVisible(false);
                            Ext.getCmp('shckNameText').setVisible(false);
                            Ext.getCmp('dcckNameLabel').setVisible(false);
                            Ext.getCmp('dcckNameText').setVisible(false);
                            
                            sellBillsGrid.reconfigure(sellBillsStore, cm5);
                        }
                        
                        sellBillsGrid.setTitle(billsName);
                        
	                    var proxy = sellBillsStore.getProxy();
	                    proxy.setExtraParam('startDate',sdate);
	                    proxy.setExtraParam('endDate',edate);
	                    proxy.setExtraParam('billsType',btype);
	                    proxy.setExtraParam('fnumberStart',fnumberStart);
	                    proxy.setExtraParam('fnumberEnd',fnumberEnd);
	                    
	                    proxy.setExtraParam("queryDate",'');
	                    proxy.setExtraParam("fbillNo",'');
	                    proxy.setExtraParam("gysId",'');
	                    proxy.setExtraParam("purchaseUnitId",'');
	                    proxy.setExtraParam("dcckNo",'');
	                    sellBillsStore.loadPage(1);
	                    queryWin.close();
	                }
	            }, {
	                text: '取消',
	                id: 'cancelBtn',
	                handler: function() {
                        sellBillsGrid.reconfigure(sellBillsStore, cm5);
	                	sellBillsStore.loadPage(1);
	                    queryWin.close();
	                }
	            }],
	            listeners: {
	                afterrender: function(){
	                	if (sdate && sdate != '') {
	                		Ext.getCmp('startDate').setValue(sdate);
	                        Ext.getCmp('endDate').setValue(edate);
	                        Ext.getCmp('billsType').setValue(btype);
	                        Ext.getCmp('fnumberStart').setValue(fnumberStart);
	                        Ext.getCmp('fnumberEnd').setValue(fnumberEnd);
	                	}
	                	else {
	                		Ext.getCmp('startDate').setValue(getFirstDay());
                            Ext.getCmp('endDate').setValue(Ext.Date.format(new Date(),"Y-m-d"));
                            Ext.getCmp('billsType').setValue(-1);
	                	}
	                }
	            }
	        }).show();
		}
		
		function openwin(billsId, ftranType) {
		    var height = 600;
		    var width = 1366;
		    var h = window.screen.availHeight;
		    var w = window.screen.availWidth;
		    
		    var dh = document.body.clientHeight;
            var dw = document.body.clientWidth;
		    
		    if (w <= 1366) {
		    	width = dw - 20;
		    	height = dh;
		    }
		    
		    var y = (h - height) / 2;
            var x = (w - width) / 2;
            if (w <= 1366) {
            	x = 0;
            }
            
            /* var billsName = '销售出库单';
            if (-1 == btype || 21 == btype) {
            	billsName = '销售出库单';
            }
            else if (29 == btype) {
            	billsName = '其他出库单';
            }
            else if (1 == btype) {
            	billsName = '外购入库单';
            }
            else if (10 == btype) {
            	billsName = '其他入库单';
            } */
            
            //var url = "${ctx}/hg/toSellBillsDetail.action?billsId=" + billsId + "&billsName=" + billsName;
            //url = encodeURI(url);
            //url = encodeURI(url);
            
		    window.open("${ctx}/hg/toSellBillsDetail.action?billsId=" + billsId + "&ftranType=" + ftranType, "", 
		        "height=" + height + ", width=" + width + ", top=" + y + ", left=" + x + ", toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no, status=no");
		}
		
		function getFnumber(domId) {
			
		    Ext.define("Goods",{
		        extend:"Ext.data.Model",
		        fields:[
		            {name:"fnumber"},
		            {name:"fname"},
		            {name:"fmodel"},
		            {name:"unit"},
		            {name:"fbarCode"}
		         ]
		    });
		    
		    //行选择模型
		    var smSingle=Ext.create("Ext.selection.CheckboxModel",{
		        injectCheckbox:1,
		        mode : 'SINGLE',
		        listeners: {
		            selectionchange: function(){
		                var rows = Ext.getCmp('goodsPanel').getSelectionModel().getSelection();
		                if(rows.length > 0){
		                    Ext.getCmp('goodsOk').setDisabled(false);
		                }else{
		                    Ext.getCmp('goodsOk').setDisabled(true);
		                }
		            }
		        }
		    });
		          
		    var goodsCm=[
		        {xtype: "rownumberer",text:"序号",width:60,align:"center"},
		        {header: "物料代码",width: 150,align:'center',dataIndex: "fnumber",menuDisabled: true,sortable:false},
		        {header: "物料名称",width: 150,align:'center',dataIndex: "fname",menuDisabled: true,sortable:false},
		        {header: "规格型号",width: 80,align:'center',dataIndex: "fmodel",menuDisabled: true,sortable:false},
		        {header: "单位",width: 60,align:'center',dataIndex: "unit",menuDisabled: true,sortable:false},
		        {header: "条形码",width: 120,align:'center',dataIndex: "fbarCode",menuDisabled: true,sortable:false}
		    ];

		    var goodsStore = Ext.create('Ext.data.Store', {
		        pageSize: SystemConstant.commonSize,
		        model: 'Goods',
		        proxy: {
		            type: 'ajax',
		            actionMethods: {
		                read: 'POST'
		            },
		            url: '${ctx}/hg/getGoodsInfo.action',
		            reader:{
		                type: 'json',
		                root: 'list',
		                totalProperty:"totalSize"
		            },
		            autoLoad: true
		        }
		    });

		    goodsPanel = Ext.create('Ext.grid.Panel',{
		        //title:'物料信息',
		        id: "goodsPanel",
		        layout:"fit",
		        stripeRows: true,
		        border:false,
		        forceFit:false,
		        columnLines: true,
		        autoScroll: true,
		        store : goodsStore,
		        selModel:smSingle,
		        columns:goodsCm,
		        tbar:[
                '物料名称',
		        {
		        	xtype: 'textfield',
		        	width:'160',
                    id:'goodsName'
		        },
		        '&nbsp;&nbsp;',
		        {
                    text :   "查询", 
                    iconCls: "search-button", 
                    handler:function(){
                        var proxy = goodsStore.getProxy();
                        proxy.setExtraParam("goodsName",Ext.getCmp('goodsName').getValue());
                        goodsStore.loadPage(1);
                    } 
                }],
		        bbar:new Ext.PagingToolbar({
		            pageSize: SystemConstant.commonSize,
		            store: goodsStore,
		            displayInfo: true,
		            displayMsg: SystemConstant.displayMsg,
		            emptyMsg: SystemConstant.emptyMsg
		        })
		    });
		                    
		    //用户分配角色窗口
		    goodsWin = Ext.create(Ext.window.Window,{
		        title:"选择物料",
		        width:680,
		        height:400,
		        modal:true,
		        resizable:false,
		        layout:"fit",
		        closeAction:'destroy',
		        items:[goodsPanel],
		        buttonAlign : 'center',
		        buttons:[{
		            id:'goodsOk',
		            text:'确定',
		            disabled:true,
		            handler:function(){
		                var rows = Ext.getCmp('goodsPanel').getSelectionModel().getSelection();
		                Ext.getCmp(domId + '').setValue(rows[0].get("fnumber"));
		                goodsWin.close();
		            }
		        },{
                    text:'清空',
                    handler:function(){
                        Ext.getCmp(domId + '').setValue('');
                        goodsWin.close();
                    }
                },{
		            text:'取消',handler:function(){
		            	goodsWin.close();
		        }}
		        ]
		    }).show();
		    
		    goodsStore.loadPage(1);
		}
		
	    function getGys(domId, hiddenId) {
            
            Ext.define("Gys",{
                extend:"Ext.data.Model",
                fields:[
                    {name:"fitemId"},
                    {name:"fname"},
                    {name:"fnumber"},
                    {name:"faddress"}
                 ]
            });
            
            //行选择模型
            var smSingle=Ext.create("Ext.selection.CheckboxModel",{
                injectCheckbox:1,
                mode : 'SINGLE',
                listeners: {
                    selectionchange: function(){
                        var rows = Ext.getCmp('gysPanel').getSelectionModel().getSelection();
                        if(rows.length > 0){
                            Ext.getCmp('gysOk').setDisabled(false);
                        }else{
                            Ext.getCmp('gysOk').setDisabled(true);
                        }
                    }
                }
            });
                  
            var gysCm=[
                {xtype: "rownumberer",text:"序号",width:60,align:"center"},
                {header: "ID",hidden:true,dataIndex: "fitemId",menuDisabled: true,sortable:false},
                {header: "供应商名称",width: 260,align:'center',dataIndex: "fname",menuDisabled: true,sortable:false},
                {header: "供应商编号",width: 100,align:'center',dataIndex: "fnumber",menuDisabled: true,sortable:false},
                {header: "地址",width: 200,align:'center',dataIndex: "faddress",menuDisabled: true,sortable:false}
            ];

            var gysStore = Ext.create('Ext.data.Store', {
                pageSize: SystemConstant.commonSize,
                model: 'Gys',
                proxy: {
                    type: 'ajax',
                    actionMethods: {
                        read: 'POST'
                    },
                    url: '${ctx}/hg/getGysInfo.action',
                    reader:{
                        type: 'json',
                        root: 'list',
                        totalProperty:"totalSize"
                    },
                    autoLoad: true
                }
            });

            gysPanel = Ext.create('Ext.grid.Panel',{
                //title:'物料信息',
                id: "gysPanel",
                layout:"fit",
                stripeRows: true,
                border:false,
                forceFit:false,
                columnLines: true,
                autoScroll: true,
                store : gysStore,
                selModel:smSingle,
                columns:gysCm,
                tbar:[
                '供应商名称',
                {
                    xtype: 'textfield',
                    width:'200',
                    id:'gysName'
                },
                '&nbsp;&nbsp;',
                {
                    text :   "查询", 
                    iconCls: "search-button", 
                    handler:function(){
                        var proxy = gysStore.getProxy();
                        proxy.setExtraParam("gysName",Ext.getCmp('gysName').getValue());
                        gysStore.loadPage(1);
                    } 
                }],
                bbar:new Ext.PagingToolbar({
                    pageSize: SystemConstant.commonSize,
                    store: gysStore,
                    displayInfo: true,
                    displayMsg: SystemConstant.displayMsg,
                    emptyMsg: SystemConstant.emptyMsg
                })
            });
                            
            //用户分配角色窗口
            gysWin = Ext.create(Ext.window.Window,{
                title:"选择物料",
                width:630,
                height:400,
                modal:true,
                resizable:false,
                layout:"fit",
                closeAction:'destroy',
                items:[gysPanel],
                buttonAlign : 'center',
                buttons:[{
                    id:'gysOk',
                    text:'确定',
                    disabled:true,
                    handler:function(){
                        var rows = Ext.getCmp('gysPanel').getSelectionModel().getSelection();
                        Ext.getCmp(domId + '').setValue(rows[0].get("fname"));
                        Ext.getCmp(hiddenId + '').setValue(rows[0].get("fitemId"));
                        gysWin.close();
                    }
                },{
                    text:'清空',
                    handler:function(){
                    	Ext.getCmp(domId + '').setValue('');
                        Ext.getCmp(hiddenId + '').setValue('');
                        gysWin.close();
                    }
                },{
                    text:'取消',
                    handler:function(){
                    	gysWin.close();
                    }
                }
                ]
            }).show();
            
            gysStore.loadPage(1);
        }
		
		function getFirstDay(){
		    var year = new Date().getFullYear();
		    var month = new Date().getMonth();
		    month += 1;
		    if(month < 10){
		        month = "0" + month;
		    }
		    return year + "-" + month + "-01";
		}
	});
	</script>
</body>
</html>