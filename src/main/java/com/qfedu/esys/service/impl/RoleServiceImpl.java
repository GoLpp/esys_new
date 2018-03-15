package com.qfedu.esys.service.impl;
import java.util.ArrayList;
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
import com.qfedu.esys.dao.RoleDao;
import com.qfedu.esys.dto.RoleDto;
import com.qfedu.esys.entity.Menu;
import com.qfedu.esys.entity.Role;
import com.qfedu.esys.service.RoleService;

@Service
@Transactional
public class RoleServiceImpl implements RoleService{
	private final static Logger LOG = LogManager.getLogger(RoleServiceImpl.class);
	
	@Resource
	private RoleDao roleDao;
	
	@Override
	public WoPage<RoleDto> getGridData(String name, long start, Long rows) {
		String whereOrOrderBy = null;
		Map<String, Object> props = new HashMap<>();
		if(!WoUtil.isEmpty(name)) {
			whereOrOrderBy = "e.name like :name";
			props.put("name", "%" + name + "%");
		}
		WoPage<Role> pr = roleDao.findAllBy(whereOrOrderBy, start, rows, props);
		return RoleDto.getGridData(pr.getRows(), pr.getResults());
	}

	@Override
	public void create(RoleDto dto) {
		Role role = dto.createEntity();
		List<Menu> menus = new ArrayList<>();
		for(String mId: dto.getMenuIdArray()) {
			Menu menu = new Menu();
			menu.setId(mId);
			menus.add(menu);
		}
		role.setMenus(menus);
		roleDao.create(role);
	}

	@Override
	public void update(RoleDto dto) {
		Role role = dto.createEntity();
		List<Menu> menus = new ArrayList<>();
		for(String mId: dto.getMenuIdArray()) {
			Menu menu = new Menu();
			menu.setId(mId);
			menus.add(menu);
		}
		role.setMenus(menus);
		roleDao.update(role);
	}

	@Override
	public void delete(String woSelectedIds) {
		String[] idStrings = WoUtil.splitIds(woSelectedIds);
		for(String id: idStrings) {
			Role role = new Role();
			role.setId(id);
			roleDao.delete(role);
		}
	}
	
}
