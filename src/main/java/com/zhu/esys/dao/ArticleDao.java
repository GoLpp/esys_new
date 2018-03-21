package com.zhu.esys.dao;

import java.util.List;

import com.zhu.esys.entity.Article;

public interface ArticleDao {
	
	List<Article> findAll(Long start, Long count, String userId);
	
	void create(Article article);
	
	void update(Article article);
	
	void delete(Article article);
}
