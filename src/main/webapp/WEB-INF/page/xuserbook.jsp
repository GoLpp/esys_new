<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-xuserbook" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/xuserbook/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#xuserbook-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'bookName',width:100">书名</th>
            	<th data-options="field:'upTime',width:100">上传时间</th>
   	            <th data-options="field:'userName',width:100">上传人</th>
   	            <th data-options="field:'count',width:100">访问次数</th> 	        	
        	</tr>
    	</thead>
	</table>
	
	<div id="xuserbook-bar" style="float:left">
		<div id="tuijian-xuserbook" style="float:left">
			<a id="tuijian-xuserbook-btn" onclick="tuijianBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">推荐</a>		
		</div>
		<div id="down-xuserbook" style="float:left">
			<a id="down-xuserbook-btn" onclick="downBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">下载</a>		
		</div>		
		<div id="search-xuserbook" style="float:left">
			<form id="search-xuserbook-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>	
</div>

<script type="text/javascript">
	function createxuserbook() {
		$('#create-dialog').dialog('open');
		$('#create-xuserbook-form').form('clear');
	}
	
	function xuserbookSave() {
		$('#create-xuserbook-form').form('submit', {
			url: 'sys/xuserbook/create',
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
					$('#dg-xuserbook').datagrid('reload');
				}
			}
		});
	}
	
	function xuserbookCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatexuserbook() {
		var row = $('#dg-xuserbook').datagrid('getSelected');
		if(row) {
			$('#update-xuserbook-dialog').dialog('open');
			$('#update-xuserbook-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-xuserbook').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-xuserbook-form').form('submit',{
				url: 'sys/xuserbook/update',
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
						$('#update-xuserbook-dialog').dialog('close');
						$('#dg-xuserbook').datagrid('reload');
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
	
	function updatexuserbookCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function tuijianBook() {
		var row = $('#dg-xuserbook').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/xuserbook/delete', {xuserbookIds : str}, function(result) {
						if (result.success) {
							$('#dg-xuserbook').datagrid('reload'); // reload grid data
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
	
	function importxuserbook() {
		$('#import-xuserbook-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/xuserbook/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-xuserbook-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-xuserbook-form').form('submit', {
			url: 'sys/xuserbook/importExcel',
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
					$('import-xuserbook-dialog').dialog('close');
				}
			}
		});
	}
</script>
