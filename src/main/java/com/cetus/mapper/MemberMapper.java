package com.cetus.mapper;

import com.cetus.domain.UserRegVO;

public interface MemberMapper {
	public UserRegVO read(String userid);
}
