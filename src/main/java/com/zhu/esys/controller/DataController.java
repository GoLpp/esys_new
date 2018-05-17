package com.zhu.esys.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.fasterxml.jackson.annotation.JacksonInject.Value;
import com.zhu.esys.dto.ArticleDto;
import com.zhu.esys.dto.BinaryBookDto;
import com.zhu.esys.service.ArticleService;
import com.zhu.esys.service.BinaryBookService;
import com.zhu.esys.util.ESysConstant;
import com.zhu.esys.vo.BookData;

@RestController
@SessionAttributes(names = ESysConstant.SESSION_USER)
@RequestMapping(value="/sys/data")
public class DataController {
	
	@Resource
	private BinaryBookService bookService;
	
	@Resource
	private ArticleService articleService;
	
	@RequestMapping(value="/getData")
	public BookData getData() {
		List<BinaryBookDto> dtos = bookService.getData();
		List<String> bookName = new ArrayList<>();
		List<Integer> data = new ArrayList<>();
		for(int i=0; i < 5; i++) {
			bookName.add(dtos.get(i).getBookName());
			data.add(dtos.get(i).getCount());
		}
		return new BookData(bookName, data);
	}
	
	@RequestMapping(value="/getArticleData")
	public BookData getArticleData() {
		List<ArticleDto> dtos = articleService.getData();
		List<String> bookName = new ArrayList<>();
		List<Integer> data = new ArrayList<>();
		for(int i = 0; i < 5; i++) {
			bookName.add(dtos.get(i).getTitle());
			data.add(dtos.get(i).getCount());
		}
		return new BookData(bookName,data);
	}
}
