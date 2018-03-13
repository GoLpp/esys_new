var Sys = {};
Sys.MenuGrid = function(options) {
	var tableId = 'woTable_' + options.woNodeId;
	// 在tabs上增加一个tabpanel
	$('#' + options.woTabId).tabs('add', {
		title : options.woNodeText,
		content : '<table id="' + tableId + '"></table>',
		closable : true
	});
	$('#' + tableId).wogrid({
		// table id
		woId : tableId,
		// 标题
		woTitle : options.woNodeText,
		// 类型：Tree,Standard,RowDetail
		woGridType : 'Tree',
		woDeleteUrl : 'sys/menu/delete',
		woCreateUrl : 'sys/menu/create',
		woUpdateUrl : 'sys/menu/update',
		// 上级ID字段
		parentField : 'parentId',
		// http://www.jeasyui.com/documentation/index.php# treegrid
		url : 'sys/menu/list',
		idField : 'id',
		treeField : 'name',
		// pagination : true,
		singleSelect : true,
		columns : [ [ {
			field : 'id',
			title : 'ID',
			width : 50,
			hidden : true,
			// 该字段会在修改表单中出现
			woUpdate : {
				readonly : true
			}
		}, {
			field : 'name',
			title : '名称',
			width : 150,
			// 该字段会在创建表单中出现
			woCreate : {},
			// 该字段会在修改表单中出现
			woUpdate : {}
		}, {
			field : 'no',
			title : '编号',
			width : 50,
			hidden : true
		}, {
			field : 'icon',
			title : '图标',
			width : 50,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'resource',
			title : '资源',
			width : 150,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'resourceType',
			title : '资源类型',
			width : 150,
			woCreate : {
				woType : 'woDictionaryCombo',
				woDictionaryType : 'menutype'
			},
			woUpdate : {
				woType : 'woDictionaryCombo',
				woDictionaryType : 'menutype'
			}
		}, {
			field : 'parentId',
			title : '上级ID',
			width : 50,
			hidden : true,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'parentName',
			title : '上级名称',
			width : 100
		} ] ],
		// 创建表单字段和按钮配置
		woCreateForm : {
			// 字段
			woFields : [ {
				woType : 'combotree',
				woName : 'parentId',
				label : '上级',
				idField : 'id',
				textField : 'name',
				treeField : 'name',
				parentField : 'parentId',
				width : 200,
				panelWidth : 300,
				url : 'sys/menu/getChildren',
				woColSpan : 1,
				columns : [ [ {
					field : 'id',
					title : 'ID',
					width : 50
				}, {
					field : 'name',
					title : '名称',
					width : 100
				}, {
					field : 'parentId',
					title : '上级ID',
					width : 50
				} ] ]
			} ],
			// 按钮配置
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woUpdateForm : {
			woFields : [ {
				woType : 'combotree',
				woName : 'parentId',
				label : '上级',
				idField : 'id',
				textField : 'name',
				treeField : 'name',
				parentField : 'parentId',
				width : 200,
				panelWidth : 300,
				url : 'sys/menu/getChildren',
				woColSpan : 1,
				columns : [ [ {
					field : 'id',
					title : 'ID',
					width : 50
				}, {
					field : 'name',
					title : '名称',
					width : 100
				}, {
					field : 'parentId',
					title : '上级ID',
					width : 50
				} ] ]
			} ],
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		// 列表按钮配置
		toolbar : [ {
			woButtonType : 'woCreate'
		}, {
			woButtonType : 'woEdit'
		}, {
			woButtonType : 'woDelete'
		}, {
			woButtonType : 'woClear'
		} ]
	});
};

Sys.DictionaryGrid = function(options) {
	var tableId = 'woTable_' + options.woNodeId;
	// 在tabs上增加一个tabpanel
	$('#' + options.woTabId).tabs('add', {
		title : options.woNodeText,
		content : '<table id="' + tableId + '"></table>',
		closable : true
	});
	$('#' + tableId).wogrid({
		woId : tableId,
		woTitle : options.woNodeText,
		url : 'sys/dictionary/list',
		idField : 'id',
		woGridType : 'Standard',
		pagination : true,
		singleSelect : false,
		woDeleteUrl : 'sys/dictionary/delete',
		woCreateUrl : 'sys/dictionary/create',
		woUpdateUrl : 'sys/dictionary/update',
		columns : [ [ {
			field : 'id',
			title : 'ID',
			width : 50,
			hidden : true,
			woUpdate : {
				readonly : true
			}
		}, {
			field : 'dicType',
			title : '类型',
			width : 100,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'name',
			title : 'KEY',
			width : 100,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'val',
			title : '值',
			width : 100,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'description',
			title : '说明',
			width : 150,
			woCreate : {},
			woUpdate : {}
		} ] ],
		woCreateForm : {
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woUpdateForm : {
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woSearchFields : [ {
			woName : 'dicType',
			prompt : '请输入类型'
		} ],
		toolbar : [ {
			woButtonType : 'woCreate'
		}, {
			woButtonType : 'woEdit'
		}, {
			woButtonType : 'woDelete'
		}, {
			woButtonType : 'woClear'
		} ]
	});
};

Sys.RoleGrid = function(options) {
	var tableId = 'woTable_' + options.woNodeId;
	// 在tabs上增加一个tabpanel
	$('#' + options.woTabId).tabs('add', {
		title : options.woNodeText,
		content : '<table id="' + tableId + '"></table>',
		closable : true
	});
	$('#' + tableId).wogrid({
		woId : tableId,
		woTitle : options.woNodeText,
		url : 'sys/role/list',
		idField : 'id',
		woGridType : 'Standard',
		pagination : true,
		singleSelect : false,
		woDeleteUrl : 'sys/role/delete',
		woCreateUrl : 'sys/role/create',
		woUpdateUrl : 'sys/role/update',
		columns : [ [ {
			field : 'id',
			title : 'ID',
			width : 50,
			hidden : true,
			woUpdate : {
				readonly : true,
				woColSpan : 2,
				width : 400
			}
		}, {
			field : 'name',
			title : '名称',
			width : 100,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'typeName',
			title : '类型',
			width : 100
		}, {
			field : 'type',
			title : '类型',
			width : 100,
			hidden : true,
			woCreate : {
				woType : 'woDictionaryCombo',
				woDictionaryType : 'roletype'
			},
			woUpdate : {
				woType : 'woDictionaryCombo',
				woDictionaryType : 'roletype'
			}
		}, {
			field : 'description',
			title : '说明',
			width : 150,
			woCreate : {
				woColSpan : 2,
				width : 400
			},
			woUpdate : {
				woColSpan : 2,
				width : 400
			}
		} ] ],
		woCreateForm : {
			woFields : [ {
				woType : 'combotree',
				woName : 'menus',
				label : '菜单',
				idField : 'id',
				textField : 'name',
				treeField : 'name',
				parentField : 'parentId',
				multiple : true,
				cascadeCheck : false,
				woColSpan : 2,
				width : 400,
				panelWidth : 400,
				url : 'sys/menu/getChildren',
				columns : [ [ {
					field : 'id',
					title : 'ID',
					width : 50
				}, {
					field : 'name',
					title : '名称',
					width : 100
				}, {
					field : 'parentId',
					title : '上级ID',
					width : 50
				} ] ]
			} ],
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woUpdateForm : {
			woFields : [ {
				woType : 'combotree',
				woName : 'menus',
				label : '菜单',
				idField : 'id',
				textField : 'name',
				treeField : 'name',
				parentField : 'parentId',
				multiple : true,
				cascadeCheck : false,
				woColSpan : 2,
				width : 400,
				panelWidth : 400,
				url : 'sys/menu/getChildren',
				columns : [ [ {
					field : 'id',
					title : 'ID',
					width : 50
				}, {
					field : 'name',
					title : '名称',
					width : 100
				}, {
					field : 'parentId',
					title : '上级ID',
					width : 50
				} ] ]
			} ],
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woSearchFields : [ {
			woName : 'name',
			woText : '名称'
		} ],
		toolbar : [ {
			woButtonType : 'woCreate'
		}, {
			woButtonType : 'woEdit'
		}, {
			woButtonType : 'woDelete'
		}, {
			woButtonType : 'woClear'
		} ]
	});
};

Sys.UserGrid = function(options) {
	var tableId = 'woTable_' + options.woNodeId;
	// 在tabs上增加一个tabpanel
	$('#' + options.woTabId).tabs('add', {
		title : options.woNodeText,
		content : '<table id="' + tableId + '"></table>',
		closable : true
	});
	$('#' + tableId).wogrid({
		woId : tableId,
		woTitle : options.woNodeText,
		url : 'sys/user/list',
		idField : 'id',
		woGridType : 'Standard',
		pagination : true,
		singleSelect : false,
		woDeleteUrl : 'sys/user/delete',
		woCreateUrl : 'sys/user/create',
		woUpdateUrl : 'sys/user/update',
		columns : [ [ {
			field : 'id',
			title : 'ID',
			width : 50,
			hidden : true,
			woUpdate : {
				readonly : true,
				width : 200
			}
		}, {
			field : 'loginName',
			title : '登录名',
			width : 150,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'password',
			title : '密码',
			width : 150,
			woCreate : {},
			woUpdate : {}
		}, {
			field : 'createTime',
			title : '时间',
			width : 200
		} ] ],
		woCreateForm : {
			woFields : [ {
				woType : 'combogrid',
				woName : 'roles',
				label : '角色',
				idField : 'id',
				textField : 'name',
				multiple : true,
				pagination : true,
				woColSpan : 2,
				width : 400,
				panelWidth : 400,
				url : 'sys/role/list',
				columns : [ [ {
					field : 'id',
					title : 'ID',
					width : 100
				}, {
					field : 'name',
					title : '名称',
					width : 200
				} ] ]
			}, {
				woType : 'filebox',
				woName : 'headImageFile',
				label : '头像',
				buttonText: '选择文件',
			    buttonAlign: 'right',
			    width : 400,
			    woColSpan : 2
			} ],
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woUpdateForm : {
			onLoadSuccess : function (data) {
				console.log (data);
				$('#woUserUpdateFormImage').attr ('src', data.headImage);
			},
			woFields : [{
				woTag : '<img id="woUserUpdateFormImage" width=80 height=80/>',
			    woIndex : 5,
			    woRowSpan : 3
			}, {
				woType : 'combogrid',
				woName : 'roles',
				label : '角色',
				idField : 'id',
				textField : 'name',
				multiple : true,
				pagination : true,
				woColSpan : 2,
				width : 400,
				panelWidth : 400,
				url : 'sys/role/list',
				columns : [ [ {
					field : 'id',
					title : 'ID',
					width : 100
				}, {
					field : 'name',
					title : '名称',
					width : 200
				} ] ]
			} ],
			woButtons : [ {
				woButtonType : 'woSave'
			}, {
				woButtonType : 'woCancel'
			} ]
		},
		woSearchFields : [ {
			woName : 'loginName',
			woText : '类型',
			prompt : '请输入登录名'
		} ],
		toolbar : [ {
			woButtonType : 'woCreate'
		}, {
			woButtonType : 'woEdit'
		}, {
			woButtonType : 'woDelete'
		}, {
			woButtonType : 'woClear'
		}, {
			iconCls : 'icon-add',
			text : '导入',
			onClick : function () {
				var id = 'woUserImportDlg';
				$('#' + id).remove();
				$('<div id="' + id + '" style="width:400px;height:200px;padding:10px 20px"/>').appendTo ($('body'));
				$('#' + id).dialog({
				    title: '导入',
				    width: 400,
				    height: 200,
				    closed: false,
				    cache: false,
				    href: 'sys/user/importForm', // 加载导入表单
				    modal: true,
				    buttons : 'woButtonsUserImport'
				});
			}
		},{
			iconCls : 'icon-add',
			text : '导出',
			onClick : function () {
				window.open ('sys/user/export');
			}
		} ]
	});
};