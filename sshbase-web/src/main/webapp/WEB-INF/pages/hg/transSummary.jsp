<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>收发汇总</title>
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
                {name: "spdm"},
                {name: "txm"},
                {name: "unit"},
                {name: "cqsl"},
                {name: "bqrksl"},
                {name: "bqcksl"},
                {name: "bqjcsl"},
                {name: "spmc"},
                {name: "sfrq"},
                {name: "sfck"},
                {name: "ggxh"}
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
                url: "${ctx}/hg/getTransSummary.action",
                reader: {
                     totalProperty: "totalSize",
                     root: "list"
                },
                simpleSortMode :true
            }
        });
        
        var cm=[
                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
                {header: "日期",width:120,dataIndex: "sfrq",menuDisabled: true,sortable :false},
                {header: "商品编码",width:160,dataIndex: "spdm",menuDisabled: true,sortable :false},
                {header: "商品名称",width: 160,dataIndex: "spmc",menuDisabled: true,sortable :false},
                {header: "规格型号",width: 100,dataIndex: "ggxh",menuDisabled: true,sortable :false},
                {header: "单位",width: 100,dataIndex: "unit",menuDisabled: true,sortable :false},
                {header: "条形码",width: 140,dataIndex: "txm",menuDisabled: true,sortable :false},
                {header: "初期数量",width: 120,dataIndex: "cqsl",menuDisabled: true,sortable :false},
                {header: "本期入库数量",width: 120,dataIndex: "bqrksl",menuDisabled: true,sortable :false},
                {header: "本期出库数量",width: 120,dataIndex: "bqcksl",menuDisabled: true,sortable :false},
                {header: "本期结存数量",width: 120,dataIndex: "bqjcsl",menuDisabled: true,sortable :false},
                {header: "仓库",width: 120,dataIndex: "sfck",menuDisabled: true,sortable :false}
             ];
        
        //grid组件
        var sellBillsGrid =  Ext.create("Ext.grid.Panel",{
            title:'收发汇总',
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
                id:'createDate',
                html:'POS机'
            },
            {
                width: 90,
                xtype: 'textfield',
                readOnly:true,
                id:'posMachine'
            },
            {
                xtype:'label',
                html:'&nbsp;&nbsp;班次'
            },
            {
                id:'bcNo',
                width: 120,
                xtype: 'textfield'
            },
            {
                xtype:'label',
                html:'&nbsp;&nbsp;保质期(天)'
            },
            {
                id:'fkfPeriod',
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
            }]
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
                        sdate = Ext.getCmp('startDate').getValue();
                        edate = Ext.getCmp('endDate').getValue();
                        
                        var proxy = sellBillsStore.getProxy();
                        proxy.setExtraParam('startDate',sdate);
                        proxy.setExtraParam('endDate',edate);
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