package com.zhu.esys.dao;

import java.util.List;

import com.zhu.esys.entity.BinaryBook;

public interface BianaryBookDao {
	
	List<BinaryBook> findAll(Long start, Long count, String bookId);
	
	void delete(BinaryBook binaryBook);
	
	void create(BinaryBook binaryBook);
	
	void update(BinaryBook binaryBook);
}
