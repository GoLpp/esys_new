<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String woWelcomeMsg = (String)request.getAttribute ("woWelcomeMsg");
	Boolean woLogin = (Boolean)request.getAttribute ("woLogin");
	if (woLogin == null) {
		woLogin = false;
	}
%>
<div class="ftitle">请选择：</div>
<form id="woFormUserImport" method="post" enctype="multipart/form-data">
	<div class="fitem">
		<label>文件:</label>
		<input name="woUserImportFile" class="easyui-filebox" required="true" buttonText='选择文件'/>
	</div>
</form>
<div id="woButtonsUserImport">
	<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">提交</a>
</div>
<script type="text/javascript">
$('#woButtonsUserImport').find ('a').linkbutton({
	onClick : function () {
		$('#woFormUserImport').form('submit',{
			url: 'sys/user/import',
			onSubmit: function(){
				return $(this).form('validate');
			},
			success: function(result){
				var result = eval('('+result+')');
				if (result.success == 0){
					$.messager.show({
						title: 'Error',
						msg: result.message
					});
				} else {
					$('#' + id).dialog('close');		// close the dialog
					$('#' + tableId).datagrid ('reload');
				}
			}
		});
	}
});
</script>