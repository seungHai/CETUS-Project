package com.cetus.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		log.warn("Login Success!!");
		// 로그인을 하면 그 계정에 딸려있는 권한들을 쭉 가져올 거임
		
		List<String> roleName = new ArrayList<String>(); // 다수의 권한이 넘어오므로 String list로 받음
		
		// authentication.getAuthorities(); // 권한들을 가져온다.
		// 클래스 리턴 타입 같은거 모를때 1차적으로 도큐먼트 보면 됨 java11 api
		// https://docs.spring.io/spring-framework/docs/current/javadoc-api/ : spring
		
		for(GrantedAuthority auth : authentication.getAuthorities()) {
			roleName.add(auth.getAuthority());
		}
		
		log.warn("ROLE NAME : " + roleName);
		
		if(roleName.contains("ROLE_ADMIN")) {
			response.sendRedirect("/sample/admin");
			return;
		}
		
		if(roleName.contains("ROLE_MEMBER")) {
			response.sendRedirect("/sample/member");
			return;
		}
		
		response.sendRedirect("/");
	}
}
