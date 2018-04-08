<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div>
 	<div style="padding:20px 20px">
 		<form id="save-article-form" method="post" enctype="multipart/form-data">
			<div class="ftitle">今天的生活，明日的收获</div>
    		<div class="fitem">
        		<label for="title">标题:</label>
       			<input class="easyui-textbox" type="text" name="title" data-options="required:true" />
   			 </div>
    		<div class="fitem">
        		<label for="content">内容:</label>
       			<input class="easyui-textbox" type="text" name="content" data-options="multiline:true" style="width:700px; height:460px" />
   			</div>
   		</form>
 	</div>
 	<div id="save-save" style="margin-top: 410px; margin-left: 755px">
		<a id="save-save-btn" onclick="saveArticle()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'">确定</a>
	</div>		
</div>

<script type="text/javascript">

	function saveArticle() {
		$('#save-article-form').form('submit',{
			url: 'sys/article/save',
			onSubmit: function() {
				$(this).form('validate');
			},
			success: function(result) {
				var result = eval('('+ result +')');
				if(result.success) {
					$.messager.show({
						title: '提示',
						msg: result.msg
					});
					$('#save-article-form').form('reset');
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
