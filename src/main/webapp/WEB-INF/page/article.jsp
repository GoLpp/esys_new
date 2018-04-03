<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-article" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/article/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#article-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'title',width:100">标题</th>
            	<th data-options="field:'content',width:100">内容</th>
            	<th data-options="field:'createTime',width:100">创作时间</th>
            	<th data-options="field:'count', width:100">访问次数</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="article-bar" style="float:left">
		<div id="create-article" style="float:left">
			<a id="create-article-btn" onclick="createarticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">创建</a>
		</div>
		<div id="update-article" style="float:left">
			<a id="update-article-btn" onclick="updatearticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">更新</a>		
		</div>
		<div id="delete-article" style="float:left">
			<a id="delete-article-btn" onclick="deletearticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>		
		</div>
		<div id="search-article" style="float:left">
			<form id="search-article-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 创建框  -->
	<div id="create-dialog" class="easyui-dialog" title="创建文章" style="width:600px;height:600px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-article-form" method="post">
			<div class="ftitle">请输入文章信息：</div>
    		<div class="fitem">
        		<label for="title">标题:</label>
       			<input class="easyui-textbox" type="text" name="title" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" style="width:400px; height:400px" name="content" data-options="required:true,multiline:true" />
   			</div>
		</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="article-cancel" style="float:right">
			<a id="article-cancel-btn" onclick="articleCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="article-save" style="float:right">
			<a id="article-save-btn" onclick="articleSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 更新框 -->
	<div id="update-article-dialog" class="easyui-dialog" title="更新文章" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-article-form" method="post">
			<div class="ftitle">请输入更新信息：</div>
    		<div class="fitem">
        		<label for="title">标题:</label>
       			<input class="easyui-textbox" type="text" name="title" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" name="name" data-options="required:true" />
   			</div>
   		</form>
	</div>
	
	<div id="update-dialog-btn" style="float:right">
		<div id="update-cancel" style="float:right">
			<a id="update-cancel-btn" onclick="updatearticleCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="update-save" style="float:right">
			<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 导入按钮框 -->
	<div id="import-article-dialog" class="easyui-dialog" title="导入书籍" style="width:400px;height:200px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#import-dialog-btn'">
		<form id="import-article-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请选择书籍导入文件：</div>
			<div class="fitem">
        		<label for="file">文件:</label>
				<input class="easyui-filebox" name="excelFile"  buttonText="选择文件"  style="width:260px">
   			</div>
		</form>
	</div>
	<div id="import-dialog-btn" style="float:right">
		<div id="import-cancel" style="float:right">
			<a id="import-cancel-btn" onclick="importarticleCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<form method="post" id="form">
		<div id="import-down" style="float:right">
			<a id="import-down-btn" onclick="importDown()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">模板下载</a>
		</div>
		</form>
		<div id="import-save" style="float:right">
			<a id="import-save-btn" onclick="saveImport()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
</div>

<script type="text/javascript">
	function createarticle() {
		$('#create-dialog').dialog('open');
		$('#create-article-form').form('clear');
	}
	
	function articleSave() {
		$('#create-article-form').form('submit', {
			url: 'sys/article/create',
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
					$('#dg-article').datagrid('reload');
				}
			}
		});
	}
	
	function articleCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatearticle() {
		var row = $('#dg-article').datagrid('getSelected');
		if(row) {
			$('#update-article-dialog').dialog('open');
			$('#update-article-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-article').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-article-form').form('submit',{
				url: 'sys/article/update',
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
						$('#update-article-dialog').dialog('close');
						$('#dg-article').datagrid('reload');
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
	
	function updatearticleCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletearticle() {
		var row = $('#dg-article').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/article/delete', {articleIds : str}, function(result) {
						if (result.success) {
							$('#dg-article').datagrid('reload'); // reload grid data
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
	
	function importarticle() {
		$('#import-article-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/article/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-article-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-article-form').form('submit', {
			url: 'sys/article/importExcel',
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
					$('import-article-dialog').dialog('close');
				}
			}
		});
	}
</script>
