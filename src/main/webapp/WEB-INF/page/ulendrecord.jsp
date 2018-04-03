<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-uulendrecord" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/lendrecord/list',fitColumns:true,
        singleSelect:false,toolbar:'#ulendrecord-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'id',width:180">编号</th>
            	<th data-options="field:'bookName',width:180">图书</th>
            	<th data-options="field:'lendTime',width:180">借出时间</th>
            	<th data-options="field:'returnTime', width:180">归还时间</th>
            	<th data-options="field:'userName',width:180">借用人</th>
            	<th data-options="field:'statu',width:180">状态</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="ulendrecord-bar" style="float:left">
		<a id="search-ulendrecord-btn" onclick="searchulendrecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">借阅记录</a>
		<a id="search-returnrecord-btn" onclick="searchReturnRecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">归还记录</a>
		<a id="search-noreturnrecord-btn" onclick="searchNoReturnRecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">未归还记录</a>
		<a id="search-noreturnrecord-btn" onclick="returnBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">还书</a>									
	</div>
</div>

<script type="text/javascript">
	function createulendrecord() {
		$('#create-dialog').dialog('open');
		$('#create-ulendrecord-form').form('clear');
	}
	
	function ulendrecordSave() {
		$('#create-ulendrecord-form').form('submit', {
			url: 'sys/ulendrecord/create',
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
					$('#dg-ulendrecord').datagrid('reload');
				}
			}
		});
	}
	
	function ulendrecordCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updateulendrecord() {
		var row = $('#dg-ulendrecord').datagrid('getSelected');
		if(row) {
			$('#update-ulendrecord-dialog').dialog('open');
			$('#update-ulendrecord-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-ulendrecord').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-ulendrecord-form').form('submit',{
				url: 'sys/ulendrecord/update',
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
						$('#update-ulendrecord-dialog').dialog('close');
						$('#dg-ulendrecord').datagrid('reload');
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
	
	function updateulendrecordCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deleteulendrecord() {
		var row = $('#dg-ulendrecord').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/ulendrecord/delete', {ulendrecordIds : str}, function(result) {
						if (result.success) {
							$('#dg-ulendrecord').datagrid('reload'); // reload grid data
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
	
	function importulendrecord() {
		$('#import-ulendrecord-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/ulendrecord/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-ulendrecord-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-ulendrecord-form').form('submit', {
			url: 'sys/ulendrecord/importExcel',
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
					$('import-ulendrecord-dialog').dialog('close');
				}
			}
		});
	}
</script>
