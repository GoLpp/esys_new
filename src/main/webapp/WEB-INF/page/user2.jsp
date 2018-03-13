<%@page pageEncoding="UTF-8" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta charset="UTF-8">
	<title>系统管理</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>js/easyui/themes/icon.css">
	<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui/datagrid-detailview.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/easyui/jquery.form.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/app/wo.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/app/main.js"></script>
	<script type="text/javascript" src="<%=basePath%>js/app/demo.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		$('#dg-user').wogrid ({
			woTitle : '用户',
			woGridType : 'Standard',
			idField : 'id',
			url : '<%=basePath%>sys/user/list',
			woDeleteUrl:'<%=basePath%>sys/user/delete',
			woCreateUrl:'<%=basePath%>sys/user/create',
			woUpdateUrl:'<%=basePath%>sys/user/update',
			columns:[[
		        {field:'id',title:'ID', width : 50, woCreate:{}, woUpdate:{}},
		        {field:'loginName',title:'用户名', width : 100, woCreate:{}, woUpdate:{}},
		        {field:'password',title:'密码', width : 200, woCreate:{}, woUpdate:{}}
		    ]],
		    woCreateForm : {
				woButtons : [{
					woButtonType : 'woSave'
				}, {
					woButtonType : 'woCancel'
				}]
		    },
		    woUpdateForm : {
				woButtons : [{
					woButtonType : 'woSave'
				}, {
					woButtonType : 'woCancel'
				}]
		    },
		    toolbar:[{
		        woButtonType : 'woCreate'
		    }, {
		        woButtonType : 'woEdit'
		    }, {
		        woButtonType : 'woDelete'
		    }, {
		        woButtonType : 'woClear'
		    }]
		});
	});
	</script>
</head>
<body>
	<table id="dg-user"/>
</body>
</html>