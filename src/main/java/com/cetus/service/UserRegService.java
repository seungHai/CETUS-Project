package com.cetus.service;

import java.util.List;

import com.cetus.domain.UserRegVO;

public interface UserRegService {
	public int insert(UserRegVO user);
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
