package com.cetus.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import lombok.extern.log4j.Log4j;

// 화면을 이동시켜주는 핸들러로 사용
@Log4j
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		log.error("Access Denied Handler");
		// info() warn() error() 동작에 맞게 눈에 띄게끔 하면 됨
		log.error("redirect   /accessError");
		// Redirect로 화면 이동만 시켜줄거임
		response.sendRedirect("/accessError");
	}
}
