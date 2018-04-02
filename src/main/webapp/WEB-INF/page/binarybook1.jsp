<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-book" class="easyui-datagrid" style="width:800px;height:400px"
        data-options="url:'sys/binarybook/list',fitColumns:true,
        singleSelect:false,toolbar:'#book-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'id',width:150">图书编号</th>
            	<th data-options="field:'author',width:150">作者</th>
            	<th data-options="field:'bookName',width:150">书名</th>
            	<th data-options="field:'descrip', width:150">简介</th>
            	<th data-options="field:'publishTime',width:150">出版时间</th>
            	<th data-options="field:'publish',width:150">出版社</th>
            	<th data-options="field:'statu',width:150">状态</th>
               	<th data-options="field:'count',width:150">借阅次数</th>         		
        	</tr>
    	</thead>
	</table>
	
	<div id="book-bar" style="float:left">
		<div id="create-book" style="float:left">
			<a id="create-book-btn" onclick="createbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">创建</a>
		</div>
		<div id="update-book" style="float:left">
			<a id="update-book-btn" onclick="updatebook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">更新</a>		
		</div>
		<div id="delete-book" style="float:left">
			<a id="delete-book-btn" onclick="deletebook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>		
		</div>
		<div id="import-book" style="float:left">
			<a id="import-book-btn" onclick="importbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">上传</a>		
		</div>
		<div id="search-book" style="float:left">
			<form id="search-book-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 创建框  -->
	<div id="create-dialog" class="easyui-dialog" title="添加书籍" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-book-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请输入图书信息：</div>
    		<div class="fitem">
        		<label for="bookName">图书名:</label>
       			<input class="easyui-textbox" type="text" name="bookName" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="author">作者:</label>
       			<input class="easyui-textbox" type="text" name="author" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="descrip">简介:</label>
       			<input class="easyui-textbox" type="text" name="descrip" data-options="" />
   			</div>
   			<div class="fitem">
        		<label for="publish">出版社:</label>
       			<input class="easyui-textbox" type="text" name="publish" data-options="" />
   			</div>
   			
    		<div class="fitem">
        		<label for="publishTime">出版时间:</label>
				<input id="dd1" type="text" name="publishTime" class="easyui-datebox" required="required">   			</div>
   			<div class="fitem">
   				<label for="url">上传书籍:</label>			
				<input class="easyui-filebox" name="upBook" style="width:300px" data-options="buttonText:'选择文件'">        	
			</div>
		</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="book-cancel" style="float:right">
			<a id="book-cancel-btn" onclick="bookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="book-save" style="float:right">
			<a id="book-save-btn" onclick="bookSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 更新框 -->
	<div id="update-book-dialog" class="easyui-dialog" title="更新书籍" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-book-form" method="post">
			<div class="ftitle">请输入更新信息：</div>
			<div class="fitem">
        		<label for="id">编号:</label>
       			<input class="easyui-textbox" type="text" name="id" data-options="required:true" readonly="true"/>
   			</div>
			
    		<div class="fitem">
        		<label for="bookName">图书名:</label>
       			<input class="easyui-textbox" type="text" name="bookName" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="author">作者:</label>
       			<input class="easyui-textbox" type="text" name="author" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="descrip">简介:</label>
       			<input class="easyui-textbox" type="text" name="descrip" data-options="" />
   			</div>
   			<div class="fitem">
        		<label for="publish">出版社:</label>
       			<input class="easyui-textbox" type="text" name="publish" data-options="" />
   			</div>
   			
    		<div class="fitem">
        		<label for="publishTime">出版时间:</label>
				<input id="dd" type="text" name="publishTime" class="easyui-datebox" required="required">   			</div>
   			</div>
   		</form>
	</div>
	
	<div id="update-dialog-btn" style="float:right">
		<div id="update-cancel" style="float:right">
			<a id="update-cancel-btn" onclick="updatebookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="update-save" style="float:right">
			<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 导入按钮框 -->
	<div id="import-book-dialog" class="easyui-dialog" title="导入书籍" style="width:400px;height:200px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#import-dialog-btn'">
		<form id="import-book-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请选择书籍导入文件：</div>
			<div class="fitem">
        		<label for="file">文件:</label>
				<input class="easyui-filebox" name="excelFile"  buttonText="选择文件"  style="width:260px">
   			</div>
		</form>
	</div>
	<div id="import-dialog-btn" style="float:right">
		<div id="import-cancel" style="float:right">
			<a id="import-cancel-btn" onclick="importbookCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
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

	$('#dg-book').datagrid({
		onBeforeLoad: function(param) {
			var title = $('#search-book-form').serializeArray();
			$.each(title,function() {
				console.log(this.value);
				if(this.value != '' && this.value != undefined) {
					param[this.name] = this.value;
				}
			});
			return true;
		}
	});

	function createbook() {
		$('#create-dialog').dialog('open');
		$('#create-book-form').form('clear');
	}
	
	function bookSave() {
		$('#create-book-form').form('submit', {
			url: 'sys/binarybook/create',
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
				url: 'sys/binarybook/update',
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
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/binarybook/delete', {bookIds : str}, function(result) {
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
