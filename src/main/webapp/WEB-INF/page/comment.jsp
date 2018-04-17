<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg" class="easyui-datagrid" style="width:600px;height:300px"
        data-options="url:'comment/info/list',fitColumns:true,
        singleSelect:false,toolbar:'#comment-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'title',width:100">标题</th>
            	<th data-options="field:'content',width:100">内容</th>
   	            <th data-options="field:'scene',width:100">景区</th>
   	            <th data-options="field:'guest',width:100">发布人</th>
        		<th data-options="field:'createTime',width:100">发布时间</th> 	
        	</tr>
    	</thead>
	</table>
	
	<div id="comment-bar" style="float:left">
		<div id="create-comment" style="float:left">
			<a id="create-comment-btn" onclick="createCom()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">创建</a>
		</div>
		<div id="delete-comment" style="float:left">
			<a id="delete-comment-btn" onclick="deleteCom()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">删除</a>		
		</div>
		<div id="search-comment" style="float:left">
			<form id="search-comment-form" method="post">
				<input name="commentTitle" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<div id="create-dialog" class="easyui-dialog" title="创建评论" style="width:400px;height:250px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#create-dialog-btn'">
		<form id="create-comment-form" method="post">
			<div class="ftitle">请输入评论信息：</div>
    		<div class="fitem">
        		<label for="title">标题:</label>
       			<input class="easyui-textbox" type="text" name="title" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" name="content" data-options="required:true" />
   			</div>
   			<div class="fitem">
   				<label for="content">景区:</label>			
        		<select id="cc" name="scene" class="easyui-combobox" style="width:200px;"
       					data-options="url:'sys/scene/list',valueField:'id',textField:'name',required:true">
				</select>	   			
        	</div>
		</form>
	</div>
	
	<div id="create-dialog-btn" style="float:right">
		<div id="comment-cancel" style="float:right">
			<a id="comment-cancel-btn" onclick="commentCancel()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
		</div>
		<div id="comment-save" style="float:right">
			<a id="comment-save-btn" onclick="commentSave()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		</div>		
	</div>
</div>
<script type="text/javascript">
	$('#dg').datagrid({
		onBeforeLoad: function(param) {
			var title = $('#search-comment-form').serializeArray();
			$.each(title,function() {
				if(this.value != '' && this.value != undefined) {
					param[this.name] = this.value;
				}
			});
			return true;
		}
	});
	
	function createCom() {
		$('#create-dialog').dialog('open');
	}
	
	function commentSave() {
		$('#create-comment-form').form('submit', {
			url: 'comment/info/create',
			onSubmit: function() {
						return $(this).form('validate');
					},
			success : function(result) {
				var result = eval('(' + result + ')');
				if (result.success == 0) {
					$.messager.alert({ // show error message
						title : '错误',
						icon : 'error',
						msg : result.message
					});
				} else {
					$('#create-dialog').dialog('close'); // close the dialog
					$('#dg').datagrid('reload'); // reload the grid data
				}
			}
		});
	}
	
	function commentCancel() {
		$('#create-dialog').dialog('close');
	}
	
	function deleteCom() {
		var row = $('#dg').datagrid('getSelections');
		
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要删除选中的用户吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('comment/info/delete', {commentIds : str}, function(result) {
						if (result.success) {
							$('#dg').datagrid('reload'); // reload grid data
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
</script>
