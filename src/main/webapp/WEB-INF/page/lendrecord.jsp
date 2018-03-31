<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-lendrecord" class="easyui-datagrid" style="width:600px;height:300px"
        data-options="url:'sys/lendrecord/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#lendrecord-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'id',width:100">编号</th>
            	<th data-options="field:'bookName',width:100">图书</th>
            	<th data-options="field:'lendTime',width:100">借出时间</th>
            	<th data-options="field:'returnTime', width:100">归还时间</th>
            	<th data-options="field:'userName',width:100">借用人</th>
            	<th data-options="field:'statu',width:100">状态</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="lendrecord-bar" style="float:left">
		<div id="search-lendrecord" style="float:left">
			<form id="search-book-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="" style="width:100px"/>			
			</form>
		</div>
		<div id="delete-lendrecord" style="float:left">
			<a id="delete-lendrecord-btn" onclick="deletelendrecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>		
		</div>
	</div>
	
	<!-- 创建框  -->
	<div id="create-dialog" class="easyui-dialog" title="添加书籍" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-lendrecord-form" method="post">
			<div class="ftitle">请输入信息：</div>
    		<div class="fitem">
        		<label for="lendrecordName">图书名:</label>
       			<input class="easyui-textbox" type="text" name="lendrecordName" data-options="required:true" />
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
       			<input class="easyui-textbox" type="text" name="publishTime" data-options="" />
   			</div>
    		<div class="fitem">
        		<label for="statu">状态:</label>
       			<input class="easyui-textbox" type="text" name="statu" data-options="required:true" />
   			</div>   			   			
   			<div class="fitem">
   				<label for="url">上传书籍:</label>			
				<input class="easyui-filebox" name="uplendrecord" style="width:300px" data-options="buttonText:'选择文件'">        	
			</div>
		</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="lendrecord-cancel" style="float:right">
			<a id="lendrecord-cancel-btn" onclick="lendrecordCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="lendrecord-save" style="float:right">
			<a id="lendrecord-save-btn" onclick="lendrecordSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 更新框 -->
	<div id="update-lendrecord-dialog" class="easyui-dialog" title="更新书籍" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-lendrecord-form" method="post">
			<div class="ftitle">请输入更新信息：</div>
    		<div class="fitem">
        		<label for="lendrecordName">图书名:</label>
       			<input class="easyui-textbox" type="text" name="lendrecordName" data-options="required:true" />
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
       			<input class="easyui-textbox" type="text" name="publishTime" data-options="" />
   			</div>
    		<div class="fitem">
        		<label for="statu">状态:</label>
       			<input class="easyui-textbox" type="text" name="statu" data-options="required:true" />
   			</div>   			   			
   			<div class="fitem">
   				<label for="url">上传书籍:</label>			
				<input class="easyui-filebox" name="uplendrecord" style="width:250px" data-options="buttonText:'选择文件'">        	
			</div>
   		</form>
	</div>
	
	<div id="update-dialog-btn" style="float:right">
		<div id="update-cancel" style="float:right">
			<a id="update-cancel-btn" onclick="updatelendrecordCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="update-save" style="float:right">
			<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 导入按钮框 -->
	<div id="import-lendrecord-dialog" class="easyui-dialog" title="导入书籍" style="width:400px;height:200px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#import-dialog-btn'">
		<form id="import-lendrecord-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">请选择书籍导入文件：</div>
			<div class="fitem">
        		<label for="file">文件:</label>
				<input class="easyui-filebox" name="excelFile"  buttonText="选择文件"  style="width:260px">
   			</div>
		</form>
	</div>
	<div id="import-dialog-btn" style="float:right">
		<div id="import-cancel" style="float:right">
			<a id="import-cancel-btn" onclick="importlendrecordCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
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
	function createlendrecord() {
		$('#create-dialog').dialog('open');
		$('#create-lendrecord-form').form('clear');
	}
	
	function lendrecordSave() {
		$('#create-lendrecord-form').form('submit', {
			url: 'sys/lendrecord/create',
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
					$('#dg-lendrecord').datagrid('reload');
				}
			}
		});
	}
	
	function lendrecordCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatelendrecord() {
		var row = $('#dg-lendrecord').datagrid('getSelected');
		if(row) {
			$('#update-lendrecord-dialog').dialog('open');
			$('#update-lendrecord-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-lendrecord').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-lendrecord-form').form('submit',{
				url: 'sys/lendrecord/update',
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
						$('#update-lendrecord-dialog').dialog('close');
						$('#dg-lendrecord').datagrid('reload');
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
	
	function updatelendrecordCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletelendrecord() {
		var row = $('#dg-lendrecord').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/lendrecord/delete', {lendrecordIds : str}, function(result) {
						if (result.success) {
							$('#dg-lendrecord').datagrid('reload'); // reload grid data
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
	
	function importlendrecord() {
		$('#import-lendrecord-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/lendrecord/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-lendrecord-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-lendrecord-form').form('submit', {
			url: 'sys/lendrecord/importExcel',
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
					$('import-lendrecord-dialog').dialog('close');
				}
			}
		});
	}
</script>
