<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-discuss" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/discuss/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#discuss-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'content',width:100">评论内容</th>
            	<th data-options="field:'articelName',width:100">文章名</th>
   	            <th data-options="field:'discusser',width:100">评论人</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="discuss-bar" style="float:left">
		<div id="see-discuss" style="float:left">
			<a id="see-discuss-btn" onclick="seeDiscuss()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查看</a>		
		</div>
		
		<div id="delete-discuss" style="float:left">
			<a id="delete-discuss-btn" onclick="deleteDiscuss()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>		
		</div>
		<div id="search-discuss" style="float:left">
			<form id="search-discuss-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<div id="discuss-article-dialog" class="easyui-dialog" title="导入书籍" style="width:400px;height:200px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#discuss-dialog-btn'">
		<form id="import-book-form" method="post">
			<div class="ftitle">请输入评论：</div>
			<div class="fitem">
   				<label for="content">评论:</label>			
				<input class="easyui-filebox" name="content" style="width:250px" data-options="buttonText:'选择文件'">        	
   			</div>
		</form>
	</div>
	<div id="discuss-dialog-btn" style="float:right">
		<div id="discuss-cancel" style="float:right">
			<a id="discuss-cancel-btn" onclick="discussCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="discuss-save" style="float:right">
			<a id="discuss-save-btn" onclick="saveDiscuss()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>	
</div>

<script type="text/javascript">
	function creatediscuss() {
		$('#create-dialog').dialog('open');
		$('#create-discuss-form').form('clear');
	}
	
	function discussSave() {
		$('#create-discuss-form').form('submit', {
			url: 'sys/discuss/create',
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
					$('#dg-discuss').datagrid('reload');
				}
			}
		});
	}
	
	function discussCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatediscuss() {
		var row = $('#dg-discuss').datagrid('getSelected');
		if(row) {
			$('#update-discuss-dialog').dialog('open');
			$('#update-discuss-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-discuss').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-discuss-form').form('submit',{
				url: 'sys/discuss/update',
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
						$('#update-discuss-dialog').dialog('close');
						$('#dg-discuss').datagrid('reload');
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
	
	function updatediscussCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletediscuss() {
		var row = $('#dg-discuss').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/discuss/delete', {discussIds : str}, function(result) {
						if (result.success) {
							$('#dg-discuss').datagrid('reload'); // reload grid data
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
	
	function importdiscuss() {
		$('#import-discuss-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/discuss/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-discuss-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveDiscuss() {
		$('#import-discuss-form').form('submit', {
			url: 'sys/discuss/importExcel',
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
					$('import-discuss-dialog').dialog('close');
				}
			}
		});
	}
</script>
