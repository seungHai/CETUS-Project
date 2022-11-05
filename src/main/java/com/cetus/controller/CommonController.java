package com.cetus.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
// 고정값은 requestmapping을 클래스에 걸고 나머진 안에 메소드에 걸어줌
// 하나의 고정값은 메소드에 걸어줌
public class CommonController {
	@GetMapping("/accessError") // 메소드가 void니 실제 accessError.jsp로 이동
	// security 꺼 Authentication 사용
	public void accessDenied(Model model, Authentication auth) {
		log.info("accessDenied : " + auth);
		model.addAttribute("msg", "Access Denied");
	}
	
	@GetMapping("/customLogin")
	public void loginInput(String error , String logout, Model model) { //에러? 로그아웃? 판단함
		log.info("error: " + error);
		log.info("logout : " + logout);
		
		if(error != null) {
			model.addAttribute("error", "Login Error");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
	}
	
	@GetMapping("/customLogout")
	public void logout() {
		log.info("custom logout");
	}
	
	@PostMapping("/customLogout")
	public void logouts() {
		log.info("custom logouts");
	}
}
