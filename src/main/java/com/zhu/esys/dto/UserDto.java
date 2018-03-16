package com.zhu.esys.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zhu.common.util.WoConstant;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.entity.Role;
import com.zhu.esys.entity.User;

public class UserDto {
	private final static Logger LOG = LogManager.getLogger(UserDto.class);

	private String id;
	private String loginName;
	private String password;
	private Date date = new Date();
	private List<RoleDto> roles = new ArrayList<>();
	private String roleIds = "";
	private String roleNames = "";
	private String roleId;
	private Date createTime;
	private String headImage;
	private List<UserDto> userDtos = new ArrayList<>();
	private String woSelectedIds;
	private String sex;
	private String tel;
	
	public UserDto() {
		
	}

	public UserDto(User user) {
		this.id = user.getId();
		this.loginName = user.getLoginName();
		this.password = user.getPassword();
		this.createTime = user.getCreateTime();
		this.sex = user.getSex();
		this.tel = user.getTel();
		for (Role r : user.getRoles()) {
			if (!"".equals(roleIds)) {
				roleIds += ",";
				roleNames += ",";
			}
			roleIds += r.getId();
			roleNames += r.getName();
			RoleDto rDto = new RoleDto();
			rDto.setId(r.getId());
			rDto.setName(r.getName());
			roles.add(rDto);
		}
	}

	public UserDto(String loginName, String password, Date date, List<RoleDto> roles) {
		super();
		this.loginName = loginName;
		this.password = password;
		this.date = date;
		this.roles = roles;
	}

	public User createEntity() {
		User user = new User();
		user.setId(id);
		user.setLoginName(loginName);
		user.setPassword(password);
		user.setCreateTime(new Date());
		user.setHeadImage(headImage);
		user.setSex(sex);
		user.setTel(tel);
		List<Role> roles = new ArrayList<>();
		for (String id : getRoleArray()) {
			Role role = new Role();
			role.setId(id);
			roles.add(role);
		}
		user.setRoles(roles);
		return user;
	}

	public String[] getRoleArray() {
		return WoUtil.splitIds(roleId);
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public List<RoleDto> getRoles() {
		return roles;
	}

	public void setRoles(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public String getWoSelectedIds() {
		return woSelectedIds;
	}

	public void setWoSelectedIds(String woSelectedIds) {
		this.woSelectedIds = woSelectedIds;
	}

	@JsonFormat(pattern = WoConstant.FORMAT_DATETIME, locale = "zh", timezone = "GMT+8")
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}

	public String getRoleNames() {
		return roleNames;
	}

	public void setRoleNames(String roleNames) {
		this.roleNames = roleNames;
	}

	public String getHeadImage() {
		return headImage;
	}

	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}

	public List<UserDto> getUserDtos() {
		return userDtos;
	}

	public void setUserDtos(List<UserDto> userDtos) {
		this.userDtos = userDtos;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public void setRoles(List<RoleDto> roles) {
		this.roles = roles;
	}
}
