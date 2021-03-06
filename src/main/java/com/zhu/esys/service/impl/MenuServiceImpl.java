package com.zhu.esys.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.zhu.common.util.WoUtil;
import com.zhu.esys.dao.MenuDao;
import com.zhu.esys.dao.RoleDao;
import com.zhu.esys.dto.MenuDto;
import com.zhu.esys.dto.RoleDto;
import com.zhu.esys.dto.UserDto;
import com.zhu.esys.entity.Menu;
import com.zhu.esys.entity.Role;
import com.zhu.esys.service.MenuService;


@Service
@Transactional // 所有public方法都放在一個事务中
public class MenuServiceImpl implements MenuService {
	private final static Logger LOG = LogManager.getLogger(MenuServiceImpl.class);

	@Resource // @Autowired
	private MenuDao menuDao;
	
	@Resource 
	private RoleDao roleDao;

	@Override
	public List<Menu> getChildren(String parentId, HttpServletRequest req) {
		List<Menu> allMenus = getChildren(parentId);
		
		UserDto userDto = (UserDto) req.getSession().getAttribute("woUser");
		
		List<Menu> allowedMenu = new ArrayList<>();
		
		List<RoleDto> roleDtos = userDto.getRoles();
		
		for(RoleDto roleDto : roleDtos) {
			if("admin".equals(roleDto.getId())) {
				return allMenus;
			}

			Role role = roleDao.findById(roleDto.getId());
			
			for(Menu menu : role.getMenus()) {
				for(Menu child : allMenus) {
					if( isAllowed(menu, child) && !isIn(allowedMenu, child.getId())) {
						allowedMenu.add(menu);
					}
				}
			}
		}
		return allowedMenu;
	}

	private boolean isAllowed(Menu menu, Menu child) {
		while(menu != null) {
			if(menu.getId().equals(child.getId())) {
				return true;
			}
			menu = menu.getParent();
		}
		return false;
	}

	private boolean isIn(List<Menu> allowedMenu, String id) {
		for(Menu menu : allowedMenu) {
			if(menu.getId().equals(id)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public void create(MenuDto dto) {
		Menu m = dto.createEntity();
		m.setId(WoUtil.uuid());
		menuDao.create(m);
	}

	@Override
	public List<Menu> getChildren(String id) {
		// 1.查询所有子菜单
		List<Menu> menus;
		if (StringUtils.isEmpty(id)) {
			// 查询所有顶级菜单
			menus = menuDao.findAllTops();
		} else {
			// 查询parentId对应菜单下的子菜单
			menus = menuDao.findAllByParentId(id);
		}
		return menus;
	}
}
