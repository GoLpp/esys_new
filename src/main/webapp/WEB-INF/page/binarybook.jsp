<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
	<table class="easyui-datagrid" style="width:700px;height:250px"
        data-options="url:'sys/binarybook/list',fitColumns:true,singleSelect:true,idProperty:'id', toolbar:'#toolbar-user',
        	pagination:true,rownumbers:true,fitColumns:true">
    	<thead>
       		<tr>
            	<th data-options="field:'id',width:100">图书编号</th>
            	<th data-options="field:'author',width:100">作者</th>
            	<th data-options="field:'bookName',width:100">书名</th>
            	<th data-options="field:'publishTime',width:100">出版时间</th>
            	<th data-options="field:'statu',width:100">状态</th>
            	<th data-options="field:'url',width:100">下载地址</th>
               	<th data-options="field:'count',width:100">借阅次数</th>         	
        	</tr>
    	</thead>
	</table>
	
	<div id="toolbar-user">
		<a id="btn" href="#" class="easyui-linkbutton" onclick="createUser()" data-options="iconCls:'icon-add'">创建</a>
		<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
		<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
	</div>
	
	<div id="createUser" class="easyui-dialog" style="width:600px;height:300px"
		data-options="title:'My Dialog',buttons:'#tb',closed:true,modal:true">
		<form id="createUser-form" method="post" enctype="multipart/form-data">
			<div>
       			<label>作者：</label>
        		<input class="easyui-textbox" type="text" name="loginName" data-options="required:true" />
    		</div>
    		<div>
        		<label>书名:</label>
        		<input class="easyui-textbox" type="text" name="password" required=true />
   			</div>
   			<div>
   				<label>出版时间：</label>
   				<input class="easyui-textbox" type="text" name="headImageFile"/>
   			</div>
   			
   			<div class="fitem">
				<label>电子书上传：</label>
				<input name="url" class="easyui-filebox"/>
			</div>
		</form>
	</div>
	<div id="tb">
		<a href="#" class="easyui-linkbutton" onclick="saveUser()" data-options="iconCls:'icon-ok',plain:true">保存</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">退出</a>
	</div>
	
	<script type="text/javascript">
		function createUser() {
			$('#createUser').dialog('open');
		}
		function saveUser() {
			$('#createUser-form').form('submit',{
				url: 'sys/binarybook/create',
				onSubmit: function() {
					return $(this).form('validate');
				},
				success: function(result) {
					console.log(result);
				}
			});
		}
	</script>
</body>
</html>