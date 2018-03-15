package com.qfedu.esys.entity;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.qfedu.common.util.WoConstant;
@Entity
@Table(name="sys_artice")
public class Article {
	private final static Logger LOG = LogManager.getLogger(Article.class);
	
	@Id
	@Column
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid")
	private String id;
	
	@Column(length=100)
	private String title;
	
	@Column(length=5000)
	private String content;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = WoConstant.FORMAT_DATETIME)
	private Date createTime;
	
	@Column(length=50)
	private Integer count;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@OneToMany(mappedBy="article")
	private List<Discuss> discusses;

	public Article() {
	}

	public Article(String id, String title, String content, Date createTime, Integer count, User user,
			List<Discuss> discusses) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.createTime = createTime;
		this.count = count;
		this.user = user;
		this.discusses = discusses;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Discuss> getDiscusses() {
		return discusses;
	}

	public void setDiscusses(List<Discuss> discusses) {
		this.discusses = discusses;
	}

	@Override
	public String toString() {
		return "Article [id=" + id + ", title=" + title + ", content=" + content + ", createTime=" + createTime
				+ ", count=" + count + ", user=" + user + ", discusses=" + discusses + "]";
	}
}
