<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-allbook" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/binarybook/list',fitColumns:true,
        singleSelect:true,toolbar:'#allbook-bar', pagination:true, rownumbers:true">
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
			<a id="down-allbook-btn" onclick="downBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">下载图书</a>		
		</div>
		<div id="seebook-allbook" style="float:left">
			<a id="see-allbook-btn" onclick="discussBook()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">评论</a>
		</div>
		<div id="seebook-discuss-allbook" style="float:left">
			<a id="see-discuss-btn" onclick="seeDiscuss()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查看评论</a>
		</div>
		<div id="search-allbook" style="float:left">
			<form id="search-allbook-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 评论form -->
	
	<div id="binary-discuss-dialog" class="easyui-dialog" title="评论" style="width:600px;height:200px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#discuss-btn'">
		<form id="binary-discuss-form" method="post">
			<input type="hidden" name="bookId"></input>
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" name="content" data-options="required:true, multiline:true" style="width:400px; height:50px"/>
   			</div>
   		</form>
	</div>
	
	<div id="discuss-btn">
		<a id="discuss-save-btn" onclick="saveDisscuss()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
		<a id="discuss-cancel-btn" onclick="cancelDiscuss()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
	</div>
	
	<!-- 评论列表  -->
	<table id="discusslist" data-options="pagination:true,modal:true,closed:true" class="easyui-dialog" ></table>
	
	<!-- 提交下载信息 -->
	<form id="down-book" method="post"></form>
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
	
	function discussBook() {
		var book = $('#dg-allbook').datagrid('getSelected');
		if(book) {
			$('#binary-discuss-dialog').dialog('open');
		}else{
			$.messager.alert({
				title : '警告',
				icon : 'warning',
				msg : '请选择一行数据'
			});			
		}
	}
	
	function cancelDiscuss() {
		$('#binary-discuss-dialog').dialog('close');		
	}
	
	function saveDisscuss() {
		var book = $('#dg-allbook').datagrid('getSelected');
		$('#binary-discuss-form').form('submit',{
			url: 'sys/discuss/createBookDiscuss?bookId=' + book.id,
			doSubmit: function() {
				return $(this).form('validate');
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(result.success) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
					$('#binary-discuss-dialog').dialog('close');
				}else{
					$.messager.show({
						title: '提示',
						msg: result.msg
					});					
				}
			}
		});
	}
	
	function seeDiscuss() {
		var row = $('#dg-allbook').datagrid('getSelected');
		if(row){
			var id = row.id;
			$('#discusslist').dialog({
				title:'评论查看',
				width:600,
				height:450
			});
			$('#discusslist').datagrid({
				url: 'sys/discuss/listBookDiscuss?bookId='+id,
				closed:false,
				width: 600,
				height: 350,
			    loadMsg : "数据加载中......",
			    rownumbers  : true,
			    singleSelect : false,
			    pageList : [100,50,20,10],
				columns:[[
			        {field:'content',title:'评论内容',width:100},
			        {field:'userName',title:'评论人',width:100},
			        {field:'createTime',title:'评论时间',width:100,align:'right'}
			    ]]
			});
			$('#discusslist').dialog("open");
			$('#discusslist').window("center");
		}else{
			$.messager.alert({
				title : '警告',
				icon : 'warning',
				msg : '请选择一行数据'
			});
		}
	}
	
	function downBook() {
		var book = $('#dg-allbook').datagrid('getSelected');
		$('#down-book').form('submit', {
			url: 'sys/binarybook/down?url=' + book.url,
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
