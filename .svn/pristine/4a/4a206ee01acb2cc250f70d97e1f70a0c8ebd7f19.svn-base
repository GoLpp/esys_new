package com.qfedu.esys.dto;

import java.util.ArrayList;
import java.util.List;

import com.qfedu.common.util.WoUtil;
import com.qfedu.esys.entity.Menu;

public class MenuDto {

	public static final String STATE_OPEN = "open";

	public static final String STATE_CLOSED = "closed";
	
	private String id;

	private String name;

	private String no;

	private String icon;

	private String resource;

	private String resourceType;

	private String parentId;

	private String parentName;

	/**
	 * The node state, 'open' or 'closed'.
	 */
	private String state = STATE_OPEN;
	
	public MenuDto() {

	}

	public MenuDto(MenuDto m) {
		this.id = m.getId();
		this.name = m.getName();
		this.no = m.getNo();
		this.icon = m.getIcon();
		this.resource = m.getResource();
		this.resourceType = m.getResourceType();
		this.parentId = m.getParentId();
		this.parentName = m.getParentName();
		this.state = m.getState();
	}

	public MenuDto(Menu m) {
		this.id = m.getId();
		this.name = m.getName();
		this.no = m.getNo();
		this.icon = m.getIcon();
		this.resource = m.getResource();
		this.resourceType = m.getResourceType();
		if (m.getParent() != null) {
			this.parentId = m.getParent().getId();
			this.parentName = m.getParent().getName();
		}
		if (m.getChildren().size() > 0) {
			this.state = STATE_CLOSED;
		}
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getResource() {
		return resource;
	}

	public void setResource(String resource) {
		this.resource = resource;
	}

	public String getResourceType() {
		return resourceType;
	}

	public void setResourceType(String resourceType) {
		this.resourceType = resourceType;
	}

	/**
	 * @param menus
	 * @return
	 */
	public static List<MenuDto> getDtos(List<Menu> menus) {
		List<MenuDto> results = new ArrayList<MenuDto>();
		for (Menu m : menus) {
			MenuDto dto = new MenuDto(m);
			results.add(dto);
		}
		return results;
	}

	/**
	 * @return
	 */
	public Menu createEntity() {
		Menu m = new Menu();
		m.setId(id);
		m.setIcon(icon);
		m.setName(name);
		m.setNo(no);
		m.setResource(resource);
		m.setResourceType(resourceType);
		Menu parent = new Menu();
		if (!WoUtil.isEmpty(parentId)) {
			parent.setId(this.parentId);
			m.setParent(parent);
		}
		return m;
	}
}
