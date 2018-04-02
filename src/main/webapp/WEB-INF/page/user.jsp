<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div style="padding:5px 5px">
	<!-- 1.列表 http://www.jeasyui.com/documentation/index.php# datagrid -->
	<table id="dg-user" class="easyui-datagrid" style="width: 700px; height: 500px"
		url="sys/user/list" toolbar="#toolbar-user" pagination="true" rownumbers="true"
		fitColumns="true" singleSelect="true">
		<thead>
			<tr>
				<th field="id" width="100">ID</th>
				<th field="loginName" width="30">用户名</th>
				<th field="createTime" width="50">创建时间</th>
			</tr>
		</thead>
	</table>
	<!-- 列表上的按钮 linkbutton -->
	<div id="toolbar-user">
	<form id="fm-search-user">
	<table>
		<tr>
		<a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="loadCreateUserForm()">创建</a>
		<a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="loadUpdateUserForm()">修改</a>
		<a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="deleteUser()">删除</a>
		<input name="searchContent" class="easyui-textbox" iconCls='icon-search'/>
		</tr>
	</table>
	</form>
	</div>
	
	<!-- 2.加载创建表单的对话框 dialog -->
	<div id="dlg-create-user" class="easyui-dialog" title="创建用户"
		style="width: 450px; height: 280px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons-create-user">
		<div class="ftitle">请输入用户信息</div>
		<!-- 创建表单 textbox、filebox、combogrid -->
		<form id="fm-create-user" method="post" enctype="multipart/form-data">
			<div class="fitem">
				<label>登录名:</label>
				<input name="loginName" class="easyui-textbox" required="true" />
			</div>
			<div class="fitem">
				<label>密码:</label>
				<input name="password" type="password" class="easyui-textbox" required="true" />
			</div>
			<div class="fitem">
				<label>头像:</label>
				<input name="headImageFile" class="easyui-filebox" buttonText="选择图片" />
			</div>
			<div class="fitem">
				<label>角色:</label>
				<!-- idField:提交到后端的ID字段，textField:显示在下拉框中的名称 -->
				<select class="easyui-combogrid"  name="roles" style="width:200px;"
			        data-options="
						multiple:true,
						pagination:true,
			            panelWidth:450,
			            idField:'id',
			            textField:'name',
			            url:'sys/role/list',
			            columns:[[
			                {field:'id',title:'ID',width:100},
			                {field:'name',title:'Name',width:150},
			                {field:'description',title:'描述',width:150}
			            ]]
			        ">
				</select>
			</div>
		</form>
	</div>
	<!-- 创建表单的按钮 linkbutton -->
	<div id="dlg-buttons-create-user">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" 
			onclick="createUser()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="javascript:$('#dlg-create-user').dialog('close')" style="width: 90px">取消</a>
	</div>
	
	<!-- 3.加载修改表单的对话框 -->
	<div id="dlg-update-user" class="easyui-dialog" title="修改用户"
		style="width:550px; height:320px; padding:10px 20px" closed="true"
		buttons="#dlg-buttons-update-user">
		<div class="ftitle">请输入用户信息</div>
		<!-- 修改表单 -->
		<form id="fm-update-user" method="post" novalidate>
			<table>
				<tr>
					<td>
						<div class="fitem">
							<label>ID:</label>
							<input name="id" class="easyui-textbox" readonly="true" />
						</div>
						<div class="fitem">
							<label>用户名:</label>
							<input name="loginName" class="easyui-textbox" required="true" />
						</div>
						<div class="fitem">
							<label>密码:</label>
							<input name="password" type="password" class="easyui-textbox" required="true" />
						</div>
						<div class="fitem">
							<label>角色:</label>
							<select class="easyui-combogrid" name="roles" style="width:200px;"
						        data-options="
									multiple:true,
									pagination:true,
						            panelWidth:450,
						            idField:'id',
						            textField:'name',
						            url:'sys/role/list',
						            columns:[[
						                {field:'id',title:'ID',width:100},
						                {field:'name',title:'Name',width:150},
						                {field:'description',title:'描述',width:150}
						            ]]
						        ">
							</select>
						</div>
						<div class="fitem">
							<label>创建时间</label>
							<input name="createTime" class="easyui-textbox" readonly="true" />
						</div>
					</td>
					<td style="padding:10px">
						<img id="woUserUpdateFormImage" width=120 height=120/>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 修改表单的按钮 -->
	<div id="dlg-buttons-update-user">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" 
			onclick="updateUser()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel"
			onclick="javascript:$('#dlg-update-user').dialog('close')" style="width: 90px">取消</a>
	</div>
</div>
<!-- 4.所有按钮的点击响应事件 -->
<script type="text/javascript">
	// 为datagrid增加onBeforeLoad事件
	$('#dg-user').datagrid({
		onBeforeLoad : function (param) {// onBeforeLoad在datagrid请求列表数据之前被调用，param是请求的参数对象
			var t = $('#fm-search-user').serializeArray();
	        $.each(t, function() {
	        	if (this.value != '' && this.value != undefined) {
	        		// 使用form中的name和value设置param属性值
	        		param[this.name] = this.value;
	        	}
	        });
	        return true;
		}
	});
	
	// 响应列表上的创建按钮点击事件
	function loadCreateUserForm () {
		// 弹出修改对话框
		$('#dlg-create-user').dialog('open');
		// 清除form数据
		$('#fm-create-user').form('clear');
	}
	
	// 响应列表上的修改按钮点击事件
	function loadUpdateUserForm () {
		// 获取列表上选中的行数据对象
		var row = $('#dg-user').datagrid('getSelected');
		if (row) {
			// 弹出修改对话框
			$('#dlg-update-user').dialog('open');
			// 加载form数据
			$('#fm-update-user').form('load', row);
			// 设置头像src的值
			$('#woUserUpdateFormImage').attr ('src', row.headImage);
		} else {
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	// 响应创建表单的保存按钮点击事件 form
	function createUser() {
		$('#fm-create-user').form('submit', {
			url : 'sys/user/create',
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.success == false) {
					$.messager.alert({ // show error message
						title : '错误',
						icon : 'error',
						msg : result.message
					});
				} else {
					$('#dlg-create-user').dialog('close'); // close the dialog
					$('#dg-user').datagrid('reload'); // reload the grid data
				}
			}
		});
	}
	
	// 响应修改表单的保存按钮点击事件 form
	function updateUser() {
		$('#fm-update-user').form('submit', {
			url : 'sys/user/update',
			onSubmit : function() {
				return $(this).form('validate');
			},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.success == false) {
					$.messager.alert({ // show error message
						title : '错误',
						icon : 'error',
						msg : result.message
					});
				} else {
					$('#dlg-update-user').dialog('close'); // close the dialog
					$('#dg-user').datagrid('reload'); // reload the grid data
				}
			}
		});
	}
	
	// 响应列表上的删除按钮点击事件
	function deleteUser() {
		// 获取列表中的选中行数据对象
		var row = $('#dg-user').datagrid('getSelected');
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/user/delete', {woSelectedIds : row.id}, function(result) {
						if (result.success) {
							$('#dg-user').datagrid('reload'); // reload grid data
						} else {
							$.messager.alert({ // show error message
								title : '错误',
								icon : 'error',
								msg : result.message
							});
						}
					});
				}
			});
		}
	}
</script>