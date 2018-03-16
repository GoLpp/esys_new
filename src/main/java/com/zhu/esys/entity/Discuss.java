package com.zhu.esys.entity;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.zhu.common.util.WoConstant;

@Entity
@Table(name="sys_discuss")
public class Discuss {
	private final static Logger LOG = LogManager.getLogger(Discuss.class);

	@Id
	@Column(length=100)
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid")
	private String id;
	
	@Column(length=800)
	private String content;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = WoConstant.FORMAT_DATETIME)
	private Date createTime;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="article_id")
	private Article article;

	public Discuss() {
	}

	public Discuss(String id, String content, Date createTime, User user, Article article) {
		super();
		this.id = id;
		this.content = content;
		this.createTime = createTime;
		this.user = user;
		this.article = article;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Article getArticle() {
		return article;
	}

	public void setArticle(Article article) {
		this.article = article;
	}

	@Override
	public String toString() {
		return "Discuss [id=" + id + ", content=" + content + ", createTime=" + createTime + ", user=" + user
				+ ", article=" + article + "]";
	}
}
