<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>零售单明细</title>
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
		
		var billsName = '<s:property value="billsName" />';
		billsName = decodeURI(billsName);
		var billsId = '<s:property value="billsId" />';
		var hasSet = false;
		
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
            id: "sellBillsGrid",
            bbar:  Ext.create("Ext.PagingToolbar", {
                store: sellBillsStore,
                displayInfo: true,
                displayMsg: SystemConstant.displayMsg,
                emptyMsg: SystemConstant.emptyMsg
            }),
            columns:cm,
            forceFit : false,
            store: sellBillsStore,
            autoScroll: true,
            stripeRows: true
        });
        
		
		var queryPanel = Ext.create('Ext.form.Panel', {
            border: false,
            region: "north",
            layout: 'column',
            fieldDefaults: {
                labelWidth: 100,
                width: 300,
                labelAlign: 'right',
                readOnly:true,
                anchor: '100%'
            },
            items: [{
                columnWidth: 1,
                bodyStyle: 'padding:10px 0px 8px 600px;font-size:16px;font-weight:bold;',
                border: false,
                items: [{
                    xtype: 'label',
                    text: billsName
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '收款日期'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '交货地点 '
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'ghcustom',
                    fieldLabel: '购货单位'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '整单折扣率'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '销售方式'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '摘要 '
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fbillNo',
                    fieldLabel: '编号'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '原单类型'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fdate',
                    fieldLabel: '日期'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'stockName',
                    fieldLabel: '发货仓库'
                }]
            }]
        });
		
		
		var proxy = sellBillsStore.getProxy();
        proxy.setExtraParam("forDetail","forDetail");
        proxy.setExtraParam("billsId",billsId);
        sellBillsStore.load(function(records){
        	if (records.length > 0 && !hasSet) {
        		var r = records[0];
        		Ext.getCmp('ghcustom').setValue(r.get('ghcustom'));
        		Ext.getCmp('fbillNo').setValue(r.get('fbillNo'));
        		Ext.getCmp('fdate').setValue(r.get('fdate'));
        		Ext.getCmp('stockName').setValue(r.get('stockName'));
        		
        		hasSet = true;
        	}
        });
		
		Ext.create("Ext.container.Viewport", {
		    layout: "border",
			items: [queryPanel,sellBillsGrid]
		});
	});
	</script>
</body>
</html>