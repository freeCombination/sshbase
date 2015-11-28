<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../WEB-INF/pages/common/doc_type.jsp"%>
<html>
<head>
<%@include file="../../../WEB-INF/pages/common/meta.jsp"%>
<%@include file="../../../WEB-INF/pages/common/taglibs.jsp"%>
<%@include file="../../../WEB-INF/pages/common/css.jsp"%>
<%@include file="../../../WEB-INF/pages/common/ext.jsp"%>
<title>示例1</title>

<script type="text/javascript" >
//var menuId = '<s:property value="#parameters.id"/>';
</script>
</head>
<body>
	<script type="text/javascript">
	//@定义树形数据模型
	Ext.define('eam.examples.main.MainTreeModel', {
		extend : 'Ext.data.Model',
		fields : [{
				name : 'parentId',
				type : 'string'
			}, {
				name : 'id',
				type : 'string'
			}, {
				name : 'nodeId',
				mapping : 'id'
			}, {
				name : 'text',
				type : 'string'
			}, {
				name : 'url',
				type : 'string'
			}, {
				name : 'leaf',
				type : 'boolean'
			},{
				name:'hrefTarget',
				type : 'string'
			}
		]
	});
	//定义数据store
	eam.examples.main.MainTreeStore = Ext.create(
			'Ext.data.TreeStore', {
			model : 'eam.examples.main.MainTreeModel',
			proxy: {
				type : "ajax",
	            url: basePath+'/user/getSecondLevelMenu.action?id=35',
	            reader: {
	                type: 'json',
	                root: 'list'
	            }
	        },
			root : {
				id:43,
				text:'root'
			}
		});
	eam.configuration={};
	/**
	 * 定义列表树表格data
	 */
	eam.configuration.DataDictionaryTreeData = [];

	/**
	 * 定义列表数表格
	 */
	eam.configuration.DataDictionaryTreeStore = Ext.create('Ext.data.TreeStore', {
		model: 'eam.examples.main.MainTreeModel',
	    clearOnLoad:true,
	    proxy: {
	        type: 'memory',
	        data: eam.configuration.DataDictionaryTreeData,
	        reader: {
	            type: 'json'
	        }
	    }
	});

	//定义树形panel
	eam.examples.main.MainTree = Ext.create('Ext.tree.Panel', {
			region : 'west',
			width : 220,
			store : eam.configuration.DataDictionaryTreeStore,
			listeners : {
				itemclick : function (view, record, item, index, e) {
					var text = record.get("text");
					var val = record.get("hrefTarget");
				}
			}
		});
		Ext.onReady(function() {
			/**
			 * 定义Store(生成列表的动态数据)
			 */
			eam.configuration.DataDictionaryStore = Ext.create('Ext.data.Store', {
				model : 'eam.examples.main.MainTreeModel',
				proxy : {
					type : "format",
					url: basePath+'/user/getSecondLevelMenu.action',
					extraParams:{id: '<s:property value="#parameters.id"/>'},
				},
				autoLoad:true,
				listeners:{
			    	load:function(obj,records, successful){
			    		//全部清除所有的子节点
			    		if(records && records.length){
			    			for(var i=0;i<records.length;i++){
			    				records[i].set('hrefTarget','frame_Content');
			    				eam.configuration.DataDictionaryTreeData.push(records[i]);
			        		}
			    		}
			    		eam.configuration.DataDictionaryTreeStore.load();//treeStore加载数据
			    		eam.configuration.DataDictionaryTreeData.length = 0;
			    	}
			    }
			})

			Ext.create("Ext.container.Viewport", {
				layout : "border",
				items : [eam.examples.main.MainTree,{
                    region: "center",
					border: false,
                    html: "<iframe id='myGrid' src='' width='100%' height='100%' frameborder='0' scrolling='auto' name='frame_Content'></iframe>"
                }]
			});
		});
	</script>
</body>
</html>