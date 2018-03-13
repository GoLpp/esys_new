package com.qfedu.esys.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.qfedu.common.util.WoUtil;
import com.qfedu.esys.dao.IMenuDao;
import com.qfedu.esys.dao.IRoleDao;
import com.qfedu.esys.dao.impl.RoleDao;
import com.qfedu.esys.dto.MenuDto;
import com.qfedu.esys.dto.RoleDto;
import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.Menu;
import com.qfedu.esys.entity.Role;
import com.qfedu.esys.entity.User;
import com.qfedu.esys.service.IMenuService;

@Service
@Transactional // 所有public方法都放在一個事务中
public class MenuService implements IMenuService {
	private final static Logger LOG = LogManager.getLogger(MenuService.class);

	@Resource // @Autowired
	private IMenuDao menuDao;
	
	@Resource 
	private IRoleDao roleDao;

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
