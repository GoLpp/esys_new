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
		var url;
		function newUser(){
			$('#dlg-user').dialog('open').dialog('setTitle','创建用户');
			$('#fm-user').form('clear');
			url = '<%=basePath%>sys/user/create';
		}
		function editUser(){
			var row = $('#dg-user').datagrid('getSelected');
			if (row){
				$('#dlg-user').dialog('open').dialog('setTitle','Edit User');
				$('#fm-user').form('load',row);
				url = '<%=basePath%>sys/user/update';
			}
		}
		function saveUser(){
			$('#fm-user').form('submit', {
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.success == false){
						$.messager.show({
							title: 'Error',
							msg: result.message
						});
					} else {
						$('#dlg-user').dialog('close');		// close the dialog
						$('#dg-user').datagrid('reload');	// reload the user data
					}
				}
			});
		}
		function destroyUser(){
			var row = $('#dg-user').datagrid('getSelected');
			if (row){
				$.messager.confirm('Confirm','Are you sure you want to destroy this user?',function(r){
					if (r){
						$.post('<%=basePath%>sys/user/delete',{id:row.id},function(result){
							if (result.success){
								$('#dg-user').datagrid('reload');	// reload the user data
							} else {
								$.messager.show({	// show error message
									title: 'Error',
									msg: result.message
								});
							}
						},'json');
					}
				});
			}
		}
	</script>
	<style type="text/css">
		#fm{
			margin:0;
			padding:10px 30px;
		}
		.ftitle{
			font-size:14px;
			font-weight:bold;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
		}
		.fitem{
			margin-bottom:5px;
		}
		.fitem label{
			display:inline-block;
			width:80px;
		}
		.fitem input{
			width:160px;
		}
	</style>
</head>
<body>
	<table id="dg-user" title="用户" class="easyui-datagrid" style="width:700px;height:250px"
			url="<%=basePath%>sys/user/list" toolbar="#toolbar-user"
			pagination="true" rownumbers="true" fitColumns="true" singleSelect="true" idProperty="id">
		<thead>
			<tr>
				<th field="id" width="50">ID</th>
				<th field="loginName" width="50">用户名</th>
				<th field="password" width="50">密码</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar-user">
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">创建</a>
		<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改</a>
		<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除</a>
	</div>
	<div id="dlg-user" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px"
			closed="true" buttons="#dlg-buttons-user">
		<div class="ftitle">User Information</div>
		<form id="fm-user" method="post" novalidate>
			<div class="fitem">
				<label>ID:</label>
				<input name="id" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>用户名:</label>
				<input name="loginName" class="easyui-textbox" required="true">
			</div>
			<div class="fitem">
				<label>密码:</label>
				<input name="password" class="easyui-textbox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons-user">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg-user').dialog('close')" style="width:90px">取消</a>
	</div>
</body>
</html>