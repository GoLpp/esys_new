<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-uulendrecord" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/lendrecord/list',fitColumns:true,
        singleSelect:false,toolbar:'#ulendrecord-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'id',width:180">编号</th>
            	<th data-options="field:'bookName',width:180">图书</th>
            	<th data-options="field:'lendTime',width:180">借出时间</th>
            	<th data-options="field:'returnTime', width:180">归还时间</th>
            	<th data-options="field:'userName',width:180">借用人</th>
            	<th data-options="field:'statu',width:180">状态</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="ulendrecord-bar" style="float:left">
		<a id="search-ulendrecord-btn" onclick="searchulendrecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">借阅记录</a>
		<a id="search-returnrecord-btn" onclick="searchreturnrecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">归还记录</a>
		<a id="search-noreturnrecord-btn" onclick="searchnoreturnRecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">未归还记录</a>
		<a id="search-noreturnrecord-btn" onclick="returnBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">还书</a>									
	</div>
</div>

<script type="text/javascript">
	function searchulendrecord() {
		$('#dg-uulendrecord').datagrid({
			url: 'sys/lendrecord/list'
		});
	}
	
	function searchreturnrecord() {
		$('#dg-uulendrecord').datagrid({
			url: 'sys/lendrecord/returnlist'
		});
	}
	
	function searchnoreturnRecord() {
		$('#dg-uulendrecord').datagrid({
			url: 'sys/lendrecord/noreturn'
		});
	}
	
	function returnBook() {
		var row = $('#dg-uulendrecord').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].bookId+','+str;
		}
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定要归还书籍吗？', function(r) {
				if (r) {
					$.post('sys/binarybook/return', {bookIds : str}, function(result) {
						if (result.success) {
							$('#dg-uulendrecord').datagrid('reload'); 
						} else {
							$.messager.alert({ 
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
</script>
