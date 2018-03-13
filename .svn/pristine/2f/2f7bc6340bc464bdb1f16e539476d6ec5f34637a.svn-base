$(document).ready(function() {
	// 初始化菜单树
	function initTree () {
		// 设置左侧菜单树参数
		$('#woMenuTreeUl').tree({
			url : 'sys/menu/getChildren', // 设置菜单数据URL
			onClick: function(node) {// 菜单树节点点击
				if ($('#woContentTabPanel').tabs('exists', node.text)) {// 对应的tab是否已经存在
					$('#woContentTabPanel').tabs('select', node.text); // 选择已有tab
				} else if (node.attributes.resource) {
					if (node.attributes.resourceType == 'url') {
						$('#woContentTabPanel').tabs ('add', {
							// href : node.resource,
							content : '<iframe width=95% height=95% src="' + node.attributes.resource + '" style="margin:10px 10px"/>',
							closable : true,
							title : node.text,
						});
					} else {
						// eval调用代码：Sys.MenuGrid({woNodeId:'', woTabId:'', woNodeText:''});
						eval(node.attributes.resource + "({woNodeId:'" + node.id + "', woTabId:'woContentTabPanel', woNodeText:'" + node.text + "'})");
					}
				}
			}
		});
		// tabpanel上增加按钮，实现退出系统功能
		$('#woContentTabPanel').panel ({
			tools : [{
				iconCls : 'icon-no',
				handler : function () {
					Wo.msg.confirm({
						msg : '确定要退出吗？',
						woFn : function () {
		                    Wo.ajax.post ({// ajax请求（POST），将选中的菜单ID传入
		                        url: 'logout',
		                        woSuccess: function () {
		                            window.location = "";
		                        }
		                    });
		                }
					});
				}
			}]
		});
	}
	if (!woLogin) {
		$('#woDlgLogin').dialog ('open');
		$('#woButtonsLogin').find ('a').linkbutton({
			onClick : function () {
				$('#woFormLogin').form('submit',{
					url: 'authentication',
					onSubmit: function(){
						return $(this).form('validate');
					},
					success: function(result){
						var result = eval('('+result+')');
						if (result.success == false){
							$.messager.show({
								title: 'Error',
								msg: result.message
							});
						} else {
							// $('#woDlgLogin').dialog('close');		// close the dialog
							// initTree ();
							window.location = "";
						}
					}
				});
			}
		});
	} else {
		initTree ();
	}
});