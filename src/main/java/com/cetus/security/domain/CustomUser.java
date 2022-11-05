package com.cetus.security.domain;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.cetus.domain.MemberVO;
import com.cetus.domain.UserRegVO;

import lombok.Getter;
 // 이 영역에선 @data 못씀, member를 외부에서 가져가게 하려면 getter 만들어줘야함

@Getter
public class CustomUser extends User{
private static final long serialVersionUID = 1L;
	
	private UserRegVO user;

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	// 생성자 호출하면 vo 받아서 던져줌 (권한에 대한 정보들을 시큐리티에 올린다)
	public CustomUser(UserRegVO user) {
		super(user.getId(), user.getPw(), user.getAuthList().stream().
				map(auth -> new SimpleGrantedAuthority(auth.getAuth())).
				collect(Collectors.toList()));
		
		this.user = user;
	}
}
