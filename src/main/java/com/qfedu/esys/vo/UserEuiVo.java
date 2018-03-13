package com.qfedu.esys.vo;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.qfedu.esys.dto.UserDto;
import com.qfedu.esys.entity.User;

public class UserEuiVo {
	private final static Logger LOG = LogManager.getLogger(UserEuiVo.class);
	
	private List<UserDto> dtos = new ArrayList<>();
	
	public UserEuiVo() {
		
	}
	
	public UserEuiVo(List<User> users) {
		for(User user : users) {
			UserDto userDto = new UserDto();
			userDto.setId(user.getId());
			userDto.setLoginName(user.getLoginName());
			userDto.setPassword(user.getPassword());
			userDto.setCreateTime(user.getCreateTime());
			userDto.setHeadImage(user.getHeadImage());
			userDto.setSex(user.getSex());
			userDto.setTel(user.getTel());
			dtos.add(userDto);
		}
	} 
	
	public List<UserDto> getDtos() {
		return dtos;
	}

	public void setDtos(List<UserDto> dtos) {
		this.dtos = dtos;
	}
}
