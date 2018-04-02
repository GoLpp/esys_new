package com.zhu.esys.dto;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.context.annotation.EnableLoadTimeWeaving;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.zhu.common.util.WoConstant;
import com.zhu.esys.entity.BinaryBook;
import com.zhu.esys.entity.LendRcord;

public class BinaryBookDto {
	private final static Logger LOG = LogManager.getLogger(BinaryBookDto.class);
	
	private String id = "";
	
	private String bookName = "";
	
	private String author = "";
	
	private String descrip = "";
	
	private Date publishTime;
	
	private String url = "";
	
	private Integer count = 0;
	
	private String statu = "1";
	
	private String publish = "";

	public BinaryBookDto() {
	}

	public BinaryBookDto(String id, String bookName, String author, String descrip, Date publishTime, String url,
			Integer count, String statu, String publish) {
		this.id = id;
		this.bookName = bookName;
		this.author = author;
		this.descrip = descrip;
		this.publishTime = publishTime;
		this.url = url;
		this.count = count;
		this.statu = statu;
		this.publish = publish;
	}
	
	public BinaryBookDto(BinaryBook book) {
		this.id = book.getId();
		this.bookName = book.getBookName();
		this.author = book.getAuthor();
		this.descrip = book.getDescrip();
		this.publishTime = book.getPublishTime();
		this.url = book.getUrl();
		this.count = book.getCount();
		if(book.getStatu().equals("1")) {
			this.statu = "未借出";
		}else if(book.getStatu().equals("0")) {
			this.statu = "借出";
		}else{
			this.statu = "";
		}
		this.publish = book.getPublish();
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
	
    @JsonFormat(pattern = WoConstant.FORMAT_DATE, locale = "zh", timezone = "GMT+8")
	public Date getPublishTime() {
		return publishTime;
	}
    
    @DateTimeFormat(pattern = WoConstant.FORMAT_DATE)
	public void setPublishTime(Date publishTime) {
		this.publishTime = publishTime;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getStatu() {
		return statu;
	}

	public void setStatu(String statu) {
		this.statu = statu;
	}

	public String getPublish() {
		return publish;
	}

	public void setPublish(String publish) {
		this.publish = publish;
	}

	@Override
	public String toString() {
		return "BinaryBookDto [id=" + id + ", bookName=" + bookName + ", author=" + author + ", descrip=" + descrip
				+ ", publishTime=" + publishTime + ", url=" + url + ", count=" + count + ", statu=" + statu
				+ ", publish=" + publish + "]";
	}
	
	public BinaryBook createEntity() {
		BinaryBook book = new BinaryBook();
		book.setAuthor(author);
		book.setBookName(bookName);
		book.setDescrip(descrip);
		book.setPublish(publish);
		book.setPublishTime(publishTime);
		book.setStatu(statu);
		book.setUrl(url);
		book.setCount(count);
		return book;
	}
	
	public List<BinaryBookDto> dtos(List<BinaryBook> books) {
		List<BinaryBookDto> dtos = new ArrayList<>();
		for(BinaryBook book : books) {
			BinaryBookDto dto = new BinaryBookDto(book);
			dtos.add(dto);
		}
		return dtos;
	}
}
