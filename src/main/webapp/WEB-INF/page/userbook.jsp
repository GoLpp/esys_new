<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-userbook" class="easyui-datagrid" style="width:600px;height:300px"
        data-options="url:'sys/userbook/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#userbook-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'bookName',width:100">书名</th>
            	<th data-options="field:'upTime',width:100">上传时间</th>
   	            <th data-options="field:'userName',width:100">上传人</th>
   	            <th data-options="field:'count',width:100">访问次数</th> 	        	
        	</tr>
    	</thead>
	</table>
	
	<div id="userbook-bar" style="float:left">
		<div id="create-userbook" style="float:left">
			<a id="create-userbook-btn" onclick="createuserbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">上传</a>
		</div>
		<div id="update-userbook" style="float:left">
			<a id="update-userbook-btn" onclick="updateuserbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">更新</a>		
		</div>
		<div id="delete-userbook" style="float:left">
			<a id="delete-userbook-btn" onclick="deleteuserbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>		
		</div>
		<div id="search-userbook" style="float:left">
			<form id="search-userbook-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 创建框  -->
	<div id="create-dialog" class="easyui-dialog" title="创建景区" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-userbook-form" method="post">
			<div class="ftitle">请输入书籍信息信息：</div>
    		<div class="fitem">
        		<label for="bookName">书籍名:</label>
       			<input class="easyui-textbox" type="text" name="bookName" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="upTime">上传时间:</label>
       			<input class="easyui-textbox" type="text" name="upTime" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="detail">详细信息:</label>
       			<input class="easyui-textbox" type="text" name="detail" data-options="" />
   			</div>
   			<div class="fitem">
   				<label for="bookFile">选择文件</label>
   				<input class="easyui-filebox" style="width:300px" buttonText="请选择文件">
   			</div>
	</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="userbook-cancel" style="float:right">
			<a id="userbook-cancel-btn" onclick="userbookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="userbook-save" style="float:right">
			<a id="userbook-save-btn" onclick="userbookSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 更新框 -->
	<div id="update-userbook-dialog" class="easyui-dialog" title="更新景区" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-userbook-form" method="post">
			<div class="ftitle">请输入更新信息：</div>
    		<div class="fitem">
        		<label for="bookName">书籍名:</label>
       			<input class="easyui-textbox" type="text" name="bookName" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="upTime">上传时间:</label>
       			<input class="easyui-textbox" type="text" name="upTime" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="detail">详细信息:</label>
       			<input class="easyui-textbox" type="text" name="detail" data-options="" />
   			</div>
   			<div class="fitem">
   				<label for="bookFile">选择文件</label>
   				<input class="easyui-filebox" style="width:300px" buttonText="请选择文件">
   			</div>
   		</form>
	</div>
	
	<div id="update-dialog-btn" style="float:right">
		<div id="update-cancel" style="float:right">
			<a id="update-cancel-btn" onclick="updateuserbookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="update-save" style="float:right">
			<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
</div>

<script type="text/javascript">
	function createuserbook() {
		$('#create-dialog').dialog('open');
		$('#create-userbook-form').form('clear');
	}
	
	function userbookSave() {
		$('#create-userbook-form').form('submit', {
			url: 'sys/userbook/create',
			onSubmit: function() {
				return $(this).form("validate");
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(result.code != 1) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
				}else{
					$('#create-dialog').dialog('close');
					$('#dg-userbook').datagrid('reload');
				}
			}
		});
	}
	
	function userbookCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updateuserbook() {
		var row = $('#dg-userbook').datagrid('getSelected');
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
		var row = $('#dg-userbook').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-userbook-form').form('submit',{
				url: 'sys/userbook/update',
				onSubmit: function() {
					$(this).form('validate');
				},
				success: function(result) {
					var result = eval('('+ result +')');
					if(!result.success) {
						$.messager.show({
							title: '提示',
							msg: result.msg
						});
					}else{
						$('#update-userbook-dialog').dialog('close');
						$('#dg-userbook').datagrid('reload');
					}
				}
			});
		}else{
			$.messager.alert({
				title: '提示',
				icon : 'error',
				msg: '请选择一条记录'
			});			
		}
	}
	
	function updateuserbookCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deleteuserbook() {
		var row = $('#dg-userbook').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/userbook/delete', {userbookIds : str}, function(result) {
						if (result.success) {
							$('#dg-userbook').datagrid('reload'); // reload grid data
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
	//验证手机号码
	$.extend($.fn.validatebox.defaults.rules, {    
		phoneNum: { //验证手机号   
	        validator: function(value, param){ 
	         return /^1[3-8]+\d{9}$/.test(value);
	        },    
	        message: '请输入正确的手机号码。'   
	    },
	    
	    telNum:{ //既验证手机号，又验证座机号
	      validator: function(value, param){ 
	          return /(^(0[0-9]{2,3}\-)?([2-9][0-9]{6,7})+(\-[0-9]{1,4})?$)|(^(()|(\d{3}\-))?(1[358]\d{9})$)/.test(value);
	         },    
	         message: '请输入正确的电话号码。' 
	    }  
	});
	
	function importuserbook() {
		$('#import-userbook-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/userbook/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-userbook-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-userbook-form').form('submit', {
			url: 'sys/userbook/importExcel',
			onSubmit: function() {
				$(this).form('validate');
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(result.code == 0) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
				}else{
					$.messager.show({
						title: '提示',
						msg: '导入成功'
					});
					$('import-userbook-dialog').dialog('close');
				}
			}
		});
	}
</script>
