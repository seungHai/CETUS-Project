package com.cetus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cetus.domain.BoardVO;
import com.cetus.domain.CateVO;
import com.cetus.domain.Criteria;
import com.cetus.domain.NoticeVO;
import com.cetus.domain.PageDTO;
import com.cetus.mapper.CateMapper;
import com.cetus.service.BoardService;
import com.cetus.service.NoticeService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/customerCenter/*")
public class CustomerCenterController {
	@Setter(onMethod_ = @Autowired)
	private NoticeService service;
	
	@Setter(onMethod_ = @Autowired)
	private BoardService b_service;
	
	@Setter(onMethod_ = @Autowired)
	private CateMapper c_service;
	
	@GetMapping("/notice")
	public void nlist(Model model, Criteria cri) {
		List<NoticeVO> list = service.getList(cri);
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("nlist",list);
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal()));
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/nRegister")
	public void nRegister(Model model, Criteria cri) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("cri", cri);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/nRegister")
	public String nRegister(NoticeVO nvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("nRegister...." + nvo);
		int result = service.register(nvo);
		if(result > 0) {
			rttr.addFlashAttribute("result",result);
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/customerCenter/notice";
	}
	
	@GetMapping({"/nGet","/nModify"})
	public void nGet(Model model, int nno, Criteria cri) {
		log.info("nGet or nModify....." + nno);
		NoticeVO nvo = service.read(nno);
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("nvo",nvo);
		model.addAttribute("cri", cri);
	}
	
	@PostMapping("/nModify")
	public String nModify(NoticeVO nvo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("nModify....");
		int result = service.modify(nvo);
		if(result > 0) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/customerCenter/notice";
	}
	
	@GetMapping("/nRemove")
	public String nRemove(int nno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("nRemove...");
		int result = service.remove(nno);
		if(result >0) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/customerCenter/notice";
	}
}
