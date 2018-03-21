package com.zhu.esys.dao;

import java.util.List;

import com.zhu.esys.entity.UserBook;

public interface UserBookDao {
	List<UserBook> findAll(Long start, Long count, String userId);
	
	void create(UserBook userBook);
	
	void delete(UserBook userBook);
	
	void update(UserBook userBook);
}
