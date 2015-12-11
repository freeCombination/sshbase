<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>出入库明细单</title>
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
		
		//var billsName = '<s:property value="billsName" />';
		//billsName = decodeURI(billsName);
		var billsId = '<s:property value="billsId" />';
		var btype = '<s:property value="ftranType" />';
		var hasSet = false;
		
		//建立Model模型对象
		Ext.define("SellBills",{
            extend:"Ext.data.Model",
            fields:[
                {name: "ftranType"},
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
                
                {name: "fshortNumber"},
                {name: "fauxQtyMust"}, 
                {name: "fsecUnitName"}, 
                {name: "fsecCoefficient"},
                {name: "fsecQty"},
                {name: "fauxPlanPrice"},
                {name: "fplanAmount"}, 
                {name: "fnote"}, 
                {name: "fkfDate"}, 
                {name: "fkfPeriod"},
                {name: "fperiodDate"},
                {name: "fdiscountRate"},
                {name: "fsourceBillNo"},
                {name: "fcontractBillNo"}, 
                {name: "forderBillNo"},
                {name: "forderEntryId"},
                {name: "fsecInvoiceQty"},
                {name: "fauxQtyInvoice"},
                {name: "fclientOrderNo"},
                {name: "fconfirmMemEntry"},
                {name: "fclientEntryId"},
                {name: "fchkPassItem"},
                {name: "fsettleDate"},
                {name: "ffetchAdd"},
                {name: "fholisticDiscountRate"},
                {name: "fsaleStyle"},
                {name: "fexplanation"},
                {name: "fselTranType"},
                
                {name: "fitemId"},
                {name: "fitemTypeName"},
                {name: "fcomBrandName"},
                
                {name: "fsupplyName"},
                {name: "fentrySelfA0164"},
                {name: "fentrySelfA0162"},
                {name: "fentrySelfA0163"},
                {name: "fentrySelfA0165"},
                {name: "fentrySelfA0166"},
                {name: "fsManagerName"}
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
                {header: "产品代码",width: 90,dataIndex: "fshortNumber",menuDisabled: true,sortable :false},
                {header: "条形码",width: 120,dataIndex: "fbarCode",menuDisabled: true,sortable :false},
                {header: "产品名称",width:160,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "辅助属性",width: 100,dataIndex: "",menuDisabled: true,sortable :false},
                {header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "应发数量",width: 100,dataIndex: "fauxQtyMust",menuDisabled: true,sortable :false},
                {header: "实发数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "辅助单位",width: 90,dataIndex: "fsecUnitName",menuDisabled: true,sortable :false},
                {header: "换算率",width: 100,dataIndex: "fsecCoefficient",menuDisabled: true,sortable :false},
                {header: "辅助数量",width: 100,dataIndex: "fsecQty",menuDisabled: true,sortable :false},
                {header: "计划单价",width: 100,dataIndex: "fauxPlanPrice",menuDisabled: true,sortable :false},
                {header: "计划价金额",width: 100,dataIndex: "fplanAmount",menuDisabled: true,sortable :false},
                {header: "单位成本",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "成本",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "备注",width: 100,dataIndex: "fnote",menuDisabled: true,sortable :false},
                {header: "生产/采购日期",width: 120,dataIndex: "fkfDate",menuDisabled: true,sortable :false},
                {header: "保质期(天)",width: 90,dataIndex: "fkfPeriod",menuDisabled: true,sortable :false},
                {header: "有效期至",width: 100,dataIndex: "fperiodDate",menuDisabled: true,sortable :false},
                {header: "仓位",width: 100,dataIndex: "",menuDisabled: true,sortable :false},
                {header: "销售单价",width: 100,dataIndex: "fconsignPrice",menuDisabled: true,sortable :false},
                {header: "折扣率(%)",width: 100,dataIndex: "fdiscountRate",menuDisabled: true,sortable :false},
                {header: "销售金额",width: 100,dataIndex: "fconsignAmount",menuDisabled: true,sortable :false},
                {header: "源单单号",width: 100,dataIndex: "fsourceBillNo",menuDisabled: true,sortable :false},
                {header: "合同单号",width: 100,dataIndex: "fcontractBillNo",menuDisabled: true,sortable :false},
                {header: "订单单号",width: 100,dataIndex: "forderBillNo",menuDisabled: true,sortable :false},
                {header: "订单分录",width: 100,dataIndex: "forderEntryId",menuDisabled: true,sortable :false},
                {header: "辅助单位开票数量",width: 120,dataIndex: "fsecInvoiceQty",menuDisabled: true,sortable :false},
                {header: "开票数量",width: 90,dataIndex: "fauxQtyInvoice",menuDisabled: true,sortable :false},
                {header: "客户订单号",width: 90,dataIndex: "fclientOrderNo",menuDisabled: true,sortable :false},
                {header: "对账确认意见(表体)",width: 120,dataIndex: "fconfirmMemEntry",menuDisabled: true,sortable :false},
                {header: "订单行号",width: 90,dataIndex: "fclientEntryId",menuDisabled: true,sortable :false},
                {header: "检验是否良品",width: 120,dataIndex: "fchkPassItem",menuDisabled: true,sortable :false}
             ];
        
        // 其他出库
        var cm2=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "商品编码",width: 90,dataIndex: "fshortNumber",menuDisabled: true,sortable :false},//fitemId
                {header: "条形码",width: 120,dataIndex: "fbarCode",menuDisabled: true,sortable :false},
                {header: "商品名称",width:160,dataIndex: "fname",menuDisabled: true,sortable :false},//fitemName
                {header: "商品类别",width: 100,dataIndex: "fitemTypeName",menuDisabled: true,sortable :false},
                {header: "商品品牌",width: 100,dataIndex: "fcomBrandName",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "应出库数量",width: 100,dataIndex: "fauxQtyMust",menuDisabled: true,sortable :false},
                {header: "实出库数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "单价",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "金额",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "备注",width: 100,dataIndex: "fnote",menuDisabled: true,sortable :false},
                {header: "发货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "仓位",width: 100,dataIndex: "",menuDisabled: true,sortable :false},
                {header: "源单单号",width: 100,dataIndex: "fsourceBillNo",menuDisabled: true,sortable :false}
             ];
        
        // 外购入库
        var cm3=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "商品编码",width: 140,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false},
                {header: "商品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "商品类别",width: 100,dataIndex: "fitemTypeName",menuDisabled: true,sortable :false},
                {header: "商品品牌",width: 100,dataIndex: "fcomBrandName",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                {header: "应收数量",width: 100,dataIndex: "fauxQtyMust",menuDisabled: true,sortable :false},
                {header: "实收数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "保质期(天)",width: 90,dataIndex: "fkfPeriod",menuDisabled: true,sortable :false},
                {header: "单价",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "金额",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "收货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "源单单号",width: 100,dataIndex: "fsourceBillNo",menuDisabled: true,sortable :false},
                {header: "订单单号",width: 100,dataIndex: "forderBillNo",menuDisabled: true,sortable :false},
                {header: "销售价格",width:100,dataIndex: "fentrySelfA0164",menuDisabled: true,sortable :false},
                {header: "销售价金额",width: 100,dataIndex: "fentrySelfA0162",menuDisabled: true,sortable :false},
                {header: "进销价差额",width: 100,dataIndex: "fentrySelfA0163",menuDisabled: true,sortable :false},
                {header: "关联数量",width: 120,dataIndex: "fentrySelfA0165",menuDisabled: true,sortable :false},
                {header: "是否关联完毕",width: 120,dataIndex: "fentrySelfA0166",menuDisabled: true,sortable :false},
                {header: "门店销售价",width: 100,dataIndex: "",menuDisabled: true,sortable :false}
             ];
        
        // 其他入库
        var cm4=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                //{header: "ID",dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
                {header: "商品编码",width: 140,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "条形码",width: 100,dataIndex: "fbarCode",menuDisabled: true,sortable :false},
                {header: "商品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "商品类别",width: 100,dataIndex: "fitemTypeName",menuDisabled: true,sortable :false},
                {header: "商品品牌",width: 100,dataIndex: "fcomBrandName",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "辅助属性",width: 100,dataIndex: "",menuDisabled: true,sortable :false},
                {header: "辅助单位",width: 90,dataIndex: "fsecUnitName",menuDisabled: true,sortable :false},
                {header: "换算率",width: 100,dataIndex: "fsecCoefficient",menuDisabled: true,sortable :false},
                {header: "辅助数量",width: 100,dataIndex: "fsecQty",menuDisabled: true,sortable :false},
                {header: "单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "应收数量",width: 100,dataIndex: "fauxQtyMust",menuDisabled: true,sortable :false},
                {header: "实收数量",width: 100,dataIndex: "fauxqty",menuDisabled: true,sortable :false},
                {header: "单价",width: 100,dataIndex: "fauxprice",menuDisabled: true,sortable :false},
                {header: "收货仓库",width: 100,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "仓位",width: 100,dataIndex: "",menuDisabled: true,sortable :false},
                {header: "源单单号",width: 100,dataIndex: "fsourceBillNo",menuDisabled: true,sortable :false},
                {header: "备注",width: 100,dataIndex: "fnote",menuDisabled: true,sortable :false},
                {header: "检验是否良品",width: 120,dataIndex: "fchkPassItem",menuDisabled: true,sortable :false}
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
                    id:'ftranType',
                    text: ''
                }]
            },
            // 其他出库单：部门
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'deptName',
                    hidden:true,
                    fieldLabel: '部门'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'fsManagerName',
                    fieldLabel: '发货人 '
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fsettleDate',
                    fieldLabel: '收款日期'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'ffetchAdd',
                    fieldLabel: '交货地点'
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
                    id:'fholisticDiscountRate',
                    fieldLabel: '整单折扣率'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fsaleStyle',
                    fieldLabel: '销售方式'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fexplanation',
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
                    id:'fselTranType',
                    fieldLabel: '源单类型'
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
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'gysName',
                    fieldLabel: '供应商'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'stockNameGet',
                    fieldLabel: '收货仓库'
                }]
            }]
        });
		
		var billsName = '销售出库单';
        if (21 == btype) {
            sellBillsGrid.reconfigure(sellBillsStore, cm);
            billsName = '销售出库单';
        }
        else if (29 == btype) {
            Ext.getCmp('fsettleDate').setVisible(false);
            Ext.getCmp('deptName').setVisible(true);
            Ext.getCmp('fexplanation').setVisible(false);
            Ext.getCmp('fsaleStyle').setVisible(false);
            Ext.getCmp('fholisticDiscountRate').setVisible(false);
            Ext.getCmp('ghcustom').setVisible(false);
            Ext.getCmp('ffetchAdd').setVisible(false);
            Ext.getCmp('stockNameGet').setVisible(false);
            Ext.getCmp('gysName').setVisible(false);
            sellBillsGrid.reconfigure(sellBillsStore, cm2);
            billsName = '其他出库单';
        }
        else if (1 == btype) {
            Ext.getCmp('fsettleDate').setVisible(false);
            Ext.getCmp('deptName').setVisible(false);
            Ext.getCmp('fsaleStyle').setVisible(false);
            Ext.getCmp('fholisticDiscountRate').setVisible(false);
            Ext.getCmp('ghcustom').setVisible(false);
            Ext.getCmp('ffetchAdd').setVisible(false);
            Ext.getCmp('stockName').setVisible(false);
            
            Ext.getCmp('stockNameGet').setVisible(true);
            Ext.getCmp('gysName').setVisible(true);
            sellBillsGrid.reconfigure(sellBillsStore, cm3);
            billsName = '外购入库单';
        }
        else if (10 == btype) {
            Ext.getCmp('deptName').setVisible(true);
            Ext.getCmp('fsManagerName').setVisible(true);
            Ext.getCmp('stockNameGet').setVisible(true);
            
            Ext.getCmp('gysName').setVisible(false);
            Ext.getCmp('fsettleDate').setVisible(false);
            Ext.getCmp('fsaleStyle').setVisible(false);
            Ext.getCmp('fholisticDiscountRate').setVisible(false);
            Ext.getCmp('ghcustom').setVisible(false);
            Ext.getCmp('ffetchAdd').setVisible(false);
            Ext.getCmp('stockName').setVisible(false);
            
            sellBillsGrid.reconfigure(sellBillsStore, cm4);
            billsName = '其他入库单';
        }
        
        Ext.getCmp('ftranType').setText(billsName);
		
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
        		Ext.getCmp('fsettleDate').setValue(r.get('fsettleDate'));
        		Ext.getCmp('ffetchAdd').setValue(r.get('ffetchAdd'));
        		Ext.getCmp('fholisticDiscountRate').setValue(r.get('fholisticDiscountRate'));
        		Ext.getCmp('fsaleStyle').setValue(r.get('fsaleStyle'));
        		Ext.getCmp('fexplanation').setValue(r.get('fexplanation'));
        		Ext.getCmp('fselTranType').setValue(r.get('fselTranType'));
        		Ext.getCmp('deptName').setValue(r.get('deptName'));
        		Ext.getCmp('stockNameGet').setValue(r.get('stockName'));
        		Ext.getCmp('gysName').setValue(r.get('fsupplyName'));
        		Ext.getCmp('fsManagerName').setValue(r.get('fsManagerName'));
        		
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