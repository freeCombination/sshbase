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
		var cflag = '';
		
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
                {name: "fbarCode"}
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
		
		var cm=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false},
                {header: "审核标志",width: 90,dataIndex: "fcheckFlag",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "购货单位",width: 100,dataIndex: "ghcustom",menuDisabled: true,sortable :false},
                {header: "发货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "产品长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "产品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                {header: "实发数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "单位成本",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "成本",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "部门",width: 100,dataIndex: "deptName",menuDisabled: true,sortable :false},
                {header: "业务员",width: 90,dataIndex: "userName",menuDisabled: true,sortable :false},
                {header: "销售单价",width: 100,dataIndex: "fconsignPrice",menuDisabled: true,sortable :false},
                {header: "销售金额",width: 100,dataIndex: "fconsignAmount",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false}
             ];
		
		//grid组件
		var sellBillsGrid =  Ext.create("Ext.grid.Panel",{
			//title:'零售单查询',
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
			columns:cm,
	     	forceFit : true,
			store: sellBillsStore,
			autoScroll: true,
			stripeRows: true,
			tbar: ['日期',
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
			},'&nbsp;单据编号',
			{
				id:'billsNo',
				width: 120,
                xtype: 'textfield'
			},'&nbsp;购货单位',
            {
                id:'purchaseUnit',
                width: 120,
                xtype: 'textfield'
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
					sellBillsStore.loadPage(1);
				}
			},'->',
			{
				id:'addDicBtn',
                xtype:'button',
                disabled:false,
                text:'过滤',
                iconCls:'add-button',
                handler:function(){
                	query();
                }
			}],
			listeners:{
				itemdblclick:function(grid, record, item, index, e, eOpts ){
					openwin(record.get('fbillNo'));
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
	            items: [{
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
                                        {'display':'其他入库', 'value':10},
                                        {'display':'销售出库', 'value':21},
                                        {'display':'其他出库', 'value':29}
                                    ]
                                })
	                        }]
	                    },
	                    {
	                        columnWidth: .5,
	                        border: false,
	                        items: [{
	                        	fieldLabel: '审核标志',
                                xtype: 'combo',
                                id:'checkFlag',
                                displayField: 'display',
                                valueField: 'value',
                                store:Ext.create('Ext.data.Store', {
                                    fields:['display', 'value'],
                                    data:[
                                        {'display':'全部', 'value':'A'},
                                        {'display':'Y', 'value':'Y'},
                                        {'display':'N', 'value':'N'},
                                    ]
                                })
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
	                	sdate = Ext.getCmp('startDate').getValue();
                        edate = Ext.getCmp('endDate').getValue();
                        btype = Ext.getCmp('billsType').getValue();
                        cflag = Ext.getCmp('checkFlag').getValue();
	                	
	                    var proxy = sellBillsStore.getProxy();
	                    proxy.setExtraParam('startDate',sdate);
	                    proxy.setExtraParam('endDate',edate);
	                    proxy.setExtraParam('billsType',btype);
	                    proxy.setExtraParam('checkFlag',cflag);
	                    proxy.setExtraParam("queryDate",'');
	                    sellBillsStore.loadPage(1);
	                    queryWin.close();
	                }
	            }, {
	                text: '取消',
	                id: 'cancelBtn',
	                handler: function() {
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
	                        Ext.getCmp('checkFlag').setValue(cflag);
	                	}
	                	else {
	                		Ext.getCmp('startDate').setValue(getFirstDay());
                            Ext.getCmp('endDate').setValue(Ext.Date.format(new Date(),"Y-m-d"));
                            Ext.getCmp('billsType').setValue(-1);
                            Ext.getCmp('checkFlag').setValue('A');
	                	}
	                }
	            }
	        }).show();
		}
		
		function openwin(billsId) {
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
		    
            var url = "${ctx}/hg/toSellBillsDetail.action?billsId=" + billsId + "&billsName=销售出库单";
            url = encodeURI(url);
            url = encodeURI(url);
            
		    window.open(url, "", 
		        "height=" + height + ", width=" + width + ", top=" + y + ", left=" + x + ", toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no, status=no");
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