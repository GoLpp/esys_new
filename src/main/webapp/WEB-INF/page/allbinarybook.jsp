<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-allbook" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/binarybook/list',fitColumns:true,
        singleSelect:false,toolbar:'#allbook-bar', pagination:true, rownumbers:true">
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
	
	<div id="allbook-bar" style="float:left">
		<div id="lend-book" style="float:left">
			<a id="lend-allbook-btn" onclick="lendBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">借阅</a>
		</div>		
		<div id="down-allbook" style="float:left">
			<a id="down-allbook-btn" onclick="deleteallbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">下载图书</a>		
		</div>
		<div id="seebook-allbook" style="float:left">
			<a id="see-allbook-btn" onclick="seeallbook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">预览</a>
		</div>
		<div id="search-allbook" style="float:left">
			<form id="search-allbook-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>	
</div>

<script type="text/javascript">
	$('#dg-allbook').datagrid({
		onBeforeLoad: function(param) {
			var title = $('#search-allbook-form').serializeArray();
			$.each(title,function() {
				if(this.value != '' && this.value != undefined) {
					param[this.name] = this.value;
				}
			});
			return true;
		}
	});
	
	function lendBook() {
		var rows = $('#dg-allbook').datagrid('getSelections');
		var str = '';
		for(var i = 0; i < rows.length; i++) {
			str = rows[i].id + ',' + str;
		}
		if(rows.length <= 5 && rows.length >0) {
			$.messager.confirm('请确认', '您确定借阅这几本书吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/binarybook/lendbook', {bookIds : str}, function(result) {
						if (result.success) {
							$('#dg-allbook').datagrid('reload'); // reload grid data
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
		}else if(rows.length == 0){
			$.messager.alert({
				title: '提示',
				icon: 'warning',
				msg: '请选择要借阅的书籍'
			});
		}else{
			$.messager.alert({
				title: '提示',
				icon: 'warning',
				msg: '借阅的书籍不能超过五本'
			});
		}
	}
</script>
