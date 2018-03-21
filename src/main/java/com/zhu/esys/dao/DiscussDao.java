package com.zhu.esys.dao;

import java.util.List;

import com.zhu.esys.entity.Discuss;

public interface DiscussDao {
	
	List<Discuss> findAll(Long start, Long count, String articleId);
	
	void create(Discuss discuss);
	
	void update(Discuss discuss);
	
	void delete(Discuss discuss);
}
