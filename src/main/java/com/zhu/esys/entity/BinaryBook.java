package com.zhu.esys.entity;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.ibatis.annotations.One;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zhu.common.util.WoConstant;
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
	
	@Column(length=200)
	private String descrip;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern=WoConstant.FORMAT_DATETIME)
	private Date publishTime;
	
	@Column(length=100)
	private String url;
	
	@Column(length=20)
	private Integer counts;
	
	@Column(length=2)
	private String statu;
	
	//借书记录和图书
	@JsonIgnore
	@OneToMany(mappedBy="binaryBook")
	private List<LendRcord> lendRcords;
	
	@Column(length=50)
	private String publish;

	public BinaryBook() {
	}

	public BinaryBook(String id, String bookName, String author, String descrip, Date publishTime, String url,
			Integer counts, String statu, List<LendRcord> lendRcords, String publish) {
		super();
		this.id = id;
		this.bookName = bookName;
		this.author = author;
		this.descrip = descrip;
		this.publishTime = publishTime;
		this.url = url;
		this.counts = counts;
		this.statu = statu;
		this.lendRcords = lendRcords;
		this.publish = publish;
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

	public String getDescrip() {
		return descrip;
	}

	public void setDescrip(String descrip) {
		this.descrip = descrip;
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

	public Integer getCounts() {
		return counts;
	}

	public void setCounts(Integer counts) {
		this.counts = counts;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public List<LendRcord> getLendRcords() {
		return lendRcords;
	}

	public void setLendRcords(List<LendRcord> lendRcords) {
		this.lendRcords = lendRcords;
	}

	public String getPublish() {
		return publish;
	}

	public void setPublish(String publish) {
		this.publish = publish;
	}

	@Override
	public String toString() {
		return "BinaryBook [id=" + id + ", bookName=" + bookName + ", author=" + author + ", descrip=" + descrip
				+ ", publishTime=" + publishTime + ", url=" + url + ", counts=" + counts + ", statu=" + statu
				+ ", lendRcords=" + lendRcords + ", publish=" + publish + "]";
	}
}
