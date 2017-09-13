<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../common/doc_type.jsp"%>
<html>
<head>
<%@include file="../common/meta.jsp"%>
<%@include file="../common/taglibs.jsp"%>
<%@include file="../common/css.jsp"%>
<%@include file="../common/ext.jsp"%>
<title>实时库存</title>
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
		
		var showZero = 'false';
        var fnumberStart = '';
        var fnumberEnd = '';
		
		//建立Model模型对象
		Ext.define("Inventory",{
			extend:"Ext.data.Model",
			fields:[
				{name: "fnumber"}, 
				{name: "fname"}, 
				{name: "fmodel"},
				{name: "stockName"},
				{name: "stockNumber"},
				{name: "fkfDateStr"},
				{name: "fkfPeriod"},
				{name: "unit"},
				{name: "fqty"},
				{name: "fcostPrice"},
				{name: "totalCount"}
			]
		});
		
		//建立数据Store
		var inventoryStore=Ext.create("Ext.data.Store", {
	        pageSize: SystemConstant.commonSize,
	        model:"Inventory",
	        remoteSort:true,
			proxy: {
	            type:"ajax",
	            actionMethods: {
                	read: 'POST'
           		},
			    url: "${ctx}/hg/getInventory.action",
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
                    }
                    else{
                        Ext.getCmp('totalCount').setText('数量：0');
                    }
                }
            }
		});
		
		var cm=[
	                {header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
	                {header: "物料代码",width: 120,dataIndex: "fnumber",menuDisabled: true,sortable :false},
	                {header: "物料名称",width: 140,dataIndex: "fname",menuDisabled: true,sortable :false},
	                {header: "规格型号",width:100,dataIndex: "fmodel",menuDisabled: true,sortable :false},
	                {header: "仓库代码",width: 120,dataIndex: "stockNumber",menuDisabled: true,sortable :false},
	                {header: "仓库名称",width: 120,dataIndex: "stockName",menuDisabled: true,sortable :false},
	                //{header: "生产/采购日期",width: 100,dataIndex: "fkfDateStr",menuDisabled: true,sortable :false},
	                //{header: "保质期",width: 70,dataIndex: "fkfPeriod",menuDisabled: true,sortable :false},
	                {header: "基本计量单位",width: 100,dataIndex: "unit",menuDisabled: true,sortable :false},
	                {header: "基本单位数量",width: 100,dataIndex: "fqty",menuDisabled: true,sortable :false}
	                //{header: "最新进价",width: 100,dataIndex: "fcostPrice",menuDisabled: true,sortable :false}
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
                width:200,
                id:'totalCount'
            }]
        });
		
        var bar = Ext.create("Ext.PagingToolbar", {
            store: inventoryStore,
            displayInfo: true,
            width : '100%',
            displayMsg: SystemConstant.displayMsg,
            emptyMsg: SystemConstant.emptyMsg
        });
		
		//grid组件
		var inventoryGrid =  Ext.create("Ext.grid.Panel",{
			//title:'实时库存',
			border:false,
			columnLines: true,
			layout:"fit",
			region: "center",
			width: "100%",
			height: document.body.clientHeight,
			id: "inventoryGrid",
			dockedItems : {
                xtype : 'toolbar',
                dock : 'bottom',
                layout : 'vbox',
                width : '100%',
                border : false,
                items : [sumTbar, bar]
            },
			columns:cm,
	     	forceFit : true,
			store: inventoryStore,
			autoScroll: true,
			stripeRows: true,
			tbar: [
				{
				    xtype:'label',
				    html:'&nbsp;&nbsp;实时库存'
				},
				'->',
				{
				    xtype:'button',
				    text:'过滤',
				    iconCls:'privilege-button',
				    handler:function(){
				        query();
				    }
				}
			]
		});
		inventoryStore.load({params:{start:0,limit:SystemConstant.commonSize}});
		
		var treeStore = Ext.create('Ext.data.TreeStore', {
		    root: {
		        expanded: true,
		        nodeId: "",
		        text: "仓库",
		        leaf: false,
		        children: [
		            {nodeId: "001", text: "001(免税仓库)", leaf: true },
		            {nodeId: "100", text: "100(机场免税店)", leaf: true},
		            {nodeId: "111", text: "111(免税品待检仓)", leaf: true }
		        ]
		    }
		});
		
		var treePanel = Ext.create('Ext.tree.Panel', {
		    title: '仓库信息',
		    region: "west",
		    layout:'fit',
		    width: 200,
		    store: treeStore,
		    rootVisible: true
		});
		
		treePanel.on("itemclick",function(view,record,item,index,e,opts){
			showZero = 'false';
            fnumberStart = '';
            fnumberEnd = '';
			
			var proxy = inventoryStore.getProxy();
            proxy.setExtraParam("stockNumber", record.raw.nodeId);
            proxy.setExtraParam('showZero','');
            proxy.setExtraParam('fnumberStart','');
            proxy.setExtraParam('fnumberEnd','');
            inventoryStore.loadPage(1);
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
                },
                {
                    xtype:'fieldset',
                    padding: '5 0 0 0',
                    collapsible: false,
                    layout: 'column',
                    width: '100%',
                    items :[
                        {
                            columnWidth: 1,
                            border: false,
                            items: [{
                                fieldLabel: '显示数量为零的数据',
                                labelWidth: 320,
                                width: 340,
                                xtype: 'checkboxfield',
                                id:'showZero',
                                inputValue:'true',
                                checked : false
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
                    	showZero = Ext.getCmp('showZero').getValue();
                        fnumberStart = Ext.getCmp('fnumberStart').getValue();
                        fnumberEnd = Ext.getCmp('fnumberEnd').getValue();
                        
                        var proxy = inventoryStore.getProxy();
                        proxy.setExtraParam('showZero',showZero);
                        proxy.setExtraParam('fnumberStart',fnumberStart);
                        proxy.setExtraParam('fnumberEnd',fnumberEnd);
                        inventoryStore.loadPage(1);
                        queryWin.close();
                    }
                }, {
                    text: '取消',
                    id: 'cancelBtn',
                    handler: function() {
                        queryWin.close();
                    }
                }],
                listeners: {
                    afterrender: function(){
                        if (showZero && showZero != 'false') {
                            Ext.getCmp('showZero').setValue(showZero);
                        }
                        
                        if (fnumberStart && fnumberStart != '') {
                            Ext.getCmp('fnumberStart').setValue(fnumberStart);
                        }
                        
                        if (fnumberEnd && fnumberEnd != '') {
                            Ext.getCmp('fnumberEnd').setValue(fnumberEnd);
                        }
                    }
                }
            }).show();
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
		
		Ext.create("Ext.container.Viewport", {
		    layout: "border",
			items: [treePanel, inventoryGrid]
		});
		
	});
	</script>
</body>
</html>