<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../../../WEB-INF/pages/common/taglibs.jsp"%>
<%@include file="../../../WEB-INF/pages/common/doc_type.jsp"%>
<html>
    <head>
        <title>-</title>
        <%@include file="../../../WEB-INF/pages/common/meta.jsp"%>
        <%@include file="../../../WEB-INF/pages/common/css.jsp"%>
        <%@include file="../../../WEB-INF/pages/common/ext.jsp"%>
     
		<!-- ENDLIBS -->
		<link rel="stylesheet" type="text/css" href="Spinner.css"/>
		<script type="text/javascript" src="Spinner.js">
        </script>
		<script type="text/javascript" src="SpinnerField.js">
        </script>
        <script type="text/javascript" src="DateTimeField.js">
        </script>
		<script type="text/javascript">
            Ext.onReady(function(){
				new Ext.Viewport({
					layout:'fit',
					items:{
						tbar:[{
							id:'time',
							xtype:'datetimefield',
							format:'H:i'
						},{
							text: '!',
							handler: function(){
								var v = Ext.getCmp('time').getValue();
								alert(v);
							}
						}]
					}
				});
            });
        </script>
    </head>
    <body>
    </body>
</html>
