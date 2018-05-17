package com.zhu.esys.vo;

import java.util.ArrayList;
import java.util.List;

public class BookData {
	
	private List<String> bookName = new ArrayList<>();
	private List<Integer> data = new ArrayList<>();
	
	public BookData() {
		
	}
	
	public BookData(List<String> bookName, List<Integer> data) {
		super();
		this.bookName = bookName;
		this.data = data;
	}

	public List<String> getBookName() {
		return bookName;
	}

	public void setBookName(List<String> bookName) {
		this.bookName = bookName;
	}

	public List<Integer> getData() {
		return data;
	}

	public void setData(List<Integer> data) {
		this.data = data;
	}
}
