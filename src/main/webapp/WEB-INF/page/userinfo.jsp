<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<!-- 更新框 -->
<!-- 	<div id="update-book-dialog" class="easyui-dialog" title="更新书籍" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:false,buttons:'#update-dialog-btn'">
 -->		
 	<div style="padding:20px 20px">
 		<form id="update-book-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请输入更新信息：</div>
    		<div class="fitem">
        		<label for="loginName">登陆名:</label>
       			<input class="easyui-textbox" type="text" name="loginName" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="password">密码:</label>
       			<input class="easyui-textbox" type="text" name="password" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="sex">性别:</label>
				<input id="cc" class="easyui-combobox" name="dept"
    				data-options="valueField:'val',textField:'name',url:'sys/dictionary/type'">   			
    		</div>
   			<div class="fitem">
        		<label for="tel">电话号码:</label>
       			<input class="easyui-textbox" type="text" name="tel" data-options="required:true" />
   			</div>
			<div id="update-save" style="margin-left: 200px">
				<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
			</div>		
   		</form>
<!-- 	</div>
 -->	
 	</div>
	
</div>

<script type="text/javascript">
	function createbook() {
		$('#create-dialog').dialog('open');
		$('#create-book-form').form('clear');
	}
	
	function bookSave() {
		$('#create-book-form').form('submit', {
			url: 'sys/book/create',
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
					$('#dg-book').datagrid('reload');
				}
			}
		});
	}
	
	function bookCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatebook() {
		var row = $('#dg-book').datagrid('getSelected');
		if(row) {
			$('#update-book-dialog').dialog('open');
			$('#update-book-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
			$('#update-book-form').form('submit',{
				url: 'sys/user/update',
				onSubmit: function() {
					return $(this).form('validate');
				},
				success: function(result) {
					var result = eval('('+ result +')');
					if(!result.success) {
						$.messager.show({
							title: '提示',
							msg: result.msg
						});
					}else{
						$('#update-book-dialog').dialog('close');
						$('#dg-book').datagrid('reload');
					}
				}
			});
	}
	
	function updatebookCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletebook() {
		var row = $('#dg-book').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/book/delete', {bookIds : str}, function(result) {
						if (result.success) {
							$('#dg-book').datagrid('reload'); // reload grid data
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
		}else{
			$.messager.alert({ // show error message
				title : '提示',
				icon : 'warning',
				msg : '请选择要删除的记录'
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
	
	function importbook() {
		$('#import-book-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/book/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-book-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-book-form').form('submit', {
			url: 'sys/book/importExcel',
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
					$('import-book-dialog').dialog('close');
				}
			}
		});
	}
</script>
