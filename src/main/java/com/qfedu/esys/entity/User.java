package com.qfedu.esys.entity;


import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.qfedu.common.util.WoConstant;

@Entity
@Table(name="sys_user")
public class User implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4826243346924750684L;

	@Id
	@Column(length=50)
	@GeneratedValue(generator = "uuid")
	@GenericGenerator(name = "uuid", strategy = "uuid")
	private String id;
	
	@Column(length=20)
	private String loginName;

	@Column(length=50)
	private String password = "123456";
	
	@Column(length=200)
	private String sex;
	
	@Column(length=200)
	private String tel;

	@Column(length=200)
	private String headImage;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = WoConstant.FORMAT_DATETIME)
	private Date createTime;
	
	@ManyToMany // (cascade=CascadeType.REMOVED)
	@JoinTable(name = "sys_user_role",
	joinColumns = {@JoinColumn(name = "user_id")},
	inverseJoinColumns = {@JoinColumn(name = "role_id")})
	private List<Role> roles;
	
	//用户图书
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<UserBook> userBooks;
	
	//用户和借书记录
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<LendRcord> lendRcords;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Article> articles;
	
	@JsonIgnore
	@OneToMany(mappedBy="user")
	private List<Discuss> discusses;
	
	public List<Role> getRoles() {
		return roles;
	}

	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getHeadImage() {
		return headImage;
	}

	public void setHeadImage(String headImage) {
		this.headImage = headImage;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	/**
	 * @return
	 */
	public Boolean isAdmin () {
		return "admin".equals(this.getLoginName());
	}

	public List<UserBook> getUserBooks() {
		return userBooks;
	}

	public void setUserBooks(List<UserBook> userBooks) {
		this.userBooks = userBooks;
	}

	public List<LendRcord> getLendRcords() {
		return lendRcords;
	}

	public void setLendRcords(List<LendRcord> lendRcords) {
		this.lendRcords = lendRcords;
	}

	public List<Article> getArticles() {
		return articles;
	}

	public void setArticles(List<Article> articles) {
		this.articles = articles;
	}

	public List<Discuss> getDiscusses() {
		return discusses;
	}

	public void setDiscusses(List<Discuss> discusses) {
		this.discusses = discusses;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", loginName=" + loginName + ", password=" + password + ", sex=" + sex + ", tel="
				+ tel + ", headImage=" + headImage + ", createTime=" + createTime + ", roles=" + roles + ", userBooks="
				+ userBooks + ", lendRcords=" + lendRcords + ", articles=" + articles + ", discusses=" + discusses
				+ "]";
	}
}
