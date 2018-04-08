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
@Table(name="sys_bookdiscuss")
public class BookDiscuss {

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
	@JoinColumn(name="binarybook_id")
	private BinaryBook binaryBook;

	public BookDiscuss() {
	}

	public BookDiscuss(String id, String content, Date createTime, User user, BinaryBook binaryBook) {
		this.id = id;
		this.content = content;
		this.createTime = createTime;
		this.user = user;
		this.binaryBook = binaryBook;
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

	public BinaryBook getBinaryBook() {
		return binaryBook;
	}

	public void setBinaryBook(BinaryBook binaryBook) {
		this.binaryBook = binaryBook;
	}

	@Override
	public String toString() {
		return "BookDiscuss [id=" + id + ", content=" + content + ", createTime=" + createTime + ", user=" + user
				+ ", binaryBook=" + binaryBook + "]";
	}
}