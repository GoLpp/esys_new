package com.zhu.esys.dto;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zhu.common.util.WoConstant;
import com.zhu.esys.entity.BookDiscuss;
import com.zhu.esys.entity.Discuss;

public class BookDiscussDto {
	private String id;
	
	private String content;
	
	private Date createTime;
	
	private UserDto user;
	
	private BinaryBookDto bookDto;
	
	private String userName;
	
	private String bookName;
	
	private String userId;
	
	private String bookId;

	public BookDiscussDto() {
	}
	
	public BookDiscussDto(String id, String content, Date createTime, UserDto user, BinaryBookDto bookDto,
			String userName, String bookName, String userId, String bookId) {
		this.id = id;
		this.content = content;
		this.createTime = createTime;
		this.user = user;
		this.bookDto = bookDto;
		this.userName = userName;
		this.bookName = bookName;
		this.userId = userId;
		this.bookId = bookId;
	}
	
	public BookDiscussDto(BookDiscuss discuss) {
		this.id = discuss.getId();
		this.content = discuss.getContent();
		this.createTime = discuss.getCreateTime();
		this.userName = discuss.getUser().getLoginName();
		this.bookName = discuss.getBinaryBook().getBookName();
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
    
	@JsonFormat(pattern = WoConstant.FORMAT_DATE, locale = "zh", timezone = "GMT+8")
	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public UserDto getUser() {
		return user;
	}

	public void setUser(UserDto user) {
		this.user = user;
	}

	public BinaryBookDto getBookDto() {
		return bookDto;
	}

	public void setBookDto(BinaryBookDto bookDto) {
		this.bookDto = bookDto;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getBookId() {
		return bookId;
	}

	public void setBookId(String bookId) {
		this.bookId = bookId;
	}

	public BookDiscuss createEntity() {
		BookDiscuss discuss = new BookDiscuss();
		discuss.setContent(content);
		discuss.setCreateTime(new Date());
		return discuss;
	}
	
	
}
