package com.cetus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cetus.domain.UserRegVO;
import com.cetus.mapper.UserRegMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class UserRegServicelmpl implements UserRegService{
	@Setter(onMethod_ = @Autowired)
	private UserRegMapper mapper;

	@Transactional
	@Override
	public int insert(UserRegVO user) {
		int result = mapper.insert(user);
		mapper.insertAuth(user.getId());
		return result;
	}

	@Override
	public List<UserRegVO> getList() {
		return mapper.getList();
	}
	
	// 아이디 중복 체크
    @Override
    public int idCheck(String id) {
        return mapper.idCheck(id);
    }
    
    // 이메일 중복 체크
    @Override
    public int emailCheck(String email) {
       return mapper.emailCheck(email);
    }
	
    // 내 정보 보기
    @Override
    public UserRegVO getInfo(String id) {
		log.info("getInfo");
		
		return mapper.getInfo(id);
	}
    
    // 내 정보 수정
    @Override
    public int update(UserRegVO user) {
    	return mapper.update(user);
    }

	@Override
	public int insertAuth(String id) {
		return mapper.insertAuth(id);
	}
    // 내 정보 이메일 수정
    @Override
    public int updateEmail(UserRegVO user) {
    	return mapper.updateEmail(user);
    }
    
    // 내 정보 비밀번호 수정
    @Override
    public int updatePass(UserRegVO user) {
    	return mapper.updatePass(user);
    }
    
    @Override
	public UserRegVO getpointlist(String id) {
		return mapper.getpointlist(id);
	}

	@Override
	public int updatepoint(UserRegVO vo) {
		return mapper.updatepoint(vo);
	}

	@Override
	public int chargePoint(UserRegVO vo) {
		return mapper.chargePoint(vo);
	}
}
