package com.zhu.esys.service;

import com.zhu.common.entity.WoPage;
import com.zhu.esys.dto.RoleDto;

public interface RoleService {

	WoPage<RoleDto> getGridData(String name, long l, Long rows);
	
	void create(RoleDto dto);

	void update(RoleDto dto);

	void delete(String woSelectedIds);
}
