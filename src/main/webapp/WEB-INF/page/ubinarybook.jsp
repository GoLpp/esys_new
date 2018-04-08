<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-ubinarybook" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/binarybook/tjlist',fitColumns:true,
        singleSelect:false,toolbar:'#ubinarybook-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'id',width:100">图书编号</th>
            	<th data-options="field:'author',width:100">作者</th>
            	<th data-options="field:'bookName',width:100">书名</th>
            	<th data-options="field:'descrip', width:100">简介</th>
            	<th data-options="field:'publishTime',width:100">出版时间</th>
            	<th data-options="field:'publish',width:100">出版社</th>
            	<th data-options="field:'statu',width:100">状态</th>
               	<th data-options="field:'count',width:100">借阅次数</th>         		
        	</tr>
    	</thead>
	</table>
	
	<div id="ubinarybook-bar" style="float:left">
		<div id="down-ubinarybook" style="float:left">
			<a id="down-ubinarybook-btn" onclick="deleteubinarybook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">下载图书</a>		
		</div>
	</div>	
</div>

<script type="text/javascript">
	function createubinarybook() {
		$('#create-dialog').dialog('open');
		$('#create-ubinarybook-form').form('clear');
	}
	
	function ubinarybookSave() {
		$('#create-ubinarybook-form').form('submit', {
			url: 'sys/ubinarybook/create',
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
					$('#dg-ubinarybook').datagrid('reload');
				}
			}
		});
	}
	
	function ubinarybookCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updateubinarybook() {
		var row = $('#dg-ubinarybook').datagrid('getSelected');
		if(row) {
			$('#update-ubinarybook-dialog').dialog('open');
			$('#update-ubinarybook-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-ubinarybook').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-ubinarybook-form').form('submit',{
				url: 'sys/ubinarybook/update',
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
						$('#update-ubinarybook-dialog').dialog('close');
						$('#dg-ubinarybook').datagrid('reload');
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
	
	function updateubinarybookCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deleteubinarybook() {
		var row = $('#dg-ubinarybook').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/ubinarybook/delete', {ubinarybookIds : str}, function(result) {
						if (result.success) {
							$('#dg-ubinarybook').datagrid('reload'); // reload grid data
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
	
	function importubinarybook() {
		$('#import-ubinarybook-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/ubinarybook/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-ubinarybook-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-ubinarybook-form').form('submit', {
			url: 'sys/ubinarybook/importExcel',
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
					$('import-ubinarybook-dialog').dialog('close');
				}
			}
		});
	}
</script>
