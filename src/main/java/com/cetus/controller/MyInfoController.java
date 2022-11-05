package com.cetus.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cetus.domain.CateVO;
import com.cetus.domain.UserRegVO;
import com.cetus.mapper.CateMapper;
import com.cetus.service.UserRegService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/info/*")
public class MyInfoController {
	
	@Setter(onMethod_ = @Autowired)
	private UserRegService service;
	
	@Setter(onMethod_ = @Autowired)
	private CateMapper c_service;
	
	// 내 정보 보기
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/myInfo")
	public void info(Model model, Principal pri) {
		log.info("============================myInfo");
		UserRegVO user = service.getInfo(pri.getName());
		List<CateVO> clist = c_service.getList();
		model.addAttribute("user", user);
		model.addAttribute("clist",clist);
		model.addAttribute("id",pri.getName());
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/myUpdatePw")
	public void myUpdatePw(Model model,Principal pri) {
		log.info("============================myUpdatePw");
		UserRegVO user = service.getInfo(pri.getName());
		List<CateVO> clist = c_service.getList();
		model.addAttribute("user", user);
		model.addAttribute("clist",clist);
	}
	
	@GetMapping("/lipw")
	public void lipw() {}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/myUpdatePw")
	public String updatePw(Model model, UserRegVO vo, RedirectAttributes rttr) {
		log.info(vo.getPw());
		
		UserRegVO user = service.getInfo(vo.getId());
		rttr.addFlashAttribute("user", user);
		log.info(vo);
		return "redirect:/info/myUpdatePw";
	} 
	
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/myUpdate")
	public void myUpdatePass(Model model, Principal pri) {
		log.info("myUpdate======================");
		UserRegVO user = service.getInfo(pri.getName());
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("user", user);
	}
	
	// 내 정보 비밀번호 수정
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/myUpdatePass")
	public String updatePass(Model model, UserRegVO vo, RedirectAttributes rttr) {
		log.info(vo.getId());
		log.info(vo.getPw());
		List<UserRegVO> list = service.getList();
		List<CateVO> clist = c_service.getList();
		UserRegVO user = service.getInfo(vo.getId());
		rttr.addFlashAttribute("list", list);
		rttr.addFlashAttribute("clist", clist);
		rttr.addFlashAttribute("user", user);
		log.info(vo);
		int result = service.updatePass(vo);
		log.info(result);
		if(result > 0) {
			rttr.addFlashAttribute("result","password");
		}
		return "redirect:/info/myInfo";
	}
	
	// 내 정보 이메일 수정
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/myUpdateEmail")
	public String updateEmail(Model model, UserRegVO vo, RedirectAttributes rttr) {
		log.info(vo.getId());
		log.info(vo.getEmail());
		List<UserRegVO> list = service.getList();
		List<CateVO> clist = c_service.getList();
		UserRegVO user = service.getInfo(vo.getId());
		rttr.addFlashAttribute("list", list);
		rttr.addFlashAttribute("clist", clist);
		rttr.addFlashAttribute("user", user);
		log.info(vo);
		int result = service.updateEmail(vo);
		log.info(result);
		if(result > 0) {
			rttr.addFlashAttribute("result","email");
		}
		return "redirect:/info/myInfo";
	}
	
	
}
