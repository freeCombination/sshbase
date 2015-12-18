<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>零售单</title>
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
                {name: "fcustomName"}
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
        
        var cm=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "单据编号",width:160,dataIndex: "fbillNo",menuDisabled: true,sortable :false},
                {header: "单据日期",width: 100,dataIndex: "fdate",menuDisabled: true,sortable :false},
                //{header: "单据类型",width: 90,dataIndex: "fbillType",menuDisabled: true,sortable :false},
                //{header: "分店",width:100,dataIndex: "fbranchShop",menuDisabled: true,sortable :false},
                {header: "收银员",width: 100,dataIndex: "fcashier",menuDisabled: true,sortable :false},
                //{header: "POS机",width: 100,dataIndex: "fpos",menuDisabled: true,sortable :false},
                //{header: "班次",width: 120,dataIndex: "fshift",menuDisabled: true,sortable :false},
                {header: "总金额",width: 80,dataIndex: "ftotalAmount",menuDisabled: true,sortable :false},
                {header: "折扣金额",width: 80,dataIndex: "fdiscountAmount",menuDisabled: true,sortable :false},
                {header: "实收金额",width: 80,dataIndex: "freceAmount",menuDisabled: true,sortable :false},
                {header: "销售开始时间",width: 150,dataIndex: "fbeginTime",menuDisabled: true,sortable :false},
                {header: "销售结束时间",width: 150,dataIndex: "fendTime",menuDisabled: true,sortable :false},
                {header: "收款性质",width: 100,dataIndex: "fcollectMode",menuDisabled: true,sortable :false},
                {header: "顾客姓名",width: 120,dataIndex: "fcustomName",menuDisabled: true,sortable :false},
                {header: "航班信息",width: 100,dataIndex: "freserve1",menuDisabled: true,sortable :false}
             ];
        
        //grid组件
        var sellBillsGrid =  Ext.create("Ext.grid.Panel",{
            title:'零售单',
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