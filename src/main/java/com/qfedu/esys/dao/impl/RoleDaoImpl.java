package com.qfedu.esys.dao.impl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.qfedu.common.dao.impl.BaseDaoImpl;
import com.qfedu.esys.dao.RoleDao;
import com.qfedu.esys.entity.Role;

@Repository
public class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDao{
	private final static Logger LOG = LogManager.getLogger(RoleDaoImpl.class);
}
