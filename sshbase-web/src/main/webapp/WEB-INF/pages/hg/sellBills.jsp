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
		//建立Model模型对象
		Ext.define("SellBills",{
			extend:"Ext.data.Model",
			fields:[
				{name: "finterId"}, 
				{name: "fdate"}, 
				{name: "fsupplyId"}, 
				{name: "fdCStockId"},
				{name: "fitemName"},
				{name: "fitemModel"},
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
                {name: "fbillNo"}
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
	            {header: "日期",width: 120,dataIndex: "fdate",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "审核标志",width: 100,dataIndex: "",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "购货单位",width: 80,dataIndex: "ghcustom",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "发货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
                {header: "产品长代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }},
                {header: "产品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "规格型号",width: 100,dataIndex: "fitemModel",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "单位",width: 80,dataIndex: "unit",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "实发数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "单位成本",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "成本",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "部门",width: 100,dataIndex: "deptName",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "业务员",width: 100,dataIndex: "userName",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "销售单价",width: 100,dataIndex: "fconsignPrice",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                },
                {header: "销售金额",width: 100,dataIndex: "fconsignAmount",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }
                }
	         ];
		
		/* var typeNameStore = Ext.create('Ext.data.Store', {
		     model: 'Dict',
		     proxy: {
		         type: 'ajax',
		         url: '${ctx}/dict/getDictTypes.action',
		         reader: {
		             type: 'json'
		         }
		     },
		     autoLoad: true,
		     listeners:{
		     		load:function(store,records,eOpts){
		     			var data = [{dictionaryId:"",dictionaryName:"全部"}];
		     			for(var i = 0; i < records.length; i++){
		     				var id = records[i].get("pkDictionaryId");
		     				var name = records[i].get("dictionaryName");
		     				data.push({pkDictionaryId:id,dictionaryName:name});
		     			}
		     			store.loadData(data);
		     		}
		     	}

		}); */
		
		//grid组件
		var sellBillsGrid =  Ext.create("Ext.grid.Panel",{
			title:'零售单查询',
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
		        value:getFirstDay(),
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
					proxy.setExtraParam("dictName",Ext.getCmp("dictName").getValue());
					var dictType = Ext.getCmp("typeCombox").getValue();
					if(dictType=='全部') {
						dictType = '';
					}
					
					proxy.setExtraParam("dictType",dictType);
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
					openwin(0);
				}
			}
		});
		sellBillsStore.load({params:{start:0,limit:SystemConstant.commonSize}});
		
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
	                            value:getFirstDay(),
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
	                            value:Ext.Date.format(new Date(),"Y-m-d"),
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
	                        columnWidth: .6,
	                        border: false,
	                        items: [{
	                            xtype: 'textfield',
	                            labelWidth: 95,
	                            width: 195,
	                            fieldLabel: '物料代码',
	                            id:'startMaterialCode'
	                        },{
	                            xtype: 'textfield',
	                            labelWidth: 95,
	                            width: 195,
	                            fieldLabel: '客户代码',
	                            id:'startClientCode'
	                        },{
	                            fieldLabel: '销售方式',
	                            labelWidth: 95,
	                            width: 195,
	                            xtype: 'combo',
	                            id: 'sellWay'
	                        }]
	                    },
	                    {
	                        columnWidth: .4,
	                        border: false,
	                        items: [{
	                            xtype: 'textfield',
	                            labelWidth: 40,
	                            width: 145,
	                            fieldLabel: '至 ',
	                            id:'endMaterialCode'
	                        },{
	                            xtype: 'textfield',
	                            labelWidth: 40,
	                            width: 145,
	                            fieldLabel: '至 ',
	                            id:'endClientCode'
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
                            columnWidth: .3,
                            border: false,
                            items: [{
                                xtype: 'checkbox',
                                margin:'0 0 0 30',
                                boxLabel: '分级汇总'
                            },{
                                xtype: 'checkbox',
                                margin:'0 0 0 30',
                                boxLabel: '仅显示汇总行'
                            }]
                        },
                        {
                            columnWidth: .7,
                            border: false,
                            items: [{
                                fieldLabel: '单据状态',
                                labelWidth: 60,
                                width: 140,
                                xtype: 'combo'
                            },{
                                fieldLabel: '单据类型 ',
                                labelWidth: 60,
                                width: 140,
                                xtype: 'combo'
                            },{
                                fieldLabel: '订单来源',
                                labelWidth: 60,
                                width: 140,
                                xtype: 'combo'
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
	                    
	                }
	            }, {
	                text: '取消',
	                id: 'cancelBtn',
	                handler: function() {
	                    queryWin.close();
	                }
	            }],
	            listeners: {
	                render: function(){
	                    
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
		    
		    window.open("${ctx}/hg/toRetailBillsDetail.action?billsId=" + billsId, "", 
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