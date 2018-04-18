<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
	<table id="dg-article2" class="easyui-datagrid" style="width:1100px;height:600px"
        data-options="url:'sys/article/tjlist',fitColumns:true,
        singleSelect:false,toolbar:'#article2-bar', pagination:true, rownumbers:true">
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
			<a id="discuss-article2-btn" onclick="tjArticle2()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">评论</a>		
		</div>
		<div id="see-discuss-article2" style="float:left">
			<a id="see-discuss-btn" onclick="tjArticle2()" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'">查看评论</a>		
		</div>
		<div id="search-article2" style="float:left">
			<form id="search-article2-form" method="post">
				<input name="searchContent" class="easyui-textbox" data-options="iconCls:'icon-search'" style="width:100px"/>			
			</form>
		</div>
	</div>
	
	<!-- 更新框 -->
	<div id="update-article2-dialog" class="easyui-dialog" title="更新文章" style="width:600px;height:600px; padding: 10px 20px"
        data-options="iconCls:'icon-save',resizable:true,modal:true,closed:true,buttons:'#update-dialog-btn'">
		<form id="update-article2-form" method="post">
			<input type="hidden" name="id"></input>
    		<div class="fitem">
        		<label for="title">标题:</label>
       			<input class="easyui-textbox" type="text" name="title" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" name="content" data-options="required:true, multiline:true" style="width:400px; height:400px"/>
   			</div>
   		</form>
	</div>
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
			$.messager.confirm('请确认', '您确定推荐这几本书吗？', function(r) {
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
				msg : '请选择要推荐的书籍'
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
	
	function importarticle2() {
		$('#import-article2-dialog').dialog('open');
	}
	
	//下载模板
	function importDown() {
		$('#form').form('submit',{
			url: 'sys/article2/importDown',
			onSubmit: function() {
				$(this).form('validate');
			},
			susccess: function(result) {
				$('#import-article2-dialog').dialog('close');
			}
		});
	}
	
	//导入Excel
	function saveImport() {
		$('#import-article2-form').form('submit', {
			url: 'sys/article2/importExcel',
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
					$('import-article2-dialog').dialog('close');
				}
			}
		});
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
</script>
