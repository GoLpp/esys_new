package com.zhu.esys.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.zhu.common.entity.WoResultCode;
import com.zhu.esys.dto.MenuDto;
import com.zhu.esys.entity.Menu;
import com.zhu.esys.service.MenuService;
import com.zhu.esys.vo.MenuEuiVo;
import com.zhu.esys.util.ESysConstant;


@RestController // 告诉springmvc按照对象来解析方法的返回.
@RequestMapping(value = "/sys/menu", produces = ESysConstant.APP_JSON) // 指定返回格式为json
public class MenuController {

    private final static Logger LOG = LogManager.getLogger(MenuController.class);

    @Resource // @Autowired
    private MenuService menuService;

    @RequestMapping(value = "/getChildren")
    public List<MenuEuiVo> getChildren(String id, HttpServletRequest req) {
    	List<Menu> list = menuService.getChildren(id, req);
        return MenuEuiVo.getVos(list); 
    } 
    
    @RequestMapping(value = "/list")
    public List<MenuDto> getList (String id, HttpServletRequest req) {
    	List<Menu> list = menuService.getChildren(id, req);
        return MenuDto.getDtos(list);
    }
    
    @RequestMapping(value = "/create")
    public WoResultCode create (MenuDto m) {
    	menuService.create (m);
    	return WoResultCode.getSuccessCode();
    }
}
