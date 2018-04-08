<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-tjarticle" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/article/tjlist',fitColumns:true,
        singleSelect:true,toolbar:'#tjarticle-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'title',width:100">标题</th>
            	<th data-options="field:'content',width:100">内容</th>
            	<th data-options="field:'createTime',width:100">创作时间</th>
            	<th data-options="field:'count', width:100">访问次数</th>
        	</tr>
    	</thead>
	</table>
	
	<div id="tjarticle-bar" style="float:left">
		<div id="see-tjarticle" style="float:left">
			<a id="see-tjarticle-btn" onclick="seetjarticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">评论</a>		
		</div>
		<div id="search-tjarticle" style="float:left">
			<form id="search-tjarticle-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	
</script>
