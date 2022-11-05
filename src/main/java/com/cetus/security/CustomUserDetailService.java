package com.cetus.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.cetus.domain.MemberVO;
import com.cetus.domain.UserRegVO;
import com.cetus.mapper.MemberMapper;
import com.cetus.security.domain.CustomUser;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// userService라는 인터페이스 구현할 거임
@Log4j
public class CustomUserDetailService implements UserDetailsService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	// UserDetails를 리턴하는데 new CustomUser(vo)가 리턴이 가능한이유
	// User를 상속받고있기때문에 가능하다 (부모의 부모를 리턴해줌)
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.info("load user by user name : " + username);
		
		UserRegVO user = mapper.read(username);
		
		log.info("UserRegVO : " +  user);
		
		String oldPw = user.getPw();
		String newPw = "{noop}" + oldPw;
		user.setPw(newPw);
		
		// vo 던지면 vo받아온다 (시큐리티에 권한 관련내용 올리고 vo 리턴)
		
		return user == null? null : new CustomUser(user);
	}
}
