<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>入监管准单明细</title>
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
                {name: "freserve3"},
                {name: "totalCount"},
                {name: "totalAmount"},
                {name: "ftext"},
                {name: "ftext1"},
                {name: "ftext2"}
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
                url: "${ctx}/hg/getInSupervise.action",
                reader: {
                     totalProperty: "totalSize",
                     root: "list"
                },
                simpleSortMode :true
            },
            listeners:{
                load:function(store, records){
                    var count = store.getCount();
                    if(count > 0){
                        Ext.getCmp('totalCount').setText('数量：'+records[0].data.totalCount);
                    }
                    else{
                        Ext.getCmp('totalCount').setText('数量：0');
                    }
                }
            }
        });
        
        var cm=[
                {header: "商品代码",width: 160,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "商品名称",width: 120,dataIndex: "fname",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 80,dataIndex: "fmodel",menuDisabled: true,sortable :false},
                {header: "计量单位",width: 80,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "数量",width: 80,dataIndex: "fauxqty",menuDisabled: true,sortable :false}
             ];
        
      //定义底部工具条
        var sumTbar = Ext.create('Ext.toolbar.Toolbar', {
            id : 'sumTbar',
            region : 'north',
            id : 'nextTopBar',
            width : '100%',
            border :true,
            items:["&nbsp;&nbsp;",
            {
                xtype:'label',
                text:'总计：'
            },
            "->",
            {
                xtype:'label',
                text:'数量：',
                width:160,
                id:'totalCount'
            },
            {
                xtype:'label',
                text:'金额：',
                width:200,
                hidden:true,
                id:'totalAmount'
            }]
        });

        var bar = Ext.create("Ext.PagingToolbar", {
            store: sellBillsStore,
            displayInfo: true,
            width : '100%',
            displayMsg: SystemConstant.displayMsg,
            emptyMsg: SystemConstant.emptyMsg
        });
        
        //grid组件
        var goodsDetail =  Ext.create("Ext.grid.Panel",{
            //title:'商品明细',
            region: "center",
            border:false,
            columnLines: true,
            layout:"fit",
            id: "goodsDetail",
            dockedItems : {
                xtype : 'toolbar',
                dock : 'bottom',
                layout : 'vbox',
                width : '100%',
                border : false,
                items : [sumTbar, bar]
            },
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
                    text: '入监管准单'
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
                    fieldLabel: '制单日期'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'userName',
                    fieldLabel: '制单人'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fscStockName',
                    fieldLabel: '发货单位'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'fdcStockName',
                    fieldLabel: '收货单位'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'ftext',
                    fieldLabel: '发货单位电话 '
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'ftext1',
                    fieldLabel: '收货单位电话'
                }]
            },
            {
                columnWidth: .25,
                border: false,
                items: [{
                    xtype: 'textfield',
                    id:'ftext2',
                    fieldLabel: '报关单号'
                }]
            }]
        });
        
        var gproxy = sellBillsStore.getProxy();
        gproxy.setExtraParam("billsId",billsId);
        gproxy.setExtraParam("forDetail","forDetail");
        sellBillsStore.load(function(records){
            if (records.length > 0 && !hasSet) {
                var r = records[0];
                Ext.getCmp('fbillNo').setValue(r.get('fbillNo'));
                Ext.getCmp('fdate').setValue(r.get('fdate'));
                Ext.getCmp('userName').setValue(r.get('userName'));
                Ext.getCmp('fscStockName').setValue(r.get('fscStockName'));
                Ext.getCmp('fdcStockName').setValue(r.get('fdcStockName'));
                Ext.getCmp('ftext').setValue(r.get('ftext'));
                Ext.getCmp('ftext1').setValue(r.get('ftext1'));
                Ext.getCmp('ftext2').setValue(r.get('ftext2'));
                
                hasSet = true;
            }
        });
        
        Ext.create("Ext.container.Viewport", {
            layout: "border",
            items: [queryPanel,goodsDetail]
        });
    });
    </script>
</body>
</html>