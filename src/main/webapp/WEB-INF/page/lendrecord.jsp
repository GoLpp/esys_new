<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-lendrecord" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/lendrecord/list',fitColumns:true,
        singleSelect:false,toolbar:'#lendrecord-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'id',width:150">编号</th>
            	<th data-options="field:'bookName',width:150">图书</th>
            	<th data-options="field:'lendTime',width:150">借出时间</th>
            	<th data-options="field:'returnTime', width:150">归还时间</th>
            	<th data-options="field:'userName',width:150">借用人</th>
            	<th data-options="field:'statu',width:150">状态</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="lendrecord-bar" style="float:left">
		<a id="search-lendrecord-btn" onclick="searchLendRecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">借阅记录</a>
		<a id="search-returnrecord-btn" onclick="searchReturnRecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">归还记录</a>
		<a id="search-noreturnrecord-btn" onclick="searchNoReturnRecord()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">未归还记录</a>				
	</div>
</div>

<script type="text/javascript">
	function searchLendRecord() {
		$('#dg-lendrecord').datagrid({
			url: 'sys/lendrecord/list'
		});
	}
	
	function searchReturnRecord() {
		$('#dg-lendrecord').datagrid({
			url: 'sys/lendrecord/returnlist'
		});
	}
	
	function searchNoReturnRecord() {
		$('#dg-lendrecord').datagrid({
			url: 'sys/lendrecord/noreturn'
		});
	}
</script>
