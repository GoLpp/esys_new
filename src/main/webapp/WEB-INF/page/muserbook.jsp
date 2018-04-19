<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-mmuserbook" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/userbook/list',fitColumns:true,
        singleSelect:false,toolbar:'#muserbook-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'bookName',width:100">书名</th>
            	<th data-options="field:'upTime',width:100">上传时间</th>
   	            <th data-options="field:'userName',width:100">上传人</th>
   	            <th data-options="field:'counts',width:100">访问次数</th> 	        	
        	</tr>
    	</thead>
	</table>
	
	<div id="muserbook-bar" style="float:left">
		<div id="create-muserbook" style="float:left">
			<a id="create-muserbook-btn" onclick="createmuserbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">上传</a>
		</div>
		<div id="update-muserbook" style="float:left">
			<a id="update-muserbook-btn" onclick="updatemuserbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">更新</a>		
		</div>
		<div id="delete-muserbook" style="float:left">
			<a id="delete-muserbook-btn" onclick="deletemuserbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>		
		</div>
		<div id="search-muserbook" style="float:left">
			<form id="search-muserbook-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 创建框  -->
	<div id="create-dialog" class="easyui-dialog" title="创建图书" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-muserbook-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请输入书籍信息信息：</div>
    		<div class="fitem">
        		<label for="bookName">书籍名:</label>
       			<input class="easyui-textbox" type="text" name="bookName" data-options="required:true" />
   			 </div>
   			<div class="fitem">
   				<label for="bookFile">选择文件</label>
   				<input class="easyui-filebox" name="bookFile" style="width:300px" buttonText="请选择文件">
   			</div>
	</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="muserbook-cancel" style="float:right">
			<a id="muserbook-cancel-btn" onclick="muserbookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="muserbook-save" style="float:right">
			<a id="muserbook-save-btn" onclick="muserbookSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 更新框 -->
	<div id="update-userbook-dialog" class="easyui-dialog" title="更新图书" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-userbook-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请输入更新信息：</div>
       			<input class="easyui-textbox" type="hidden" name="id" data-options="required:true" />
    		<div class="fitem">
        		<label for="bookName">书籍名:</label>
       			<input class="easyui-textbox" type="text" name="bookName" data-options="required:true" />
   			 </div>
   			<div class="fitem">
   				<label for="bookFile">选择文件</label>
   				<input class="easyui-filebox" name="bookFile" style="width:300px" buttonText="请选择文件">
   			</div>
   		</form>
	</div>
	
	<div id="update-dialog-btn" style="float:right">
		<div id="update-cancel" style="float:right">
			<a id="update-cancel-btn" onclick="updatemuserbookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="update-save" style="float:right">
			<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
</div>

<script type="text/javascript">
	function createmuserbook() {
		$('#create-dialog').dialog('open');
		$('#create-muserbook-form').form('clear');
	}
	
	function muserbookSave() {
		$('#create-muserbook-form').form('submit', {
			url: 'sys/userbook/create',
			onSubmit: function() {
				return $(this).form("validate");
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(result.success) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
					$('#dg-mmuserbook').datagrid('reload');
					$('#create-dialog').dialog('close');
				}else{
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
				}
			}
		});
	}
	
	function muserbookCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatemuserbook() {
		var row = $('#dg-mmuserbook').datagrid('getSelected');
		if(row) {
			$('#update-userbook-dialog').dialog('open');
			$('#update-userbook-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		$('#update-userbook-form').form('submit',{
			url: 'sys/userbook/update',
			onSubmit: function() {
				$(this).form('validate');
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(result.success) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
					$('#update-userbook-dialog').dialog('close');
					$('#dg-mmuserbook').datagrid('reload');
				}else{
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
				}
			}
		});			
	}
	
	function updatemuserbookCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletemuserbook() {
		var row = $('#dg-mmuserbook').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/userbook/delete', {bookIds : str}, function(result) {
						if (result.success) {
							$('#dg-mmuserbook').datagrid('reload'); // reload grid data
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
	
	$('#dg-mmuserbook').datagrid({
		onBeforeLoad: function(param) {
			var value = $('#search-muserbook-form').serializeArray();
			$.each(value,function() {
				if(this.value != '' && this.value != undefined) {
					param[this.name] = this.value;
				}
			});
			return true;
		}
	});
</script>
