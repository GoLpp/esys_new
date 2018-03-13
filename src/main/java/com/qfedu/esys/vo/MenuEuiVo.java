package com.qfedu.esys.vo;

import java.util.ArrayList;
import java.util.List;

import com.qfedu.esys.entity.Menu;

/**
 * EasyUI的菜单数据dto，对应EasyUI的tree控件的node数据，具体参数参考：http://www.jeasyui.com/documentation/index.php中的tree-Events中的说明.
 * 
 * @author cailei
 *
 */
public class MenuEuiVo {

	public static final String STATE_OPEN = "open";

	public static final String STATE_CLOSED = "closed";

	/**
	 * An identity value bind to the node.
	 */
	private String id;

	/**
	 * Text to be showed.
	 */
	private String text;

	/**
	 * The css class to display icon.
	 */
	private String iconCls;

	/**
	 * The node state, 'open' or 'closed'.
	 */
	private String state = STATE_OPEN;

	/**
	 * Whether the node is checked.
	 */
	private Boolean checked;

	/**
	 * custom attributes can be added to a node.
	 */
	private Menu attributes;
	
	public MenuEuiVo(Menu m) {
		this.id = m.getId();
		this.text = m.getName();
		this.iconCls = m.getIcon();
		if (m.getChildren().size() > 0) {
			this.state = STATE_CLOSED;
		}
		attributes = m;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public Menu getAttributes() {
		return attributes;
	}

	public void setAttributes(Menu attributes) {
		this.attributes = attributes;
	}

	/**
	 * @param menus
	 * @param ids
	 * @return
	 */
	public static List<MenuEuiVo> getVos(List<Menu> menus) {
		List<MenuEuiVo> results = new ArrayList<MenuEuiVo>();
		for (Menu m : menus) {
			MenuEuiVo dto = new MenuEuiVo(m);
			results.add(dto);
		}
		return results;
	}
}
