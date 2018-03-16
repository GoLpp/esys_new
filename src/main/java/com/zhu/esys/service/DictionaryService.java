package com.zhu.esys.service;

import java.util.List;

import com.zhu.common.entity.WoPage;
import com.zhu.esys.entity.Dictionary;

public interface DictionaryService {

	WoPage<Dictionary> getGridData(String dicType, Long start, Long limit);

	void create(Dictionary dic);
	
	void update(Dictionary dic);

	void delete (String[] ids);
	
	List<Dictionary> getByType (String type);
}
