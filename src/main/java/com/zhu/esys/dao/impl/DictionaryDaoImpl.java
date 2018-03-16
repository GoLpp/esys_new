package com.zhu.esys.dao.impl;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.zhu.common.dao.impl.BaseDaoImpl;
import com.zhu.esys.dao.DictionaryDao;
import com.zhu.esys.entity.Dictionary;


@Repository
public class DictionaryDaoImpl extends BaseDaoImpl<Dictionary> implements DictionaryDao {

	private final static Logger LOG = LogManager.getLogger(DictionaryDaoImpl.class);
}
