package com.cetus.controller;

import org.springframework.security.access.annotation.Secured;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/sample")
public class SampleController {
	@GetMapping("/all")
	public void doAll() {
		log.info("doAll");
	}
	
	@GetMapping("/member")
	public void doMamber() {
		log.info("doMamber");
	}
	
	@GetMapping("/admin")
	public void doAdmin() {
		log.info("doAdmin");
	}
	
	// 어노테이션 두가지
	//@PreAuthorize, @Secured 둘다 권한을 체크하는 어노테이션 @Secured 가 좀더 오래됨
	// @PreAuthorize 가 쓸수있는 기능이 더 많음 (시큐리티 표현식 참고할것)
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/annoMember")
	public void doMember2(){
		log.info("로그인 어노테이션 멤버");
	}
	
	@Secured({"ROLE_ADMIN"})
	@GetMapping("/annoAdmin")
	public void doAdmin2() {
		log.info("어드민 어노테이션");
	}
}
