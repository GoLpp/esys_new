package com.qfedu.esys.entity;
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

import com.qfedu.common.util.WoConstant;
@Entity
@Table(name="sys_lendrecord")
public class LendRcord {
	private final static Logger LOG = LogManager.getLogger(LendRcord.class);
	
	@Id
	@Column(length=100)
	@GeneratedValue(generator="uuid")
	@GenericGenerator(name="uuid", strategy="uuid")
	private String id;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern=WoConstant.FORMAT_DATETIME)
	private Date lendTime;
	
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(pattern=WoConstant.FORMAT_DATETIME)
	private Date returnTime;

	@Column(length=2)
	private String statu;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="binarybook_id")
	private BinaryBook binaryBook;

	public LendRcord() {
	}

	public LendRcord(String id, Date lendTime, Date returnTime, String statu, User user, BinaryBook binaryBook) {
		super();
		this.id = id;
		this.lendTime = lendTime;
		this.returnTime = returnTime;
		this.statu = statu;
		this.user = user;
		this.binaryBook = binaryBook;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Date getLendTime() {
		return lendTime;
	}

	public void setLendTime(Date lendTime) {
		this.lendTime = lendTime;
	}

	public Date getReturnTime() {
		return returnTime;
	}

	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
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
		return "LendRcord [id=" + id + ", lendTime=" + lendTime + ", returnTime=" + returnTime + ", statu=" + statu
				+ ", user=" + user + ", binaryBook=" + binaryBook + "]";
	}
}
