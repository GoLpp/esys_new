package com.zhu.esys.dao.impl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.zhu.common.dao.impl.BaseDaoImpl;
import com.zhu.esys.dao.BookDiscussDao;
import com.zhu.esys.entity.BookDiscuss;
@Repository
public class BookDiscussDaoImpl extends BaseDaoImpl<BookDiscuss> implements BookDiscussDao{
	private final static Logger LOG = LogManager.getLogger(BookDiscussDaoImpl.class);
}
