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
			//title:'零售单查询',
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
	     	forceFit : true,
			store: dictStore,
			autoScroll: true,
			stripeRows: true
		});
		dictStore.load({params:{start:0,limit:SystemConstant.commonSize}});
		
		
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
                columnWidth: .6,
                bodyStyle: 'padding:10px 0px 0px 600px;font-size:16px;font-weight:bold;',
                border: false,
                items: [{
                    xtype: 'label',
                    text: '零售单明细'
                }]
            },
            {
                columnWidth: .4,
                bodyStyle: 'padding:10px 0px 0px 200px;',
                border: false,
                items: [{
                	xtype: 'textfield',
                    fieldLabel: '打印次数'
                }]
            },
            {
                columnWidth: .33,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '销售 业务类型'
                }]
            },
            {
                columnWidth: .33,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '车牌号 '
                }]
            },
            {
                columnWidth: .34,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '收款日期 '
                }]
            },
            {
                columnWidth: .33,
                border: false,
                items: [{
                    xtype: 'textfield',
                    fieldLabel: '销售方式'
                }]
            },
            {
                columnWidth: .67,
                border: false,
                items: [{
                    xtype: 'textfield',
                    width: 743,
                    fieldLabel: '交易地点 '
                }]
            }]
        });
		
		
		Ext.create("Ext.container.Viewport", {
		    layout: "border",
			items: [queryPanel,dictGrid]
		});
		
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