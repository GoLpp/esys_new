package com.zhu.esys.dto;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.hibernate.annotations.GenericGenerator;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zhu.common.util.WoConstant;
import com.zhu.esys.entity.BinaryBook;
import com.zhu.esys.entity.LendRcord;
import com.zhu.esys.entity.User;

public class LendRcordDto {
	private final static Logger LOG = LogManager.getLogger(LendRcordDto.class);
	
	private String id;
	
	private Date lendTime;
	
	private Date returnTime;

	private String statu;
	
	private String userName;
	
	private	String bookName;

	public LendRcordDto() {
	}

	public LendRcordDto(String id, Date lendTime, Date returnTime, String statu, String userName, String bookName) {
		this.id = id;
		this.lendTime = lendTime;
		this.returnTime = returnTime;
		this.statu = statu;
		this.userName = userName;
		this.bookName = bookName;
	}
	
	public LendRcordDto(LendRcord record) {
		this.id = record.getId();
		this.lendTime = record.getLendTime();
		this.returnTime = record.getReturnTime();
		if(record.getStatu().equals("1")) {
			this.statu = "归还";
		}else{
			this.statu = "未归还";
		}
		this.userName = record.getUser().getLoginName();
		this.bookName = record.getBinaryBook().getBookName();
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
    @JsonFormat(pattern = WoConstant.FORMAT_DATE, locale = "zh", timezone = "GMT+8")
	public Date getLendTime() {
		return lendTime;
	}
   
    @DateTimeFormat(pattern = WoConstant.FORMAT_DATE)
	public void setLendTime(Date lendTime) {
		this.lendTime = lendTime;
	}
   
	@JsonFormat(pattern = WoConstant.FORMAT_DATE, locale = "zh", timezone = "GMT+8")
	public Date getReturnTime() {
		return returnTime;
	}
	
	@DateTimeFormat(pattern = WoConstant.FORMAT_DATE)
	public void setReturnTime(Date returnTime) {
		this.returnTime = returnTime;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	@Override
	public String toString() {
		return "LendRcordDto [id=" + id + ", lendTime=" + lendTime + ", returnTime=" + returnTime + ", statu=" + statu
				+ ", userName=" + userName + ", bookName=" + bookName + "]";
	}
	
	public List<LendRcordDto> gotDtos(List<LendRcord> records) {
		List<LendRcordDto> dtos = new ArrayList<>();
		for(LendRcord record : records) {
			LendRcordDto dto = new LendRcordDto(record);
			dtos.add(dto);
		}
		return dtos;
	}
}
