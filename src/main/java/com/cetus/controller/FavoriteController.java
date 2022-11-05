package com.cetus.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cetus.domain.CatePlusCri;
import com.cetus.domain.CateVO;
import com.cetus.domain.Criteria;
import com.cetus.domain.MyFavoriteVO;
import com.cetus.domain.PageDTO;
import com.cetus.domain.UserRegVO;
import com.cetus.domain.myDownloadVO;
import com.cetus.service.BoardService;
import com.cetus.service.CateService;
import com.cetus.service.MyFavoriteService;
import com.cetus.service.UserRegService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/info/*")
public class FavoriteController {
	private MyFavoriteService service;
	private BoardService b_service;
	private CateService c_service;
	private UserRegService u_service;
	
	@GetMapping("/myFavorite")
	public void insert3(Model model, Principal pri, Criteria cri) {
		/* model.addAttribute("f_list",service.getList(pri.getName())); */
		CatePlusCri cpc = new CatePlusCri();
		cpc.setAmount(cri.getAmount());
		cpc.setPageNum(cri.getPageNum());
		if(pri != null) {
			cpc.setId(pri.getName());
			log.info(cpc.getId());
			model.addAttribute("Paginglist", service.getListWithPaging(cpc));
			List<CateVO> clist = c_service.getList();
			model.addAttribute("clist",clist);
			model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cpc.getId())));
		}
	}
	
	@GetMapping("/myFavorite2")
    public void insert2(Model model, Criteria cri) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("list", b_service.getListfavoritePaging(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, b_service.getfavoriteTotal()));
    }
	
	@PostMapping("/remove")
	public String remove(@RequestParam("favorch") String[] favorchs, ModelMap modelMap, Principal pri,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) throws Exception{
		CatePlusCri cpc = new CatePlusCri();
		cpc.setId(pri.getName());
		for ( String favorch : favorchs) {
			cpc.setSearch(favorch);
			int result = service.getremove(cpc);
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/info/myFavorite";
	}
	
	@PostMapping("/removeFiles")
	public String removeFiles(@RequestParam("fileList") String[] fileLists, ModelMap modelMap, Principal pri,@ModelAttribute("cri") Criteria cri,RedirectAttributes rttr) throws Exception{
		CatePlusCri cpc = new CatePlusCri();
		cpc.setId(pri.getName());
		for ( String fileList : fileLists) {
			cpc.setSearch(fileList);
			int result = service.getremoveFiles(cpc);
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/info/downloadFile";
	}
	
	@GetMapping("/favorite")
	   public void favorite(Model model,Principal pri,MyFavoriteVO vo,@RequestParam("bno") long bno,@ModelAttribute("cri") Criteria cri) {
	      log.info("찜목록"+vo);
	      vo.setId(pri.getName());
	      vo.setFavorite_cnt(vo.getFavorite_cnt()+1);
	      int result = service.getinsert(vo);
	      b_service.favorite_cnt(bno);
	      model.addAttribute("board", b_service.get(bno));
	   }
	
	@GetMapping("/downloadFiles")
	public String downloadFiles(Model model,Principal pri,myDownloadVO vo,@RequestParam("bno") long bno,@ModelAttribute("cri") Criteria cri) {
		log.info("내가받은목록"+vo);
		vo.setId(pri.getName());
		
		if(service.selectMyDownFilesBno(vo.getBno()).isEmpty()) {
			log.info("*************************insertMyDownloadFiles");
			int result = service.insertMyDownFiles(vo);
		}
		// 시큐리티 아이디 이용 회원 point 가져오기
		UserRegVO point = u_service.getpointlist(pri.getName()); 
		int cash = point.getCash();
		log.info("유저 캐쉬"+cash);
		cash = cash-vo.getCash();
		point.setCash(cash);
		point.setId(pri.getName());
		u_service.updatepoint(point);
		
		model.addAttribute("board", b_service.get(bno));
		return "redirect:/board/regi";
	}
	
	@GetMapping("/downloadFile")
	public void insert4(Model model, Principal pri, Criteria cri) {
		/* model.addAttribute("f_list",service.getList(pri.getName())); */
		CatePlusCri cpc = new CatePlusCri();
		cpc.setAmount(cri.getAmount());
		cpc.setPageNum(cri.getPageNum());
		cpc.setId(pri.getName());
		log.info(cpc.getId());
		model.addAttribute("Paginglist", service.getListWithPagingFile(cpc));
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotalFile(cpc.getId())));
	}
}
