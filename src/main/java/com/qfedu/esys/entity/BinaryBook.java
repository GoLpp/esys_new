package com.qfedu.esys.entity;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.qfedu.common.util.WoConstant;
@Entity
@Table(name="sys_binarybook")
public class BinaryBook {
	private final static Logger LOG = LogManager.getLogger(BinaryBook.class);
	
	@Id
	@Column(length=100)
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid")
	private String id;
	
	@Column(length=100)
	private String bookName;
	
	@Column(length=100)
	private String author;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern=WoConstant.FORMAT_DATETIME)
	private Date publishTime;
	
	@Column(length=100)
	private String url;
	
	@Column(length=2)
	private String statu;

	public BinaryBook() {
	}

	public BinaryBook(String id, String bookName, String author, Date publishTime, String url, String statu) {
		super();
		this.id = id;
		this.bookName = bookName;
		this.author = author;
		this.publishTime = publishTime;
		this.url = url;
		this.statu = statu;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public Date getPublishTime() {
		return publishTime;
	}

	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	@Override
	public String toString() {
		return "BinaryBook [id=" + id + ", bookName=" + bookName + ", author=" + author + ", publishTime=" + publishTime
				+ ", url=" + url + ", statu=" + statu + "]";
	}
}
