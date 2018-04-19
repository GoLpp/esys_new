package com.zhu.esys.dto;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zhu.common.util.WoConstant;
import com.zhu.esys.entity.User;
import com.zhu.esys.entity.UserBook;

public class UserBookDto {
	private final static Logger LOG = LogManager.getLogger(UserBookDto.class);
	
	private String id;
	
	private String bookName;
	
	private Date upTime;
	
	private Integer counts;
	
	private String url;
	
	private UserDto user;
	
	private String userName;

	public UserBookDto() {
	}

	public UserBookDto(String id, String bookName, Date upTime, Integer counts, String url, UserDto user,
			String userName) {
		super();
		this.id = id;
		this.bookName = bookName;
		this.upTime = upTime;
		this.counts = counts;
		this.url = url;
		this.user = user;
		this.userName = userName;
	}
	
	public UserBookDto(UserBook userBook) {
		this.id = userBook.getId();
		this.bookName = userBook.getBookName();
		this.counts = userBook.getCounts();
		this.upTime = userBook.getUpTime();
		this.url = userBook.getUrl();
		this.user = new UserDto(userBook.getUser());
		this.userName = userBook.getUser().getLoginName();
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
    @JsonFormat(pattern = WoConstant.FORMAT_DATE, locale = "zh", timezone = "GMT+8")
	public Date getUpTime() {
		return upTime;
	}
    
    @DateTimeFormat(pattern = WoConstant.FORMAT_DATETIME)
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

	public UserDto getUser() {
		return user;
	}

	public void setUser(UserDto user) {
		this.user = user;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "UserBookDto [id=" + id + ", bookName=" + bookName + ", upTime=" + upTime + ", counts=" + counts
				+ ", url=" + url + ", user=" + user + ", userName=" + userName + "]";
	}
	
	public UserBook createEntity() {
		UserBook book = new UserBook();
		book.setBookName(bookName);
		book.setCounts(0);
		book.setUpTime(new Date());
		book.setUrl(url);
		return book;
	}
	
	public List<UserBookDto> gotDtos(List<UserBook> books) {
		List<UserBookDto> dtos = new ArrayList<>();
		for(UserBook book : books) {
			UserBookDto dto = new UserBookDto(book);
			dtos.add(dto);
		}
		return dtos;
	}
}
