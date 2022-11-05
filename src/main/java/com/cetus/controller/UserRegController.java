package com.cetus.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cetus.domain.CateVO;
import com.cetus.domain.UserRegVO;
import com.cetus.mapper.CateMapper;
import com.cetus.service.BoardService;
import com.cetus.service.UserRegService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/info/*")
public class UserRegController {
	private UserRegService service;
	private BoardService b_service;
	private CateMapper c_service;
	
	@GetMapping("/myinsert")
	public void insert1(Model model) {
		List<UserRegVO> flist = service.getList();
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("flist",flist);
	}
	
	@PostMapping("/membersec")
	public String insert2(Model model, UserRegVO user,RedirectAttributes rttr) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		log.info(user);
		int result = service.insert(user);
		
		if(result > 0) {
			rttr.addFlashAttribute("result",result);
		}
		return "/info/membersec";
	}
	
	// 아이디 체크
    @PostMapping( value = "/idCheck", produces = "application/text; charset=utf-8")
    @ResponseBody
    public String idCheck(String id){
        log.info("idcheck controller");
        log.info("전달받은 id:"+id);
        int cnt = service.idCheck(id);
        log.info("확인 결과:"+cnt);
        
       return Integer.toString(cnt);
    }
    
    // 이메일 체크
    @PostMapping( value = "/emailCheck", produces = "application/text; charset=utf-8")
    @ResponseBody
    public String emailCheck(String email){
        log.info("emailcheck controller");
        log.info("전달받은 email:"+email);
        int tt = service.emailCheck(email);
        log.info("확인 결과:"+tt);
        
       return Integer.toString(tt);
    }
    
    
}
