<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>出监管准单</title>
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
                {name: "freserve1"},
                {name: "fcustomName"},
                {name: "totalCount"},
                {name: "totalAmount"},
                {name: "flinkPhone"},
                {name: "ftext"},
                {name: "ftext1"},
                {name: "ftext2"},
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
                url: "${ctx}/hg/getOutSupervise.action",
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
                        Ext.getCmp('totalCount').setText('数量：'+ records[0].data.totalCount);
                        //Ext.getCmp('totalAmount').setText('金额：'+ records[0].data.totalAmount);
                        
                        mergeCells(sellBillsGrid, [1, 2, 3, 4, 5, 6, 7, 8]);
                    }
                    else{
                        Ext.getCmp('totalCount').setText('数量：0');
                        //Ext.getCmp('totalAmount').setText('金额：0');
                    }
                }
            }
        });
        
        var cm=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "单据编号",width:100,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "发货单位",width: 100,dataIndex: "fscStockName",menuDisabled: true,sortable :false},
                {header: "收货单位",width: 100,dataIndex: "fdcStockName",menuDisabled: true,sortable :false},
                {header: "发货单位电话",width: 100,dataIndex: "ftext",menuDisabled: true,sortable :false},
                {header: "收货单位电话",width: 100,dataIndex: "ftext1",menuDisabled: true,sortable :false},
                {header: "报关单号",width: 100,dataIndex: "ftext2",menuDisabled: true,sortable :false},
                {header: "制单人",width: 80,dataIndex: "userName",menuDisabled: true,sortable :false},
                {header: "制单日期",width: 80,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "源单类型",width: 80,dataIndex: "fselTranType",menuDisabled: true,sortable :false},
                {header: "商品代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
                {header: "商品名称",width: 140,dataIndex: "fname",menuDisabled: true,sortable :false},
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
                width:200, // 160
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
        sellBillsGrid =  Ext.create("Ext.grid.Panel",{
            title:'出监管准单',
            border:false,
            columnLines: true,
            layout:"fit",
            region: "center",
            width: "100%",
            height: document.body.clientHeight,
            id: "sellBillsGrid",
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
            stripeRows: true,
            tbar: [
            {
                xtype:'label',
                html:'单据编号'
            },
            {
                width: 200,
                xtype: 'textfield',
                id:'fbillNoText'
            },'&nbsp;',
            {
                id:'searchDicBtn',
                xtype:'button',
                disabled:false,
                text:'查询',
                iconCls:'search-button',
                handler:function(){
                    var proxy = sellBillsStore.getProxy();
                    proxy.setExtraParam("fbillNo",Ext.getCmp("fbillNoText").getValue());
                    sellBillsStore.loadPage(1);
                }
            },'->',
            {
                id:'addDicBtn',
                xtype:'button',
                disabled:false,
                text:'过滤',
                iconCls:'privilege-button',
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
                    labelWidth: 90,
                    width: 250,
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
                                fieldLabel: '制单开始日期',
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
                                fieldLabel: '制单结束日期',
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
                }]
            });
            
            var queryWin = Ext.create('Ext.window.Window', {
                bodyStyle: 'padding:5px 5px 5px 5px; background-color:white;',
                title: '条件',
                closable: true,
                resizable: false,
                buttonAlign: "right",
                width: 300,
                modal: true,
                layout: 'fit',
                constrain: true, //设置只能在窗口范围内拖动
                closeAction: 'destroy',
                items: [queryPanel],
                buttons: [{
                    text: '确定',
                    id: 'sureBtn',
                    handler: function() {
                        Ext.getCmp("fbillNoText").setValue('');
                        
                        sdate = Ext.getCmp('startDate').getValue();
                        edate = Ext.getCmp('endDate').getValue();
                        
                        var proxy = sellBillsStore.getProxy();
                        proxy.setExtraParam('startDate',sdate);
                        proxy.setExtraParam('endDate',edate);
                        proxy.setExtraParam("fbillNo",'');
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
                        }
                        else {
                            Ext.getCmp('startDate').setValue(getFirstDay());
                            Ext.getCmp('endDate').setValue(Ext.Date.format(new Date(),"Y-m-d"));
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
            
            window.open("${ctx}/hg/toOutSuperviseDetail.action?billsId=" + billsId, "", 
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