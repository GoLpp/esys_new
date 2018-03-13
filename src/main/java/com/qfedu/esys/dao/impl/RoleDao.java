package com.qfedu.esys.dao.impl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.qfedu.common.dao.impl.BaseDao;
import com.qfedu.esys.dao.IRoleDao;
import com.qfedu.esys.entity.Role;

@Repository
public class RoleDao extends BaseDao<Role> implements IRoleDao{
	private final static Logger LOG = LogManager.getLogger(RoleDao.class);
}
