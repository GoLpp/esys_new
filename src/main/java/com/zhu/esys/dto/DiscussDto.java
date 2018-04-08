package com.zhu.esys.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zhu.common.util.WoConstant;
import com.zhu.esys.entity.Discuss;

public class DiscussDto {
	private String id;
	
	private String content;
	
	private Date createTime;
	
	private UserDto user;
	
	private ArticleDto article;
	
	private String userName;
	
	private String articleName;

	public DiscussDto() {
	}
	
	public DiscussDto(Discuss discuss) {
		this.id = discuss.getId();
		this.content = discuss.getContent();
		this.createTime = discuss.getCreateTime();
		this.userName = discuss.getUser().getLoginName();
		this.articleName = discuss.getArticle().getTitle();
	}

	public DiscussDto(String id, String content, Date createTime, UserDto user, ArticleDto article, String userName,
			String articleName) {
		this.id = id;
		this.content = content;
		this.createTime = createTime;
		this.user = user;
		this.article = article;
		this.userName = userName;
		this.articleName = articleName;
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

	public ArticleDto getArticle() {
		return article;
	}

	public void setArticle(ArticleDto article) {
		this.article = article;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getArticleName() {
		return articleName;
	}

	public void setArticleName(String articleName) {
		this.articleName = articleName;
	}
	
	@Override
	public String toString() {
		return "DiscussDto [id=" + id + ", content=" + content + ", createTime=" + createTime + ", user=" + user
				+ ", article=" + article + ", userName=" + userName + ", articleName=" + articleName + "]";
	}

	public Discuss createEntity(DiscussDto dto) {
		Discuss discuss = new Discuss();
		discuss.setContent(content);
		discuss.setCreateTime(new Date());
		return discuss;
	}
	
	public List<DiscussDto> gotDtos(List<Discuss> discusses) {
		List<DiscussDto> dtos = new ArrayList<>();
		for(Discuss discuss : discusses) {
			DiscussDto dto = new DiscussDto(discuss);
			dtos.add(dto);
		}
		return dtos;
	}
}
