package com.zhu.esys.service.impl;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.zhu.common.entity.WoPage;
import com.zhu.common.util.WoUtil;
import com.zhu.esys.dao.DictionaryDao;
import com.zhu.esys.entity.Dictionary;
import com.zhu.esys.service.DictionaryService;


@Service
@Transactional
public class DictionaryServiceImpl implements DictionaryService {
	private final static Logger LOG = LogManager.getLogger(DictionaryServiceImpl.class);

	@Resource
	private DictionaryDao dictionaryDao;
	
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
