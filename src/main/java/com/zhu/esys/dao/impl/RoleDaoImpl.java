package com.zhu.esys.dao.impl;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;

import com.zhu.common.dao.impl.BaseDaoImpl;
import com.zhu.esys.dao.RoleDao;
import com.zhu.esys.entity.Role;


@Repository
public class RoleDaoImpl extends BaseDaoImpl<Role> implements RoleDao{
	private final static Logger LOG = LogManager.getLogger(RoleDaoImpl.class);
}
