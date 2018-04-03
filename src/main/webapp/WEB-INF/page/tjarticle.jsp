<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-tjarticle" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/tjarticle/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#tjarticle-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'title',width:100">标题</th>
            	<th data-options="field:'content',width:100">内容</th>
            	<th data-options="field:'createTime',width:100">创作时间</th>
            	<th data-options="field:'count', width:100">访问次数</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="tjarticle-bar" style="float:left">
		<div id="see-tjarticle" style="float:left">
			<a id="see-tjarticle-btn" onclick="seetjarticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">评论</a>		
		</div>
		<div id="search-tjarticle" style="float:left">
			<form id="search-tjarticle-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	function createtjarticle() {
		$('#create-dialog').dialog('open');
		$('#create-tjarticle-form').form('clear');
	}
	
	function tjarticleSave() {
		$('#create-tjarticle-form').form('submit', {
			url: 'sys/tjarticle/create',
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
					$('#dg-tjarticle').datagrid('reload');
				}
			}
		});
	}
	
	function tjarticleCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatetjarticle() {
		var row = $('#dg-tjarticle').datagrid('getSelected');
		if(row) {
			$('#update-tjarticle-dialog').dialog('open');
			$('#update-tjarticle-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-tjarticle').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-tjarticle-form').form('submit',{
				url: 'sys/tjarticle/update',
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
						$('#update-tjarticle-dialog').dialog('close');
						$('#dg-tjarticle').datagrid('reload');
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
	
	function updatetjarticleCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletetjarticle() {
		var row = $('#dg-tjarticle').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/tjarticle/delete', {tjarticleIds : str}, function(result) {
						if (result.success) {
							$('#dg-tjarticle').datagrid('reload'); // reload grid data
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
	
	function importtjarticle() {
		$('#import-tjarticle-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/tjarticle/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-tjarticle-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-tjarticle-form').form('submit', {
			url: 'sys/tjarticle/importExcel',
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
					$('import-tjarticle-dialog').dialog('close');
				}
			}
		});
	}
</script>
