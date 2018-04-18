<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<%
	String woWelcomeMsg = (String)request.getAttribute ("woWelcomeMsg");
	Boolean woLogin = (Boolean)request.getAttribute ("woLogin");
	if (woLogin == null) {
		woLogin = false;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8"/>
	<title>系统管理</title>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css"/>
	<script type="text/javascript" src="js/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/datagrid-detailview.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="js/easyui/jquery.form.min.js"></script>
	<script type="text/javascript" src="js/app/wo.js"></script>
	<script type="text/javascript" src="js/app/main.js"></script>
	<script type="text/javascript" src="js/app/sys.js"></script>
	<script type="text/javascript">
		var woLogin = <%=woLogin%>;
		var imgs = $('#img');
		function changeImage(imgs) {
			imgs.src = "<%=basePath%>/code?i=" + Math.random();
		}
	</script>
	<style type="text/css">
		#fm{
			margin:0;
			padding:10px 30px;
		}
		.ftitle{
			font-size:14px;
			font-weight:bold;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
		}
		.fitem{
			height: 30px;
			margin-bottom:10px;
		}
		.fitem label{
			display:inline-block;
			width:80px;
		}
		.fitem input{
			width:160px;
		}
	</style>
</head>
<!-- 请参考：http://www.jeasyui.com/documentation/index.php -->
<!-- layout -->
<body class="easyui-layout">
	<!-- panel -->
	<div id="woMenuTreePanel" data-options="region:'west',split:true, title:'菜单'" style="width:200px;padding:10px;" class="easyui-panel">
		<!-- tree -->
		<ul id="woMenuTreeUl">
		</ul>
	</div>
	<!-- tabs -->
	<div id="woContentTabPanel" data-options="region:'center',title:'<%=woWelcomeMsg%>'" class="easyui-tabs" style="width:700px;height:250px">
		<div title="主页" style="padding:10px">
			<p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>
			<ul>
				<li>easyui is a collection of user-interface plugin based on jQuery.</li>
				<li>easyui provides essential functionality for building modem, interactive, javascript applications.</li>
				<li>using easyui you don't need to write many javascript code, you usually defines user-interface by writing some HTML markup.</li>
				<li>complete framework for HTML5 web page.</li>
				<li>easyui save your time and scales while developing your products.</li>
				<li>easyui is very easy but powerful.</li>
			</ul>
		</div>
	</div>
	<div id="woDlgLogin" class="easyui-dialog" style="width:400px;height:300px;padding:10px 20px"
			closed="true" buttons="#user" modal="true" title="登录">
		<div class="ftitle">请输入登录信息：</div>
		<form id="woFormLogin" method="post" novalidate>
			<div class="fitem">
				<label>登录名:</label>
				<input name="user" class="easyui-textbox"  data-options="iconCls:'icon-man'" required="true" style="height:30px;">
			</div>
			<div class="fitem">
				<label>密码:</label>
				<input name="password" type="password" class="easyui-textbox" data-options="iconCls:'icon-lock'" style="height:30px;" required="true">
			</div>
			<div class="fitem">
				<label>验证码：</label>
				<input name="num" class="easyui-textbox"  style="width:80px; height: 30px" />
				<div style="margin-left:200px">
					<img class="img" id="img" title="看不清，换一张" onclick="changeImage(this)">  
				</div>
			</div>			
		</form>
	</div>
	<div id="user" style="float:right;">
		<div id="woButtonsRigister" style="float:right;">
			<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">注册</a>
		</div>
		<div id="woButtonsLogin" style="float:right;">
			<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">登录</a>		
		</div>
	</div>
	
	<!-- 注册 -->
	<div id="woDlgRigister" class="easyui-dialog" style="width:400px;height:300px;padding:10px 20px"
			closed="true" buttons="#register" modal="true" title="登录">
		<div class="ftitle">请输入注册信息：</div>
		<form id="woFormRegister" method="post" novalidate>
			<div class="fitem">
				<label>登录名:</label>
				<input name="loginName" class="easyui-textbox"  data-options="iconCls:'icon-man'" required="true" style="height:30px;">
			</div>
			<div class="fitem">
				<label>密码:</label>
				<input name="password" type="password" class="easyui-textbox" data-options="iconCls:'icon-lock'" style="height:30px;" required="true">
			</div>
			
			<div class="fitem">
				<label>性别:</label>
				<input name="sex" class="easyui-textbox" data-options="iconCls:'icon-mini-edit'" style="height:30px;" required="true">
			</div>
			
			<div class="fitem">
				<label>联系电话:</label>
				<input name="tel"  class="easyui-textbox" data-options="iconCls:'icon-mini-edit'" style="height:30px;" required="true">
			</div>			
		</form>
	</div>	
	<div id="register" style="float:right;">
		<div id="woButtonsCancel" style="float:right;">
			<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">取消</a>
		</div>
		<div id="woButtonsRigister1" style="float:right;">
			<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" style="width:90px">注册</a>		
		</div>
	</div>
</body>
<script type="text/javascript">
	$('#woButtonsRigister').find ('a').linkbutton({
		onClick : function () {
			$('#woDlgRigister').dialog("open");
			$('#woDlgLogin').dialog('close');
		}
	});
	
	$('#woButtonsCancel').find('a').linkbutton({
		onClick: function() {
			$('#woDlgRigister').dialog("close");
			$('#woDlgLogin').dialog('open');			
		}
	});
	
	$('#woButtonsRigister1').find('a').linkbutton({
		onClick: function() {
			$('#woFormRegister').form('submit',{
				url: 'sys/user/register',
				onSubmit: function() {
					return $(this).form('validate');
				},
				success: function(result) {
					var result = eval('('+result+')');
					if (result.code != 1){
						$.messager.show({
							title: 'Error',
							msg: result.msg
						});
					} else {
						$('#woDlgRigister').dialog("close");
						$('#woDlgLogin').dialog('open');			
						$.messager.show({
							title: 'Success',
							msg: result.msg
						});
					}
				}
			});
		}
	});

</script>
</html>