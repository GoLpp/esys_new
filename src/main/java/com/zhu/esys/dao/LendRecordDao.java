package com.zhu.esys.dao;

import java.util.List;

import com.zhu.esys.entity.LendRcord;

public interface LendRecordDao {
	List<LendRcord> findAll(Long start, Long count, String userId);
	
	void create(LendRcord lendRcord);
	
	void update(LendRcord lendRcord);
	
	void delete(LendRcord lendRcord);	
}
