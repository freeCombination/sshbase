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
        
        //var billsName = '<s:property value="billsName" />';
        //billsName = decodeURI(billsName);
        var billsId = '<s:property value="billsId" />';
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
                {name: "fsManagerName"},
                
                {name: "fbillType"},
                {name: "fbranchShop"},
                {name: "fcashier"},
                {name: "fpos"},
                {name: "fshift"},
                {name: "ftotalAmount"},
                {name: "fdiscountAmount"},
                {name: "freceAmount"},
                {name: "fbeginTime"},
                {name: "fendTime"},
                {name: "fcollectMode"},
                {name: "customName"},
                {name: "fqty"},
                {name: "fprice"},
                {name: "fdiscountPrice"},
                {name: "fbalAmount"},
                {name: "fdiscountReason"},
                
                {name: "fkfDateStr"},
                {name: "fsettleName"},
                {name: "fsettleAmount"},
                {name: "famountxf"},
                {name: "fcurrency"},
                {name: "frate"},
                {name: "fcardType"},
                {name: "fcardNo"},
                {name: "freferenceNo"},
                {name: "fcardNumber"},
                {name: "fcardTypeName"},
                {name: "faccount"},
                {name: "faccountSubId"},
                {name: "fcustomName"},
                {name: "faddress"},
                {name: "flinkman"},
                {name: "flinkTel"},
                {name: "flinkPhone"},
                {name: "freserve1"},
                {name: "freserve2"},
                {name: "freserve3"}
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
                url: "${ctx}/hg/getRetail.action",
                reader: {
                     totalProperty: "totalSize",
                     root: "list"
                },
                simpleSortMode :true
            }
        });
        
        var goodsStore=Ext.create("Ext.data.Store", {
            pageSize: SystemConstant.commonSize,
            model:"SellBills",
            proxy: {
                type:"ajax",
                actionMethods: {
                    read: 'POST'
                },
                url: "${ctx}/hg/getRetailGoods.action",
                reader: {
                     totalProperty: "totalSize",
                     root: "list"
                },
                simpleSortMode :true
            }
        });
        
        var settleTypeStore=Ext.create("Ext.data.Store", {
            pageSize: SystemConstant.commonSize,
            model:"SellBills",
            proxy: {
                type:"ajax",
                actionMethods: {
                    read: 'POST'
                },
                url: "${ctx}/hg/getRetailSettleType.action",
                reader: {
                     totalProperty: "totalSize",
                     root: "list"
                },
                simpleSortMode :true
            }
        });
        
        var cm=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "仓库",width: 90,dataIndex: "stockName",menuDisabled: true,sortable :false},
                {header: "商品编码",width: 140,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "商品条码",width: 120,dataIndex: "fbarCode",menuDisabled: true,sortable :false},
                {header: "产品名称",width:160,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "销售单位",width: 70,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "数量",width: 100,dataIndex: "fqty",menuDisabled: true,sortable :false},
                {header: "原价",width: 100,dataIndex: "fprice",menuDisabled: true,sortable :false},
                {header: "实价",width: 100,dataIndex: "fdiscountPrice",menuDisabled: true,sortable :false},
                {header: "应付金额",width: 100,dataIndex: "famount",menuDisabled: true,sortable :false},
                {header: "实付金额",width: 100,dataIndex: "fbalAmount",menuDisabled: true,sortable :false},
                {header: "商品打折率",width: 100,dataIndex: "fdiscountRate",menuDisabled: true,sortable :false},
                //{header: "打折原因",width: 100,dataIndex: "fdiscountReason",menuDisabled: true,sortable :false},
                {header: "营业员",width: 100,dataIndex: "userName",menuDisabled: true,sortable :false}
                //{header: "批号",width: 100,dataIndex: "fbatchNo",menuDisabled: true,sortable :false},
                //{header: "生产/采购日期",width: 120,dataIndex: "fkfDateStr",menuDisabled: true,sortable :false},
                //{header: "保质期(天)",width: 90,dataIndex: "fkfPeriod",menuDisabled: true,sortable :false}
             ];
        
        var cm2=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "结算方式",width: 90,dataIndex: "fsettleName",menuDisabled: true,sortable :false},
                {header: "结算金额",width: 120,dataIndex: "fsettleAmount",menuDisabled: true,sortable :false},
                {header: "卡类别",width:100,dataIndex: "fcardType",menuDisabled: true,sortable :false},
                {header: "卡号码",width: 120,dataIndex: "fcardNo",menuDisabled: true,sortable :false},
                {header: "银行卡交易参考号",width: 120,dataIndex: "freferenceNo",menuDisabled: true,sortable :false},
                {header: "消费金额",width:100,dataIndex: "famountxf",menuDisabled: true,sortable :false},
                {header: "币别",width: 100,dataIndex: "fcurrency",menuDisabled: true,sortable :false},
                {header: "汇率",width: 100,dataIndex: "frate",menuDisabled: true,sortable :false}
             ];
        
        var cm3=[
                 {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                 {header: "卡号",width: 90,dataIndex: "fcardNumber",menuDisabled: true,sortable :false},
                 {header: "卡类型",width: 120,dataIndex: "fcardTypeName",menuDisabled: true,sortable :false},
                 {header: "卡种类",width:160,dataIndex: "",menuDisabled: true,sortable :false},
                 {header: "账户名称",width: 100,dataIndex: "faccount",menuDisabled: true,sortable :false},
                 {header: "子账户号",width: 100,dataIndex: "faccountSubId",menuDisabled: true,sortable :false},
                 {header: "卡级别",width: 100,dataIndex: "",menuDisabled: true,sortable :false},
                 {header: "会员编号",width: 70,dataIndex: "",menuDisabled: true,sortable :false}
              ];
        
        var cm4=[
                 {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                 {header: "顾客姓名",width: 120,dataIndex: "fcustomName",menuDisabled: true,sortable :false},
                 {header: "地址",width: 180,dataIndex: "faddress",menuDisabled: true,sortable :false},
                 {header: "联系人",width:100,dataIndex: "flinkman",menuDisabled: true,sortable :false},
                 {header: "电话",width: 100,dataIndex: "flinkTel",menuDisabled: true,sortable :false},
                 {header: "航班信息",width: 100,dataIndex: "freserve1",menuDisabled: true,sortable :false},
                 {header: "备注",width: 120,dataIndex: "flinkPhone",menuDisabled: true,sortable :false}
                 //{header: "退货原因",width: 120,dataIndex: "freserve2",menuDisabled: true,sortable :false},
                 //{header: "纸质单号",width: 100,dataIndex: "freserve3",menuDisabled: true,sortable :false}
              ];
        
        //grid组件
        var goodsDetail =  Ext.create("Ext.grid.Panel",{
            title:'商品明细',
            border:false,
            columnLines: true,
            layout:"fit",
            id: "goodsDetail",
            bbar:  Ext.create("Ext.PagingToolbar", {
                store: goodsStore,
                displayInfo: true,
                displayMsg: SystemConstant.displayMsg,
                emptyMsg: SystemConstant.emptyMsg
            }),
            columns:cm,
            forceFit : false,
            store: goodsStore,
            autoScroll: true,
            stripeRows: true
        });
        
        var settlementDetail =  Ext.create("Ext.grid.Panel",{
            title:'结算明细',
            border:false,
            columnLines: true,
            layout:"fit",
            id: "settlementDetail",
            bbar:  Ext.create("Ext.PagingToolbar", {
                store: settleTypeStore,
                displayInfo: true,
                displayMsg: SystemConstant.displayMsg,
                emptyMsg: SystemConstant.emptyMsg
            }),
            columns:cm2,
            forceFit : false,
            store: settleTypeStore,
            autoScroll: true,
            stripeRows: true
        });
        
        var pipeline =  Ext.create("Ext.grid.Panel",{
            title:'卡流水账',
            border:false,
            hidden:true,
            columnLines: true,
            layout:"fit",
            id: "pipeline",
            bbar:  Ext.create("Ext.PagingToolbar", {
                store: sellBillsStore,
                displayInfo: true,
                displayMsg: SystemConstant.displayMsg,
                emptyMsg: SystemConstant.emptyMsg
            }),
            columns:cm3,
            forceFit : false,
            store: sellBillsStore,
            autoScroll: true,
            stripeRows: true
        });
        
        var customsInfo =  Ext.create("Ext.grid.Panel",{
            title:'顾客信息',
            border:false,
            columnLines: true,
            layout:"fit",
            id: "customsInfo",
            bbar:  Ext.create("Ext.PagingToolbar", {
                store: sellBillsStore,
                displayInfo: true,
                displayMsg: SystemConstant.displayMsg,
                emptyMsg: SystemConstant.emptyMsg
            }),
            columns:cm4,
            forceFit : false,
            store: sellBillsStore,
            autoScroll: true,
            stripeRows: true
        });
        
        var tabPanel = Ext.create('Ext.tab.Panel', {
        	region: "center",
            items: [goodsDetail, settlementDetail, pipeline, customsInfo]
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
                    text: '零售单'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fbillNo',
                    fieldLabel: '单据编号'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fdate',
                    fieldLabel: '单据日期'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'fbillType',
                    fieldLabel: '单据类型'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fcashier',
                    hidden:true,
                    fieldLabel: '收银员'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fpos',
                    fieldLabel: 'POS机'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'fshift',
                    fieldLabel: '班次'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'ftotalAmount',
                    fieldLabel: '总金额 '
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fdiscountAmount',
                    fieldLabel: '折扣金额'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'freceAmount',
                    fieldLabel: '实收金额'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fbeginTime',
                    fieldLabel: '销售开始时间'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fendTime',
                    fieldLabel: '销售结束时间'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'fcollectMode',
                    fieldLabel: '收款性质'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    hidden:true,
                    id:'customName',
                    fieldLabel: '客户名称'
                }]
            }]
        });
        
        var gproxy = goodsStore.getProxy();
        gproxy.setExtraParam("billsId",billsId);
        goodsStore.load(function(records){
            if (records.length > 0 && !hasSet) {
                var r = records[0];
                Ext.getCmp('fbillNo').setValue(r.get('fbillNo'));
                Ext.getCmp('fdate').setValue(r.get('fdate'));
                Ext.getCmp('fbillType').setValue(r.get('fbillType'));
                Ext.getCmp('fcashier').setValue(r.get('fcashier'));
                Ext.getCmp('fpos').setValue(r.get('fpos'));
                Ext.getCmp('fshift').setValue(r.get('fshift'));
                Ext.getCmp('ftotalAmount').setValue(r.get('ftotalAmount'));
                Ext.getCmp('fdiscountAmount').setValue(r.get('fdiscountAmount'));
                Ext.getCmp('freceAmount').setValue(r.get('freceAmount'));
                Ext.getCmp('fbeginTime').setValue(r.get('fbeginTime'));
                Ext.getCmp('fendTime').setValue(r.get('fendTime'));
                Ext.getCmp('fcollectMode').setValue(r.get('fcollectMode'));
                Ext.getCmp('customName').setValue(r.get('customName'));
                
                hasSet = true;
            }
        });
        
        var proxy = sellBillsStore.getProxy();
        proxy.setExtraParam("forDetail","forDetail");
        proxy.setExtraParam("billsId",billsId);
        sellBillsStore.loadPage(1);
        
        var proxy1 = settleTypeStore.getProxy();
        proxy1.setExtraParam("forDetail","forDetail");
        proxy1.setExtraParam("billsId",billsId);
        settleTypeStore.loadPage(1);
        
        Ext.create("Ext.container.Viewport", {
            layout: "border",
            items: [queryPanel,tabPanel]
        });
    });
    </script>
</body>
</html>