<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-xuserbook" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/userbook/listAll',fitColumns:true,
        singleSelect:true,toolbar:'#xuserbook-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'bookName',width:100">书名</th>
            	<th data-options="field:'upTime',width:100">上传时间</th>
   	            <th data-options="field:'userName',width:100">上传人</th>
   	            <th data-options="field:'counts',width:100">访问次数</th> 	        	
        	</tr>
    	</thead>
	</table>
	
	<div id="xuserbook-bar" style="float:left">
		<div id="tuijian-xuserbook" style="float:left">
			<a id="tuijian-xuserbook-btn" onclick="tuijianBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">推荐</a>		
		</div>
		<div id="down-xuserbook" style="float:left">
			<a id="down-xuserbook-btn" onclick="downUserBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">下载</a>		
		</div>
<!-- 		<div id="dicuss-xuserbook" style="float:left">
			<a id="discuss-xuserbook-btn" onclick="discussBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">评论</a>		
		</div>
		<div id="see-discuss" style="float:left">
			<a id="see-discuss-btn" onclick="seeDiscuss()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查看品论</a>		
		</div>		
 -->		<div id="search-xuserbook" style="float:left">
			<form id="search-xuserbook-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<form id="downUserBook" method="post"></form>	
</div>

<script type="text/javascript">
	
	function tuijianBook() {
		var row = $('#dg-xuserbook').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		if (row) {
			$.messager.confirm('请确认', '您确定要推荐这几本书吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/userbook/tjbook', {bookIds : str}, function(result) {
						if (result.success) {
							$('#dg-xuserbook').datagrid('reload'); // reload grid data
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
	
	$('#dg-xuserbook').datagrid({
		onBeforeLoad: function(param) {
			var value = $('#search-xuserbook-form').serializeArray();
			$.each(value,function() {
				if(this.value != '' && this.value != undefined) {
					param[this.name] = this.value;
				}
			});
			return true;
		}
	});
	
	function downUserBook() {
		var book = $('#dg-xuserbook').datagrid('getSelected');
		$('#downUserBook').form('submit', {
			url: 'sys/userbook/down?url=' + book.url,
			doSubmit: function() {
				return true;
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(!result.success) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
				}
			}
		});
	}
</script>
