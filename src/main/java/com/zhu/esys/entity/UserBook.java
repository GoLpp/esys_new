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

import net.sf.ehcache.search.aggregator.Count;
@Entity
@Table(name="sys_userbook")
public class UserBook {
	private final static Logger LOG = LogManager.getLogger(UserBook.class);
	
	@Id
	@Column(length=100)
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid")
	private String id;
	
	@Column(length=100)
	private String bookName;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern = WoConstant.FORMAT_DATETIME)
	private Date upTime;
	
	@Column(length=20)
	private Integer counts;
	
	@Column(length=100)
	private String url;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;

	public UserBook() {
	}

	public UserBook(String id, String bookName, Date upTime, Integer counts, String url, User user) {
		super();
		this.id = id;
		this.bookName = bookName;
		this.upTime = upTime;
		this.counts = counts;
		this.url = url;
		this.user = user;
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

	public Date getUpTime() {
		return upTime;
	}

	public void setUpTime(Date upTime) {
		this.upTime = upTime;
	}

	public Integer getCounts() {
		return counts;
	}

	public void setCounts(Integer counts) {
		this.counts = counts;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "UserBook [id=" + id + ", bookName=" + bookName + ", upTime=" + upTime + ", counts=" + counts + ", url="
				+ url + ", user=" + user + "]";
	}
}
