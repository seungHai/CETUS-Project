package com.cetus.mapper;

import java.util.List;

import com.cetus.domain.UserRegVO;

public interface UserRegMapper {
	public int insert(UserRegVO userReg);
	public List<UserRegVO> getList();
	public int idCheck(String id);
	public int emailCheck(String email);
	public UserRegVO getInfo(String id);
	public int update(UserRegVO userReg);
	public int insertAuth(String id);
	public int updatePass(UserRegVO userReg);  // 비밀번호 변경
	public int updateEmail(UserRegVO userReg);  // 이메일 변경
	public UserRegVO getpointlist(String id);
	public int updatepoint(UserRegVO vo);
	public int chargePoint(UserRegVO vo);
}
