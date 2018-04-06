package com.zhu.esys.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zhu.common.util.WoConstant;
import com.zhu.esys.entity.Article;
import com.zhu.esys.entity.Discuss;

public class ArticleDto {
	
	private String id;
	
	private String title;
	
	private String content;
	
	private Date createTime;
	
	private Integer count;
	
	private String userName;
	
	private UserDto userDto;
	
	private List<DiscussDto> discusses = new ArrayList<>();

	public ArticleDto() {
	}
	
	public ArticleDto(Article article) {
		this.id = article.getId();
		this.title = article.getTitle();
		this.content = article.getContent();
		this.createTime = article.getCreateTime();
		this.userName = article.getUser().getLoginName();
		this.count = article.getCount();
		if(null != article.getDiscusses()) {
			for(Discuss discuss : article.getDiscusses()) {
				DiscussDto dto = new DiscussDto(discuss);
				discusses.add(dto);
			}
		}
	}

	public ArticleDto(String id, String title, String content, Date createTime, Integer count, String userName,
			UserDto userDto, List<DiscussDto> discusses) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.createTime = createTime;
		this.count = count;
		this.userName = userName;
		this.userDto = userDto;
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
    
	@JsonFormat(pattern = WoConstant.FORMAT_DATE, locale = "zh", timezone = "GMT+8")
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public UserDto getUserDto() {
		return userDto;
	}

	public void setUserDto(UserDto userDto) {
		this.userDto = userDto;
	}

	public List<DiscussDto> getDiscusses() {
		return discusses;
	}

	public void setDiscusses(List<DiscussDto> discusses) {
		this.discusses = discusses;
	}

	@Override
	public String toString() {
		return "ArticleDto [id=" + id + ", title=" + title + ", content=" + content + ", createTime=" + createTime
				+ ", count=" + count + ", userName=" + userName + ", userDto=" + userDto + ", discusses=" + discusses
				+ "]";
	}
}
