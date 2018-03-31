<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-book" class="easyui-datagrid" style="width:600px;height:300px"
        data-options="url:'sys/book/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#book-bar', pagination:true, rownumbers:true">
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
	
	<div id="book-bar" style="float:left">
		<div id="lendbook-book" style="float:left">
			<a id="lend-book-btn" onclick="lendBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">借阅</a>
		</div>		
		<div id="down-book" style="float:left">
			<a id="down-book-btn" onclick="deletebook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">下载图书</a>		
		</div>
		<div id="seebook-book" style="float:left">
			<a id="see-book-btn" onclick="seeBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">预览</a>
		</div>
		<div id="search-book" style="float:left">
			<form id="search-book-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
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
		var row = $('#dg-book').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-book-form').form('submit',{
				url: 'sys/book/update',
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
						$('#update-book-dialog').dialog('close');
						$('#dg-book').datagrid('reload');
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
