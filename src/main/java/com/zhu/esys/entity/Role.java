package com.zhu.esys.entity;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="sys_role")
public class Role {
	private final static Logger LOG = LogManager.getLogger(Role.class);
	
	@Id
	@Column(length=50)
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid")
	private String id;
	
	@Column(length=20)
	private  String name;
	
	@Column(length=200)
	private String description;
	
	@Column(length=2)
	private String type;
		
	@JsonIgnore
	@ManyToMany(fetch=FetchType.EAGER)
	@JoinTable(name="sys_role_menu", joinColumns=@JoinColumn(name="role_id"),
			inverseJoinColumns=@JoinColumn(name="menu_id"))
	private List<Menu> menus;

	public Role() {
	}

	public Role(String id, String name, String description, String type, List<Menu> menus) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.type = type;
		this.menus = menus;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public List<Menu> getMenus() {
		return menus;
	}

	public void setMenus(List<Menu> menus) {
		this.menus = menus;
	}

	@Override
	public String toString() {
		return "Role [id=" + id + ", name=" + name + ", description=" + description + ", type=" + type + ", menus="
				+ menus + "]";
	}
}
