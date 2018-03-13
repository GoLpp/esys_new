var Wo = {
	id : function (len) {  
		len = len || 10;  
		var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678'; // 默认去掉了容易混淆的字符oOLl,9gq,Vv,Uu,I1  
		var maxPos = $chars.length;  
		var pwd = '';  
		for (i = 0; i < len; i++) {  
		    pwd += $chars.charAt(Math.floor(Math.random() * maxPos));  
		}
		return pwd;  
	},
	isEmpty : function (val) {
		return val == null || val == undefined || val == "";
	},
	value : function (val, defaultVal) {
		if (Wo.isEmpty(val)) {
			return defaultVal;
		}
		return val;
	},
	isString : function (val) {
		return (typeof val == 'string');
	},
	isObject : function (val) {
		return (typeof val == 'object');
	},
	isFunction : function (val) {
		return (typeof val == 'function');
	},
	array : {
		find : function (array, key, val) {
			for (var i = 0; i < array.length; i ++) {
				var obj = array[i];
				if (obj[key] == val) {
					return obj;
				}
			}
		}
	},
	msg : {
		show : function (opts) {
			if (Wo.isString (opts)) {
				opts = {
					msg : opts,
					title : '消息'
				};
			}
			$.messager.show (opts);
		},
		alertMsg : function (opts, defaults) {
			if (Wo.isString (opts)) {
				opts = {msg : opts};
			}
			$.messager.alert($.extend (defaults, opts));
		},
		info : function (opts) {
			Wo.msg.alertMsg (opts, {
				icon : 'info',
				title : '信息',
				msg : '操作成功！'
			});
		},
		warn : function (opts) {
			Wo.msg.alertMsg (opts, {
				icon : 'warning',
				title : '警告',
				msg : '操作异常！'
			});
		},
		error : function (opts) {
			Wo.msg.alertMsg (opts, {
				icon : 'error',
				title : '错误',
				msg : '操作失败！'
			});
		},
		confirm : function (opts) {
			$.messager.confirm($.extend({
				title : '确认',
				msg : '确定要执行该操作吗？',
				fn : function (r) {
					if (r && opts.woFn) {
						opts.woFn ();
					}
				}
			}, opts));
		}
	},
	ajax : {
		success : function (cfg) {
			return function(json) {
				var suc = (json.code == 1 || json.success);
				var msg = json.msg || json.message;
				if (suc) {
					if (cfg.woSuccess) {
						var showMsg = cfg.woSuccess(json);
						if (showMsg == false) {
							return;
						}
					}
					Wo.msg.info(msg);
				} else {
					if (cfg.woError) {
						var showMsg = cfg.woError(json);
						if (showMsg == false) {
							return;
						}
					}
					Wo.msg.error(msg);
				}
			};
		},
		error : function (cfg) {
			return function(XmlHttpRequest, textStatus, errorThrown) {
				var msg = "操作失败！";
				if (XmlHttpRequest.responseJSON) {
					msg = XmlHttpRequest.responseJSON.message;
				}
				if (cfg.woError) {
					var showMsg = cfg.woError({
						code : 0,
						success : false,
						msg : msg,
						message : msg
					});
					if (showMsg == false) {
						return;
					}
				}
				Wo.msg.error(msg);
			};
		},
		// 采用jquery提交表单：cfg = {id:'', url:'', data:{key:'val'}, woSuccess:function(json){}, woError:function(json){}}
		submitForm : function(cfg) {
			cfg = $.extend ({
				type : "post",
				// url : fOpts.woUrl,
				dataType : "json",
				data : {
					_timeStamp : new Date().getTime()
				},
				success : Wo.ajax.success (cfg),
				error : Wo.ajax.error (cfg)
			}, cfg);
			var jqForm = $('#' + cfg.id);
			// 防止事件多次绑定，如果多次绑定，则submit时，会调用多次
			jqForm.unbind();
			jqForm.on('submit', function(e) {
				e.preventDefault(); // <-- important
				jqForm.ajaxSubmit(cfg);
				return false;
			});
			jqForm.submit();
		},
		/**
		 * ajax请求json数据。参数描述如下： cfg = { url : '/xx/yy', data : {key1 : val1, key2 :
		 * val2}, success : function (json) {}, error : function (json) {} };
		 */
		post : function(cfg) {
			$.ajax($.extend({
				type : "post",
				dataType : "json",
				success : function(json) {
					var suc = (json.code == 1 || json.success);
					var msg = json.msg || json.message;
					if (suc) {
						if (cfg.woSuccess) {
							var showMsg = cfg.woSuccess(json);
							if (showMsg == false) {
								return;
							}
						}
						Wo.msg.info(msg);
					} else {
						if (cfg.woError) {
							var showMsg = cfg.woError(json);
							if (showMsg == false) {
								return;
							}
						}
						Wo.msg.error(msg);
					}
				},
				error : function(XmlHttpRequest, textStatus, errorThrown) {
					var msg = "操作失败！";
					if (XmlHttpRequest.responseJSON) {
						msg = XmlHttpRequest.responseJSON.message;
					}
					if (cfg.woError) {
						var showMsg = cfg.woError({
							code : 0,
							success : false,
							msg : msg,
							message : msg
						});
						if (showMsg == false) {
							return;
						}
					}
					Wo.msg.error(msg);
				}
			}, cfg));
		}
	},
	form : {
		create : {
			iconCls : 'icon-add',
			text : '创建'
		},
		edit : {
			iconCls : 'icon-edit',
			text : '修改'
		},
		remove : {
			iconCls : 'icon-remove',
			text : '删除'
		},
		save : {
			iconCls : 'icon-save',
			text : '保存'
		},
		cancel : {
			iconCls : 'icon-cancel',
			text : '取消'
		},
		clear : {
			iconCls : 'icon-clear',
			text : '全清'
		},
		createForm : function (fOpts) {
			var fields = fOpts.woFields;
			var formId = fOpts.id;
			var btns = fOpts.woButtons;
			var columns = Wo.value(fOpts.woColumns, 2);
			var a = [];
			function addRowColumn (rIndex, cIndex, rowspan, colspan) {
				for (var r = 0; r < rowspan; r ++) {
					for (var c = 0; c < colspan; c ++) {
						a.push ([r + rIndex, c + cIndex]);
					}
				}
			}
			// 获取没有被占用的行列索引
			function getEmptyRowColumn () {
				var rIndex = 0;
				while (true) {
					for (var j = 0; j < columns; j ++) {
						var eq = false;
						for (var i = 0; i < a.length; i ++) {
							if (a[i][0] == rIndex && a[i][1] == j) {
								eq = true;
								break;
							}
						}
						if (!eq) {
							return [rIndex, j];
						}
					}
					rIndex ++;
				}
			}
			// 行列索引
			var rc = [0, 0];
			for (var i = 0; i < fields.length; i ++) {
				var f = fields[i];
				f.woRowColumnStart = rc;
				addRowColumn (rc[0], rc[1], Wo.value(f.woRowSpan, 1), Wo.value(f.woColSpan, 1));
				rc = getEmptyRowColumn ();
			}
			function findFieldBy (rc) {
				for (var i = 0; i < fields.length; i ++) {
					var f = fields[i];
					if (f.woRowColumnStart[0] == rc[0] && f.woRowColumnStart[1] == rc[1]) {
						return f;
					}
				}
			}
			var t = $('<table/>').appendTo ($('#' + formId));
			for (var r = 0; r <= rc[0]; r ++) {
				var tr = $('<tr/>').appendTo (t);
				for (var c = 0; c < columns; c++) {
					var f = findFieldBy ([r, c]);
					if (!f) {
						continue;
					}
					var td = $('<td rowspan=' + Wo.value(f.woRowSpan, 1) + ' colspan=' + Wo.value(f.woColSpan,1) + '></td>').appendTo(tr);
					if (f.woTag) {
						console.log (f.woTag);
						$(f.woTag).appendTo (td);
					} else {
						var fId = f.woId || (formId + '_' + f.woName);
						var input = $('#' + fId);
						if ($('#' + fId).length == 0) {
							input = $('<input id="' + fId + '" name="' + f.woName + '"/>').appendTo (td);
						}
						f.woId = fId;
						eval ('input.' + f.woType + '(f)');
					}
				}
			}
			// 添加按钮
			var btnDiv = $('<div style="padding:5px 0;text-align:left;padding-left:5px"/>').appendTo ($('#' + formId));
			for (var i = 0; i < btns.length; i ++) {
				if (i > 0) {
					btnDiv.append ('<span> </span>');
				}
				$('<a />').appendTo (btnDiv).linkbutton(btns[i]);
			}
		}
	}
};

(function ($) {
	
	/** ------------------   1.wogrid定义   --------------------- */
	$.fn.wogrid = function (options, param) {
		
		var me = this;
		
		/** ------------------   1.0.公共方法   --------------------- */
		
		/** ------------------   1.0.1.初始化表单配置   --------------------- */
		// defaults = {id:,url:,}
		var initFormOptions = function (defaults, fOpts, opts, row) {
			// trap:此处必须采用深度拷贝，从而隔绝对fOpts及其属性对象值的修改
			fOpts = $.extend(true, defaults, fOpts);
			fOpts.woColumns = Wo.value(fOpts.woColumns, opts.woFormColumns);
			fOpts.woSelectedRow = row;
			// 如果按钮配置没有设置，则设置为空数组
			if (!fOpts.woButtons) {
				fOpts.woButtons = [];
			}
			// 调用按钮配置设置方法
			for (var i = 0; i < fOpts.woButtons.length; i ++) {
				var bOpts = fOpts.woButtons[i];
				if (bOpts.woButtonType) {
					eval (bOpts.woButtonType + opts.woGridType + 'FormButton (i, fOpts, opts)');
				}
			}
//			if (row) {
//				row.menuIds = [{id:'123', name:'一二三'},{id:'456', name:'四五六'}];
//			}
			// 如果表单没有创建过，则创建之，并加载表单数据
			if ($('#' + fOpts.id).find('table').length == 0) {
				Wo.form.createForm (fOpts);
				$('#' + fOpts.id).form(fOpts);
				$('#' + fOpts.id).form('load', fOpts.woSelectedRow);
			}
		};
		
		/** ------------------   1.0.2.初始化列表工具栏中的按钮配置   --------------------- */
		var initToolbar = function (opts) {
			// 设置查询字段配置对象默认值
			if (opts.woSearchFields) {
				for (var i = 0; i < opts.woSearchFields.length; i ++) {
					opts.woSearchFields[i] = $.extend ({}, $.fn.wogrid.defaults.woSearchFields[0], opts.woSearchFields[i]);
					if (!opts.woSearchFields[i].prompt) {
						opts.woSearchFields[i].prompt = '请输入' + opts.woSearchFields[i].woText;
					}
				}
			}
			// 处理toolbar中的按钮和查询字段
			if (!opts.toolbar) {
				opts.toolbar = [];
			}
			if (!Wo.isString (opts.toolbar)) {
				// var divTb = $(opts.woToolbarId);
				var divTb = $('<div id="' + opts.woToolbarId + '" />').appendTo ($('body'));
				var tr = $('<tr />').appendTo($('<table />').appendTo($('<form id="' + opts.woSearchFormId + '" />').appendTo (divTb)));
				for (var i = 0; i < opts.toolbar.length; i ++) {
					$('<span> </span>').appendTo (tr);
					var bOpts = opts.toolbar[i];
					if (bOpts.woButtonType) {
						var rOpts = eval (bOpts.woButtonType + opts.woGridType + 'Button (i, opts)');
						$('<a />').appendTo (tr).linkbutton (rOpts);
					} else {
						$('<a />').appendTo (tr).linkbutton (bOpts);
					}
				}
				// 创建查询字段
				for (var i = 0; i < opts.woSearchFields.length; i ++) {
					$('<span> </span>').appendTo (tr);
					var f = opts.woSearchFields[i];
					// 在查询表单中创建查询字段
					var input = $('<input name="' + f.woName + '"/>').appendTo (tr);
					eval ('input.' + f.woType + '(f)');
				}
				opts.toolbar = "#" + opts.woToolbarId;
			}
		}
		
		/** ------------------   1.0.3.弹框显示表单   --------------------- */
		// defaults：表单需要传入的数据，{id:,url:}，id和url为必填项；
		// fOpts：wogrid中配置的woUpdateForm或者woCreateForm
		// opts：wogrid的配置对象
		// row：用于初始化表单值的对象，可以从表格上直接获取选中的行，或者根据需要自行构造
		function showDialog (dOpts, defaults, fOpts, opts, row) {
			var div = $('<div><form id="' + defaults.id + '"/></div>').appendTo ($('body'));
			initFormOptions (defaults, fOpts, opts, row);
			div.dialog($.extend({
			    width: 500,
			    height: 300,
			    onClose : function () {
			    	div.dialog ('destroy');
			    },
			    modal: true
			}, dOpts));
		};
		
		/** ------------------   1.1.woGridType为RowDetail时的相关方法   --------------------- */
		
		/** ------------------   1.1.0.initRowDetailOptions   --------------------- */
		var initRowDetailOptions = function (opts) {
			var getCreateFormId = function (index) {
				return opts.woCreateFormId + '_' + index;
			}
			var getUpdateFormId = function (index) {
				return opts.woUpdateFormId + '_' + index;
			}
			
			// 返回行编辑表单html代码
			opts.detailFormatter = Wo.value (opts.detailFormatter, function(index, row){
				var l = new Date().getTime();
				var id;
				if (row.isNewRow) {
					id = getCreateFormId(l + index);
				} else {
					id = getUpdateFormId(l + index);
				}
				row.woFormId = id;
				return '<div><form id="' + id + '"/></div>';
			});
			// 行编辑表单展开事件
			opts.onExpandRow = Wo.value (opts.onExpandRow, function(index, row) {
				var fOpts;
				if (row.isNewRow) {
					// 此处必须使用深度拷贝，因为woButtons等属性也是对象
					fOpts = initFormOptions ({
						id : row.woFormId,
						url : opts.woCreateUrl,
					}, opts.woCreateForm, opts, row);
				} else {
					fOpts = initFormOptions ({
						id : row.woFormId,
						url : opts.woUpdateUrl,
					}, opts.woUpdateForm, opts, row);
				}
				$('#' + opts.woTableId).datagrid('fixDetailRowHeight', index);
				$('#' + opts.woTableId).datagrid('selectRow', index);
				// $('#' + opts.woTableId).datagrid('getRowDetail',index).find('form').form('load',row);
			});
			// 设置视图为行编辑视图
			opts.view = Wo.value(opts.view, detailview);
			// 初始化表格工具栏中按钮的配置
			initToolbar (opts);
			// 创建表格
			$('#' + opts.woTableId).datagrid(opts);
		}
		
		/** ------------------   1.1.1.woCreateRowDetailButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woCreate，并且woGridType为RowDetail时，调用此方法创建其配置
		// index：按钮的索引
		var woCreateRowDetailButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			var dg = $('#' + opts.woTableId);
			return opts.toolbar[index] = $.extend({
		    	onClick:function () {
		    		dg.datagrid('insertRow', {
						index:0,
						row:{
							isNewRow:true
						}
					});
					dg.datagrid('expandRow', 0);
					dg.datagrid('selectRow', 0);
		        }
			}, Wo.form.create , bOpts);
		}
		
		/** ------------------   1.1.2.woDeleteRowDetailButton   --------------------- */
		// 表格toolbar中按钮配置项为woDelete，并且woGridType为RowDetail时，调用此方法创建其配置
		// index：按钮的索引
		var woDeleteRowDetailButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			var dg = $('#' + opts.woTableId);
			return opts.toolbar[index] = $.extend({
		    	onClick:function () {
		    		me.wogrid ('getSelections', {
		    			woSelectType : bOpts.woSelectType,
		    			getIds : function (ids, rows) {
		    				Wo.msg.confirm ({
				    			woFn : function () {
				    				Wo.ajax.post({
				    					url : opts.woDeleteUrl,
				    					data : {woSelectedIds : ids},
				    					woSuccess : function (json) {
				    						// 删除只能按照rows的索引逆序
				    						var len = rows.length;
				    						for (var i = len - 1; i >= 0; i --) {
				    							if (rows[i]) {
				    								var index = dg.datagrid('getRowIndex', rows[i]);
				    								if (index > -1) {
				    									// 下面操作会删除rows中的数据，导致rows.length产生变化，所有只能逆序删除
						    							dg.datagrid('deleteRow', index);
				    								}
				    							}
				    						}
				    					}
				    				});
				    			}
				    		});
		    			}
		    		});
		        }
			}, Wo.form.remove, bOpts);
		}
		
		/** ------------------   1.1.3.woClearRowDetailButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woClear，并且woGridType为RowDetail时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woClearRowDetailButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			return opts.toolbar[index] = $.extend({
				onClick : function () {
					var dg = $('#' + opts.woTableId).datagrid('unselectAll');
				}
			}, Wo.form.clear, bOpts);
		}
		
		/** ------------------   1.1.10.woSaveRowDetailFormButton   --------------------- */
		// 表单配置中按钮配置项woButtonType为woSave，并且woGridType为RowDetail时，调用此方法创建其配置
		// index：按钮的索引，fOpts：表单配置对象，opts：经过each方法中处理后的配置对象
		var woSaveRowDetailFormButton = function (index, fOpts, opts) {
			return fOpts.woButtons[index] = $.extend({
				// linkbutton如果不在toolbar里面，是没有handler方法的
				onClick : function () {
					Wo.ajax.submitForm ($.extend({
						woSuccess : function () {
							var dg = $('#' + opts.woTableId);
							dg.datagrid('reload');
						}
					}, Wo.form.save, fOpts));
				}
			}, Wo.form.save, fOpts.woButtons[index]);
		}
		
		/** ------------------   1.1.11.woCancelRowDetailFormButton   --------------------- */
		// 表单配置中按钮配置项woButtonType为woCancel，并且woGridType为RowDetail时，调用此方法创建其配置
		// index：按钮的索引，fOpts：表单配置对象，opts：经过each方法中处理后的配置对象
		var woCancelRowDetailFormButton = function (index, fOpts, opts) {
			return fOpts.woButtons[index] = $.extend({
				onClick : function () {
					var dg = $('#' + opts.woTableId);
					var row = fOpts.woSelectedRow;
					var i = dg.datagrid('getRowIndex', row);
					if (row.isNewRow) {
						dg.datagrid('deleteRow', i);
					} else {
						dg.datagrid('collapseRow', i);
						dg.datagrid('unselectRow', i);
					}
				}
			}, Wo.form.cancel, fOpts.woButtons[index]);
		}
		
		/** ------------------   1.2.woGridType为Standard时的相关方法   --------------------- */
		
		/** ------------------   1.2.0.initStandardOptions   --------------------- */
		var initStandardOptions = function (opts) {
			// 初始化表格工具栏中按钮的配置
			initToolbar(opts);
			// 创建表格
			$('#' + opts.woTableId).datagrid(opts);
		}
		
		/** ------------------   1.2.1.woCreateStandardButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woCreate，并且woGridType为Standard时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woCreateStandardButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			return opts.toolbar[index] = $.extend({
		    	onClick:function () {
		    		showDialog ({
		    			title : Wo.form.create.text
		    		}, {
		    			id : opts.woCreateFormId,
		    			url : opts.woCreateUrl
		    		}, opts.woCreateForm, opts);
		        }
			}, Wo.form.create, bOpts);
		}
		
		/** ------------------   1.2.2.woEditStandardButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woEdit，并且woGridType为Standard时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woEditStandardButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			return opts.toolbar[index] = $.extend({
		    	onClick:function () {
		    		me.wogrid ('getSelections', {
		    			woSelectType : 'single',
		    			getIds : function (ids, rows) {
		    				showDialog ({
				    			title:Wo.form.edit.text
				    		}, {
				    			id : opts.woUpdateFormId,
				    			url : opts.woUpdateUrl
				    		}, opts.woUpdateForm, opts, rows[0]);
		    			}
		    		});
		        }
			}, Wo.form.edit, bOpts);
		}
		
		/** ------------------   1.2.3.woDeleteStandardButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woDelete，并且woGridType为Standard时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woDeleteStandardButton = function (index, opts) {
			return woDeleteRowDetailButton(index, opts);
		}
		
		/** ------------------   1.2.4.woClearStandardButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woClear，并且woGridType为Standard时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woClearStandardButton = function (index, opts) {
			return woClearRowDetailButton(index, opts);
		}
		
		/** ------------------   1.2.10.woSaveStandardFormButton   --------------------- */
		// 表单配置中按钮配置项woButtonType为woSave，并且woGridType为Standard时，调用此方法创建其配置
		// index：按钮的索引，fOpts：表单配置对象，opts：经过each方法中处理后的配置对象
		var woSaveStandardFormButton = function (index, fOpts, opts) {
			return fOpts.woButtons[index] = $.extend({
				onClick : function () {
					Wo.ajax.submitForm ($.extend({
						woSuccess : function () {
							// 删除当前对话框
							$('#' + fOpts.id).parent().dialog ('destroy');
							// 刷新表格数据
							var dg = $('#' + opts.woTableId);
							dg.datagrid('reload');
						}
					}, fOpts));
				}
			}, Wo.form.save, fOpts.woButtons[index]);
		}
		
		/** ------------------   1.2.11.woCancelStandardFormButton   --------------------- */
		// 表单配置中按钮配置项woButtonType为woCancel，并且woGridType为Standard时，调用此方法创建其配置
		// index：按钮的索引，fOpts：表单配置对象，opts：经过each方法中处理后的配置对象
		var woCancelStandardFormButton = function (index, fOpts, opts) {
			return fOpts.woButtons[index] = $.extend({
				onClick : function () {
					$('#' + fOpts.id).parent().dialog ('destroy');
				}
			}, Wo.form.cancel, fOpts.woButtons[index]);
		}
		
		/** ------------------   1.3.woGridType为Tree时的相关方法   --------------------- */
		
		/** ------------------   1.3.0.initTreeOptions   --------------------- */
		var initTreeOptions = function (opts) {
			// 初始化表格工具栏中按钮的配置
			initToolbar(opts);
			// 创建表格
			$('#' + opts.woTableId).treegrid(opts);
		}
		
		/** ------------------   1.3.1.woCreateTreeButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woCreate，并且woGridType为Tree时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woCreateTreeButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			return opts.toolbar[index] = $.extend({
		    	onClick:function () {
		    		// 获取表格选中行，通过回调getIds返回选中数据
		    		me.wogrid ('getSelections', {
		    			woSelectType : 'singleornone',
		    			getIds : function (ids, rows) {
		    				var row = {};
		    				row [opts.parentField] = ids;
		    				showDialog ({
				    			title:Wo.form.create.text
				    		}, {
				    			id : opts.woCreateFormId,
				    			url : opts.woCreateUrl
				    		}, opts.woCreateForm, opts, row);
		    			}
		    		});
		        }
			}, Wo.form.create, bOpts);
		};
		
		/** ------------------   1.3.2.woEditTreeButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woEdit，并且woGridType为Tree时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woEditTreeButton = function (index, opts) {
			return woEditStandardButton (index, opts);
		};
		
		/** ------------------   1.3.3.woDeleteTreeButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woDelete，并且woGridType为Tree时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woDeleteTreeButton = function (index, opts) {
			var bOpts = opts.toolbar[index];
			var dg = $('#' + opts.woTableId);
			return opts.toolbar[index] = $.extend({
		    	onClick:function () {
		    		me.wogrid ('getSelections', {
		    			woSelectType : 'single',
		    			getIds : function (ids, rows) {
		    				Wo.msg.confirm ({
				    			woFn : function () {
				    				Wo.ajax.post({
				    					url : opts.woDeleteUrl,
				    					data : {woSelectedIds : ids},
				    					woSuccess : function (json) {
				    						dg.treegrid ('remove', ids);
				    					}
				    				});
				    			}
				    		});
		    			}
		    		});
		        }
			}, Wo.form.remove, bOpts);
		}
		
		/** ------------------   1.3.4.woClearTreeButton   --------------------- */
		// 表格toolbar中按钮配置项woButtonType为woClear，并且woGridType为Tree时，调用此方法创建其配置
		// index：按钮的索引，opts：经过each方法中处理后的配置对象
		var woClearTreeButton = function (index, opts) {
			// return woClearStandardButton (index, opts);
			var bOpts = opts.toolbar[index];
			return opts.toolbar[index] = $.extend({
				onClick : function () {
					$('#' + opts.woTableId).treegrid('unselectAll');
				}
			}, Wo.form.clear, bOpts);
		}
		
		/** ------------------   1.3.10.woSaveTreeFormButton   --------------------- */
		// 表单配置中按钮配置项woButtonType为woSave，并且woGridType为Tree时，调用此方法创建其配置
		// index：按钮的索引，fOpts：表单配置对象，opts：经过each方法中处理后的配置对象
		var woSaveTreeFormButton = function (index, fOpts, opts) {
			// return woSaveStandardFormButton (index, fOpts, opts);
			return fOpts.woButtons[index] = $.extend({
				onClick : function () {
					Wo.ajax.submitForm ($.extend({
						woSuccess : function () {
							// 删除当前对话框
							$('#' + fOpts.id).parent().dialog ('destroy');
							// 刷新表格数据
							var dg = $('#' + opts.woTableId);
							dg.treegrid('reload');
						}
					}, fOpts));
				}
			}, Wo.form.save, fOpts.woButtons[index]);
		}
		
		/** ------------------   1.3.11.woCancelTreeFormButton   --------------------- */
		// 表单配置中按钮配置项woButtonType为woCancel，并且woGridType为Tree时，调用此方法创建其配置
		// index：按钮的索引，fOpts：表单配置对象，opts：经过each方法中处理后的配置对象
		var woCancelTreeFormButton = function (index, fOpts, opts) {
			return woCancelStandardFormButton (index, fOpts, opts);
		}
		
		if (Wo.isString(options)){
			return $.fn.wogrid.methods[options](this, param);
		}
		options = options || {};
		
		// 根据列配置设置表单字段配置
		function getFieldOptionsByColumn (fdOpts, cOpts, i) {
			if (fdOpts == true) {
				fdOpts = {};
			}
			if (fdOpts.woType == 'woDictionaryCombo') {
				fdOpts = {
					woType : 'combobox',
					url : 'sys/dictionary/getItems?dicType=' + fdOpts.woDictionaryType,
					valueField : 'val',
					textField : 'name'
				}
			}
			return $.extend ({
				label : cOpts.title,
				woName : cOpts.field,
				woType : 'textbox',
				width : 200,
				woIndex : i * 10
			}, fdOpts);
		}
		
		// fOpts:表单配置，opts.woCreateForm或者woUpdateForm
		function setFormFields (fOpts, fields) {
			if (fOpts) {
				var fds = fOpts.woFields;
				if (fds) {
					for (var i = 0; i < fds.length; i ++) {
						// 从列配置中根据woName值匹配字段配置信息
						var cFd = Wo.array.find(fields, 'woName', fds[i].woName);
						if (cFd) {
							$.extend (cFd, fds[i]);
						} else {
							fields.push ($.extend({woIndex : 1000}, fds[i]));
						}
					}
					fields.sort (function(fd1, fd2) { return fd1.woIndex - fd2.woIndex});
				}
				fOpts.woFields = fields;
			}
		}
		// 此处的this为jQuery对象，each入参方法里的this为dom元素，$(this)才是jQuery对象
		return this.each (function () {
			// 合并$.fn.wogrid.defaults和options属性值，如果二者有同名属性，则取options的
			var opts = $.extend({}, $.fn.wogrid.defaults, options);
			// opts.woSearchId = 'woSearchPanel_' + opts.woId;
			if (this.id) {
				opts.woId = this.id;
			} else {
				$(this).attr("id", opts.woId);
			}
			this.id = opts.woId;
			opts.woToolbarId = 'woToolbarId_' + opts.woId;
			opts.woTableId = opts.woId;
			opts.woSearchFormId = 'woSearchForm_' + opts.woId;
			opts.woCreateFormId = 'woCreateForm_' + opts.woId;
			opts.woUpdateFormId = 'woUpdateForm_' + opts.woId;
			// 在表格列配置中获取修改和创建表单配置数据
			var createFields = [];
			var updateFields = [];
			var cols = opts.columns[opts.columns.length - 1];
			for (var i = 0; i < cols.length; i ++) {
				// 获取列配置
				var c = cols[i];
				// 设置创建表单配置
				if (c.woCreate) {
					createFields.push(getFieldOptionsByColumn (c.woCreate, c, i));
				}
				// 设置修改表单配置
				if (c.woUpdate) {
					updateFields.push(getFieldOptionsByColumn (c.woUpdate, c, i));
				}
			}
			setFormFields (opts.woCreateForm, createFields);
			setFormFields (opts.woUpdateForm, updateFields);
			// 表格数据加载前事件，在表格数据加载之前把查询表单中的值加到查询参数中
			opts.onBeforeLoad = Wo.value (opts.onBeforeLoad, function (param) {
		    	if (!param) {
		    		param = {};
		    	}
		    	var t = $('#' + opts.woSearchFormId).serializeArray();
		        $.each(t, function() {
		        	if (!Wo.isEmpty(this.value)) {
		        		param[this.name] = this.value;
		        	}
		        });
	            return true;
	        });
			// 分别调用initXXXOptions方法进行初始化
			eval ('init' + opts.woGridType + 'Options(opts)');
			// 从this对象中获取属性wogrid对应的对象
			var state = $.data(this, 'wogrid');
			if (state){
				$.extend(state.options, opts);
			} else {
				$.data(this, 'wogrid', {
					options: opts,
					wogrid: $(this)
				});
			}
		});
	};
	
	var getIdValues = function(selectRows, jq) {
		var ids = new Array();
		if (selectRows.length > 0) {
			var idField = jq.wogrid('options').idField;
			for (var i = 0, len = selectRows.length; i < len; i++) {
				// ids[i] = selectRows[i][idField]; // 得到选中行的主键ID
				if (selectRows[i][idField]) {
					ids.push (selectRows[i][idField]);
				}
			}
			return ids.toString();
		}
		return '';
	}
	
	$.fn.wogrid.methods = {
		options: function(jq) {
			// jq[0]是dom对象，而jq是jQuery对象
			return $.data(jq[0], 'wogrid').options;
		},
		getDataGrid : function (jq) {
			return $('#' + jq.wogrid('options').woTableId);
		},
		// {woSelectType : 'single/multiple/none/singleornone' , getIds : function
		// (selectedIds) {} , getRows : function (selectedRows) {}}
		getSelections : function(jq, cfg) {
			var dg = jq.wogrid('getDataGrid');
			var rows;
			if (jq.wogrid('options').woGridType == 'Tree') {
				rows = dg.treegrid('getSelections');
			} else {
				rows = dg.datagrid('getSelections');
			}
			if (!cfg || !cfg.woSelectType) {
				// ids = getIds(rows);
			} else if (cfg.woSelectType == 'singleornone') {
				if (rows.length > 1) {
					var warnMsg = '您选择的记录不能多于一条！';
					Wo.msg.warn(warnMsg);
					if (cfg.fnFailure) {
						cfg.fnFailure(jq[0], warnMsg);
					}
					return;
				}
			} else if (cfg.woSelectType == 'single') {
				if (rows.length != 1) {
					var warnMsg = '请选择一条记录！';
					Wo.msg.warn(warnMsg);
					if (cfg.fnFailure) {
						cfg.fnFailure(jq[0], warnMsg);
					}
					return;
				}
			} else if (cfg.woSelectType == 'multiple') {
				if (rows.length == 0) {
					var warnMsg = '请选择至少一条记录！';
					Wo.msg.warn(warnMsg);
					if (cfg.fnFailure) {
						cfg.fnFailure(jq[0], warnMsg);
					}
					return;
				}
			}
			if (cfg.getIds) {
				var ids = getIdValues(rows, jq);
				cfg.getIds(ids, rows);
			} else if (cfg.getRows) {
				cfg.getRows(rows);
			}
		}
	}
	
	$.fn.wogrid.defaults = {
		woId : Wo.id(),
		woTitle : '表格',
		woGridType : 'RowDetail',// Standard/RowDetail/Row/Tree
		pagination : false,
	    singleSelect : false,
		woSearchFields : [{
			woType : 'textbox',
			woName : 'woSearchContent',
			woText : '查询内容',
			iconCls:'icon-search',
		    iconAlign:'right',
		    width : 150,
		    prompt : '请输入查询内容'
		}],
		woFormColumns : 2
	};
	
	/** ------------------   2.wocombogrid定义   --------------------- */
	$.fn.wocombogrid = function (options, param) {
		
		var me = this;
		
		var initToolbar = function (opts) {
			// 设置查询字段配置对象默认值
			if (opts.woSearchFields) {
				for (var i = 0; i < opts.woSearchFields.length; i ++) {
					opts.woSearchFields[i] = $.extend ({}, $.fn.wogrid.defaults.woSearchFields[0], opts.woSearchFields[i]);
					if (!opts.woSearchFields[i].prompt) {
						opts.woSearchFields[i].prompt = '请输入' + opts.woSearchFields[i].woText;
					}
				}
				// 处理toolbar中的按钮
				if (!opts.toolbar || !Wo.isString (opts.toolbar)) {
					// var divTb = $(opts.woToolbarId);
					var divTb = $('<div id="' + opts.woToolbarId + '"/>').appendTo ($('body'));
					var tr = $('<tr />').appendTo($('<table />').appendTo($('<form id="' + opts.woSearchFormId + '" />').appendTo (divTb)));
					// 创建查询字段
					for (var i = 0; i < opts.woSearchFields.length; i ++) {
						$('<span> </span>').appendTo (tr);
						var f = opts.woSearchFields[i];
						// 定义onClickButton事件
						f.onClickButton = function fun () {
							var input = $(this).next('span').find('input:first');
							var val = input.val();
							input.next().val(val);
							$('#' + opts.woId).combogrid('grid').datagrid('reload');
						};
						// 在查询表单中创建查询字段
						var input = $('<input name="' + f.woName + '"/>').appendTo (tr);
						eval ('input.' + f.woType + '(f)');
						//eval('input.' + f.woType + '("onClickButton", fun)');
						// trap:此处必须
						input.next('span').find('input:first').attr('onclick', 'focus();');
						// input.next('span').find('a').attr('onclick', '$(this).next().blur();');
						// input.next('span').find('input').attr('onblur', 'blur();');
					}
					opts.toolbar = "#" + opts.woToolbarId;
				}
			}
		}
		
		if (Wo.isString(options)){
			var m = $.fn.wocombogrid.methods[options];
			if (m) {
				return m(this, param);
			} else {
				return this.combogrid (this, param);
			}
		}
		options = options || {};
		// 此处的this为jQuery对象，each入参方法里的this为dom元素，$(this)才是jQuery对象
		return this.each (function () {
			// 合并$.fn.wogrid.defaults和options属性值，如果二者有同名属性，则取options的
			var opts = $.extend({}, $.fn.wocombogrid.defaults, options);
			if (!opts.woId) {
				opts.woId = Wo.id();
			}
			// opts.woSearchId = 'woSearchPanel_' + opts.woId;
			opts.woToolbarId = 'woToolbarId_' + opts.woId;
			opts.woSearchFormId = 'woSearchForm_' + opts.woId;
			// 表格数据加载前事件，在表格数据加载之前把查询表单中的值加到查询参数中
			opts.onBeforeLoad = opts.onBeforeLoad || function (param) {
		    	if (!param) {
		    		param = {};
		    	}
		    	var inputs = $('#' + opts.woSearchFormId).find('input');
		    	for (var i = 0; i < inputs.length; i ++) {
		    		var name = $(inputs[i]).attr('name');
		    		var val = $(inputs[i]).val();
		    		if (name && !Wo.isEmpty(val)) {
		    			param[name] = val;
		    		}
		    	}
	            return true;
	        };
			// 初始化工具栏
			initToolbar(opts);
			// 创建下拉
			$('#' + opts.woId).combogrid(opts);
			// 从this对象中获取属性wocombogrid对应的对象
			var state = $.data(this, 'wocombogrid');
			if (state){
				$.extend(state.options, opts);
			} else {
				$.data(this, 'wocombogrid', {
					options: opts,
					wocombogrid: $(this)
				});
			}
		});
	};
	
	$.fn.wocombogrid.methods = {
		options: function(jq){
			return $.data(jq[0], 'wocombogrid').options;
		},
		wocombogrid: function(jq){
			return $.data(jq[0], 'wocombogrid').wocombogrid;
		}
	};
	
	$.fn.wocombogrid.defaults = $.extend ({
		woTitle : '下拉表格选择框',
		pagination : false,
	    singleSelect : true
	}, {});
})(jQuery);