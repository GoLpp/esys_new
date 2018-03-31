<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-scene" class="easyui-datagrid" style="width:600px;height:300px"
        data-options="url:'sys/scene/pageList',fitColumns:true,
        singleSelect:false,toolbar:'#scene-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'name',width:100">景区名</th>
            	<th data-options="field:'address',width:100">地址</th>
   	            <th data-options="field:'detail',width:100">详细信息</th>
   	            <th data-options="field:'open',width:100">开放时间</th> 	        	
        	</tr>
    	</thead>
	</table>
	
	<div id="scene-bar" style="float:left">
		<div id="create-scene" style="float:left">
			<a id="create-scene-btn" onclick="createscene()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">创建</a>
		</div>
		<div id="update-scene" style="float:left">
			<a id="update-scene-btn" onclick="updatescene()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">更新</a>		
		</div>
		<div id="delete-scene" style="float:left">
			<a id="delete-scene-btn" onclick="deletescene()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>		
		</div>
		<div id="import-scene" style="float:left">
			<a id="import-scene-btn" onclick="importScene()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">导入</a>		
		</div>
		<div id="search-scene" style="float:left">
			<form id="search-scene-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 创建框  -->
	<div id="create-dialog" class="easyui-dialog" title="创建景区" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-scene-form" method="post">
			<div class="ftitle">请输入景区信息：</div>
    		<div class="fitem">
        		<label for="name">景区名:</label>
       			<input class="easyui-textbox" type="text" name="name" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="address">地址:</label>
       			<input class="easyui-textbox" type="text" name="address" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="detail">详细信息:</label>
       			<input class="easyui-textbox" type="text" name="detail" data-options="" />
   			</div>
    		<div class="fitem">
        		<label for="price">开放时间:</label>
       			<input class="easyui-textbox" type="text" name="open" data-options="" />
   			</div>
    		<div class="fitem">
        		<label for="staffName">负责人:</label>
       			<input class="easyui-textbox" type="text" name="staffName" data-options="required:true" />
   			</div>   			   			
   			<div class="fitem">
   				<label for="mobile">手机:</label>			
       			<input class="easyui-textbox" type="text" name="mobile" data-options="required:true,validType:'phoneNum'" />        		  			
        	</div>
		</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="scene-cancel" style="float:right">
			<a id="scene-cancel-btn" onclick="sceneCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="scene-save" style="float:right">
			<a id="scene-save-btn" onclick="sceneSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 更新框 -->
	<div id="update-scene-dialog" class="easyui-dialog" title="更新景区" style="width:400px;height:350px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-scene-form" method="post">
			<div class="ftitle">请输入景区信息：</div>
    		<div class="fitem">
        		<label for="id">ID:</label>
       			<input class="easyui-textbox" type="text" readonly="true" name="id" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="name">名称:</label>
       			<input class="easyui-textbox" type="text" name="name" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="address">地址:</label>
       			<input class="easyui-textbox" type="text" name="address" data-options="required:true" />
   			</div>
    		<div class="fitem">
        		<label for="detail">详细信息:</label>
       			<input class="easyui-textbox" type="text" name="detail" data-options="" />
   			</div>
    		<div class="fitem">
        		<label for="open">开放时间:</label>
       			<input class="easyui-textbox" type="text" name="open" data-options="required:true" />
   			</div>
   		</form>
	</div>
	
	<div id="update-dialog-btn" style="float:right">
		<div id="update-cancel" style="float:right">
			<a id="update-cancel-btn" onclick="updatesceneCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="update-save" style="float:right">
			<a id="update-save-btn" onclick="saveUpdate()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
	
	<!-- 导入按钮框 -->
	<div id="import-scene-dialog" class="easyui-dialog" title="导入数据" style="width:400px;height:250px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#import-dialog-btn'">
		<form id="import-scene-form" method="post" enctype="multipart/form-data">
			<div class="fitem">
        		<label for="file">文件:</label>
				<input class="easyui-filebox" name="excelFile"  buttonText="选择文件"  style="width:260px">
   			</div>
		</form>
	</div>
	<div id="import-dialog-btn" style="float:right">
		<div id="import-cancel" style="float:right">
			<a id="import-cancel-btn" onclick="importSceneCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
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
	function createscene() {
		$('#create-dialog').dialog('open');
		$('#create-scene-form').form('clear');
	}
	
	function sceneSave() {
		$('#create-scene-form').form('submit', {
			url: 'sys/scene/create',
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
					$('#dg-scene').datagrid('reload');
				}
			}
		});
	}
	
	function sceneCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function updatescene() {
		var row = $('#dg-scene').datagrid('getSelected');
		if(row) {
			$('#update-scene-dialog').dialog('open');
			$('#update-scene-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	function saveUpdate() {
		var row = $('#dg-scene').datagrid('getSelections');
		if(row.length = 1) {
			$('#update-scene-form').form('submit',{
				url: 'sys/scene/update',
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
						$('#update-scene-dialog').dialog('close');
						$('#dg-scene').datagrid('reload');
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
	
	function updatesceneCancel() {
		$('#update-dialog').dialog('close');
	}
	
	function deletescene() {
		var row = $('#dg-scene').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/scene/delete', {sceneIds : str}, function(result) {
						if (result.success) {
							$('#dg-scene').datagrid('reload'); // reload grid data
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
	
	function importScene() {
		$('#import-scene-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/scene/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-scene-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-scene-form').form('submit', {
			url: 'sys/scene/importExcel',
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
					$('import-scene-dialog').dialog('close');
				}
			}
		});
	}
</script>
