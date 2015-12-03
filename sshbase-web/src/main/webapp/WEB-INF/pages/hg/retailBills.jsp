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
		//建立Model模型对象
		Ext.define("Dict",{
			extend:"Ext.data.Model",
			fields:[
				{name: "pkDictionaryId",mapping:"pkDictionaryId"}, 
				{name: "dictionaryName",mapping:"dictionaryName"}, 
				{name: "typeName",mapping:"dictionaryTypeName"}, 
				{name: "typeId",mapping:"dictionaryTypeId"},
				{name: "levelOrder",mapping:"levelOrder"},
				{name: "dictionaryValue",mapping:"dictionaryValue"},
				{name: "dictionaryCode",mapping:"dictionaryCode"}
			]
		});
		
		//建立数据Store
		var dictStore=Ext.create("Ext.data.Store", {
	        pageSize: SystemConstant.commonSize,
	        model:"Dict",
	        remoteSort:true,
			proxy: {
	            type:"ajax",
	            actionMethods: {
                	read: 'POST'
           		},
			    url: "${ctx}/dict/getDicts.action",
			    reader: {
				     totalProperty: "totalSize",
				     root: "list"
			    },
	        simpleSortMode :true
	        },
	        sorters:[{
	            property:"id",
	            direction:"ASC"
	        }]
		});
		
		//行选择模型
		var sm=Ext.create("Ext.selection.CheckboxModel",{
			injectCheckbox:1,
	    	listeners: {
		      selectionchange: function(){
		        	var c = dictGrid.getSelectionModel().getSelection();
						 	if(c.length > 0){
								Ext.getCmp('delDicBtn').setDisabled(false);
						 	}else{
							 	Ext.getCmp('delDicBtn').setDisabled(true);
						 	}
						 	if(c.length == 1){
							 	Ext.getCmp('updateDicBtn').setDisabled(false);
						 	}else{
							 	Ext.getCmp('updateDicBtn').setDisabled(true);
						 	}
		      }
			}
	    });
		
		var cm=[
				{header:"序号",xtype: "rownumberer",width:60,align:"center",menuDisabled: true,sortable :false},
	            {header: "ID",width: 70,dataIndex: "pkDictionaryId",hidden: true,menuDisabled: true,sortable :false},
	            {header: "商品编码",width: 200,dataIndex: "dictionaryName",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "条码",width: 200,dataIndex: "typeName",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "单位",width:100,dataIndex: "dictionaryValue",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "数量",width: 100,dataIndex: "dictionaryCode",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
	            {header: "销售单价",width: 100,dataIndex: "levelOrder",menuDisabled: true,sortable :false,
					renderer : function(value, cellmeta, record, rowIndex,
							columnIndex, store) {
						cellmeta.tdAttr = 'data-qtip="' + value + '"';
						return value;
					}},
                {header: "销售金额",width: 100,dataIndex: "levelOrder",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }},
                {header: "旅客信息",width: 200,dataIndex: "levelOrder",menuDisabled: true,sortable :false,
                    renderer : function(value, cellmeta, record, rowIndex,
                            columnIndex, store) {
                        cellmeta.tdAttr = 'data-qtip="' + value + '"';
                        return value;
                    }}
	         ];
		
		var typeNameStore = Ext.create('Ext.data.Store', {
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

		});
		
		//grid组件
		var dictGrid =  Ext.create("Ext.grid.Panel",{
			title:'零售单查询',
			border:false,
			columnLines: true,
			layout:"fit",
			region: "center",
			width: "100%",
			height: document.body.clientHeight,
			id: "dictGrid",
			bbar:  Ext.create("Ext.PagingToolbar", {
				store: dictStore,
				displayInfo: true,
				displayMsg: SystemConstant.displayMsg,
				emptyMsg: SystemConstant.emptyMsg
			}),
			columns:cm,
	        selModel:sm,
	     	forceFit : true,
			store: dictStore,
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
					var proxy = dictStore.getProxy();
					proxy.setExtraParam("dictName",Ext.getCmp("dictName").getValue());
					var dictType = Ext.getCmp("typeCombox").getValue();
					if(dictType=='全部') {
						dictType = '';
					}
					
					proxy.setExtraParam("dictType",dictType);
					dictStore.loadPage(1);
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
		//dictStore.load({params:{start:0,limit:SystemConstant.commonSize}});
		
		query();
		
		Ext.create("Ext.container.Viewport", {
		    layout: "border",
			items: [dictGrid]
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