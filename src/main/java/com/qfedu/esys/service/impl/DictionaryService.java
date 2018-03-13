package com.qfedu.esys.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.qfedu.common.entity.WoPage;
import com.qfedu.common.util.WoUtil;
import com.qfedu.esys.dao.IDictionaryDao;
import com.qfedu.esys.entity.Dictionary;
import com.qfedu.esys.service.IDictionaryService;

@Service
@Transactional
public class DictionaryService implements IDictionaryService {
	private final static Logger LOG = LogManager.getLogger(DictionaryService.class);

	@Resource
	private IDictionaryDao dictionaryDao;
	
	@Override
	public WoPage<Dictionary> getGridData(String dicType, Long start, Long limit) {
		String where = "order by e.dicType";
		Map<String, Object> map = new HashMap<String, Object>();
		if (!WoUtil.isEmpty(dicType)) {
			where = "e.dicType like :dicType " + where;
			map.put("dicType", "%" + dicType + "%");
		}
		return dictionaryDao.findAllBy(where, start, limit, map);
	}

	@Override
	public void create(Dictionary dic) {
		// TODO Auto-generated method stub

	}

	@Override
	public void update(Dictionary dic) {
		// TODO Auto-generated method stub

	}

	@Override
	public void delete(String[] ids) {
		// TODO Auto-generated method stub

	}

	@Override
	public List<Dictionary> getByType(String dicType) {
		String where = "order by e.dicType";
		Map<String, Object> map = new HashMap<String, Object>();
		if (!WoUtil.isEmpty(dicType)) {
			where = "e.dicType like :dicType " + where;
			map.put("dicType", "%" + dicType + "%");
		}
		return dictionaryDao.findAllBy(where, map);
	}
}
