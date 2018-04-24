<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-article2" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/article/tjlist',fitColumns:true,
        singleSelect:true,toolbar:'#article2-bar', pagination:true, rownumbers:true">
    	<thead>
        	<tr>
            	<th data-options="field:'title',width:100">标题</th>
            	<th data-options="field:'content',width:100">内容</th>
            	<th data-options="field:'createTime',width:100">创作时间</th>
            	<th data-options="field:'count', width:100">访问次数</th>
        		<th data-options="field:'userName', width:100">写作人</th>
        		
        	</tr>
    	</thead>
	</table>
	
	<div id="article2-bar" style="float:left">
		<div id="create-article2" style="float:left">
			<a id="create-article2-btn" onclick="seeArticle2()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">查看</a>
		</div>
		<div id="delete-article2" style="float:left">
			<a id="delete-article2-btn" onclick="tjArticle2()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">推荐</a>		
		</div>
		<div id="discuss-article2" style="float:left">
			<a id="discuss-article2-btn" onclick="discussArticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">评论</a>		
		</div>
		<div id="see-discuss-article2" style="float:left">
			<a id="see-discuss-btn" onclick="seeDiscussArticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查看评论</a>		
		</div>
		<div id="search-article2" style="float:left">
			<form id="search-article2-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 创建 -->
	<div id="discuss-article2-dialog" class="easyui-dialog" title="评论" style="width:500px;height:180px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#article-discuss'">
		<form id="discuss-article2-form" method="post">
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" name="content" data-options="required:true, multiline:true" style="width:350px; height:60px"/>
   			</div>
   		</form>
	</div>
	
	<div id="article-discuss">
			<a id="save-discuss-btn" onclick="saveDiscussArticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">保存</a>		
			<a id="cancel-discuss-btn" onclick="cancelDiscussArticle()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">取消</a>			
	</div>
	
	<!-- 评论展示框 -->
	<table id="articlediscuss" data-options="pagination:true,modal:true,closed:true" class="easyui-dialog" ></table>
	
</div>

<script type="text/javascript">
	function seeArticle2() {
		var row = $('#dg-article2').datagrid('getSelected');
		if(row) {
			$('#update-article2-dialog').dialog('open');
			$('#update-article2-form').form('load', row);
		}else{
			$.messager.alert({
				icon : 'warning',
				title : '警告',
				msg : '请选择一行记录！'
			});
		}
	}
	
	
	function tjArticle2() {
		var row = $('#dg-article2').datagrid('getSelections');
		var str = '';
		for(var i=0; i < row.length; i++) {
			str=row[i].id+','+str;
		}
		console.log(row);
		if (row.length != 0) {
			$.messager.confirm('请确认', '您确定推荐这几篇文章吗？', function(r) {
				// r为true表示点击了确定按钮，否则表示点击了取消按钮
				if (r) {
					$.post('sys/article/tuijian', {articleIds : str}, function(result) {
						if (result.success) {
							$('#dg-article2').datagrid('reload'); // reload grid data
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
				msg : '请选择要推荐的文章'
			});
		}
	}
		
	$('#dg-article2').datagrid({
		onBeforeLoad : function (param) {// onBeforeLoad在datagrid请求列表数据之前被调用，param是请求的参数对象
			var t = $('#search-article2-form').serializeArray();
		
	        $.each(t, function() {
	        	if (this.value != '' && this.value != undefined) {
	        		// 使用form中的name和value设置param属性值
	        		param[this.name] = this.value;
	        	}
	        });
	        return true;
		}
	});
	
	function seeDiscussArticle() {
		var row = $('#dg-article2').datagrid('getSelected');
		if(row){
			var id = row.id;
			$('#articlediscuss').dialog({
				title:'评论查看',
				width:600,
				height:450
			});
			$('#articlediscuss').datagrid({
				url: 'sys/discuss/listbyarticleid?articleId='+id,
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
			$('#articlediscuss').dialog("open");
			$('#articlediscuss').window("center");
		}else{
			$.messager.alert({
				title : '警告',
				icon : 'warning',
				msg : '请选择一行数据'
			});
		}
	}
	
	function discussArticle() {
		var article = $('#dg-article2').datagrid('getSelected');
		if(article) {
			$('#discuss-article2-dialog').dialog('open');
		}else{
			$.messager.alert({
				title : '警告',
				icon : 'warning',
				msg : '请选择一行数据'
			})
		}
	}
	
	function saveDiscussArticle() {
		var article = $('#dg-article2').datagrid('getSelected');
		
		$('#discuss-article2-form').form('submit', {
			url: 'sys/discuss/create?articleId='+ article.id,
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
					$('#discuss-article2-dialog').dialog('close');
				}else{
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
				}
			}
		});
	}
</script>
