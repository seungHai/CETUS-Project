package com.cetus.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cetus.domain.BnoPlusId;
import com.cetus.domain.BoardAttachVO;
import com.cetus.domain.BoardVO;
import com.cetus.domain.CatePlusCri;
import com.cetus.domain.CateVO;
import com.cetus.domain.Criteria;
import com.cetus.domain.NoticeVO;
import com.cetus.domain.PageDTO;
import com.cetus.domain.UserRegVO;
import com.cetus.mapper.BoardAttachMapper;
import com.cetus.mapper.CateMapper;
import com.cetus.service.BoardService;
import com.cetus.service.MyFavoriteService;
import com.cetus.service.NoticeService;
import com.cetus.service.UserRegService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
@RequestMapping("/board/*")
public class BoardController {
	private BoardService b_service;
	private CateMapper c_service;
	private MyFavoriteService f_service;
	private UserRegService u_service;
	private NoticeService n_service;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	private void deleteFiles(List<BoardAttachVO> attachList) {
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		log.info("delete attach files........");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
				Files.deleteIfExists(file);
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get("c:\\upload\\"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
					Files.delete(thumbNail);
				}
			} catch(Exception e) {
				log.error("delete file error" + e.getMessage());
			}
		});
	}
	
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("list", b_service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, b_service.getTotal()));
		model.addAttribute("clist",clist);
	}
	
	@GetMapping("/listAction")
	public void listAction(String catecode, Model model,Criteria cri) {
		CatePlusCri cpc = new CatePlusCri();
		cpc.setAmount(cri.getAmount());
		cpc.setCatecode(catecode);
		cpc.setPageNum(cri.getPageNum());
		List<BoardVO> listAction = b_service.getCategory(cpc);
		List<CateVO> clist = c_service.getList();
		model.addAttribute("list", listAction);
		model.addAttribute("clist",clist);
		model.addAttribute("catecode",catecode);
		log.info("===================>>" + b_service.getCateTotal(cpc));
		model.addAttribute("pageMaker", new PageDTO(cri, b_service.getCateTotal(cpc)));
	}
	
	@GetMapping("/listSubAction")
	public void listSubAction(String catecoderef, Model model,Criteria cri) {
		CatePlusCri cpc = new CatePlusCri();
		cpc.setAmount(cri.getAmount());
		cpc.setCatecoderef(catecoderef);
		cpc.setPageNum(cri.getPageNum());
		List<BoardVO> listSubAction = b_service.getSubCategory(cpc);
		List<CateVO> clist = c_service.getList();
		model.addAttribute("list", listSubAction);
		model.addAttribute("clist",clist);
		model.addAttribute("catecoderef",catecoderef);
		log.info("===================>>" + b_service.getSubCateTotal(cpc));
		model.addAttribute("pageMaker", new PageDTO(cri, b_service.getSubCateTotal(cpc)));
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void register(@ModelAttribute("cri") Criteria cri, Model model) {
		List<CateVO> clist = c_service.getList();
		b_service.resetFilesize();
		model.addAttribute("clist",clist);
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	   public String register(BoardVO board, RedirectAttributes rttr,
	         @ModelAttribute("cri") Criteria cri) {
	      log.info("============register start==================");
	      log.info("register " + board);
	      // 임시 폴더로 되어있는 참조 링크 수정
	      if(board.getContent().contains("<img alt=\"\" src=")) {
	    	  log.info("**************content****************");
	    	  log.info(board.getContent());
	    	  String reContent = board.getContent().replace("ckEimgTemp", "ckEimg");
	    	  log.info("**************content****************");
	    	  board.setContent(reContent);
	      }
	      int result = b_service.register(board);
	      if(result > 0) {
	         rttr.addFlashAttribute("result", result);
	      } 
	      log.info("============register end==================");
	      rttr.addAttribute("pageNum", cri.getPageNum());
	      rttr.addAttribute("amount", cri.getAmount());
	      // return 경로 변경
	      if(board.getContent().contains("<img alt=\"\" src=")) {
	    	  return "redirect:/copy.do";
	      }else {
	    	  return "redirect:/board/regi";
	      }
	   }
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, Model model,Principal pri) throws Exception {
		log.info("/get or modify");
		model.addAttribute("board", b_service.get(bno));
		// 찜목록 추가
		if(pri != null) {
			BnoPlusId bpi = new BnoPlusId();
			bpi.setBno(bno);
			bpi.setId(pri.getName());
			model.addAttribute("favorit",f_service.getBno(bpi)); 
			
			// 시큐리티 아이디 이용 회원 point 가져오기
			UserRegVO point = u_service.getpointlist(pri.getName());
			int cash = point.getCash();
			model.addAttribute("userpoint",cash);
		}
		b_service.updateHitCount(bno);
	}
	
	@PreAuthorize("principal.username == #board.id")
	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr, Criteria cri) {
		log.info("modify........ " + board);
		if(b_service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/mody";
	}
	
	@RequestMapping(value="/remove", method = {RequestMethod.GET, RequestMethod.POST})
	public String remove(BoardVO board, @RequestParam("bno") long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove........ " + bno);
		String content = b_service.get(bno).getContent();
		List<BoardAttachVO> attachList = b_service.getAttachList(bno);
		if(b_service.remove(bno)) {
			deleteFiles(attachList);
			rttr.addFlashAttribute("result", "success");
		}
		f_service.board_remove(bno);
		// 조건문 추가
				if(content.contains("<img alt=\"\" src=")) {
					rttr.addFlashAttribute("content",content);
					return "redirect:/removeReal.do";
				}else {
					return "redirect:/board/remo";
				}
			}
	
	@GetMapping("MainPage")
	public void MainPage() {}
	
	@GetMapping("search")
	public void search(Criteria cri, Model model, @Param("category2") String category2, @Param("search") String search) {
		log.info("******" + category2);
		CatePlusCri cpc = new CatePlusCri();
		cpc.setAmount(cri.getAmount());
		cpc.setPageNum(cri.getPageNum());
		cpc.setSearch(search);
		cpc.setCatecoderef(category2);
		List<CateVO> clist = c_service.getList();
		List<BoardVO> list = b_service.getSearch(cpc);
		model.addAttribute("clist",clist);
		/* log.info(b_service.getSearchTotal(cpc)); */
		model.addAttribute("list",list);
		model.addAttribute("pageMaker", new PageDTO(cri, b_service.getSearchTotal(cpc)));
		model.addAttribute("search", search);
		model.addAttribute("category2", category2);
	}
	
	@GetMapping("regi")
	public void regi() {}
	
	@GetMapping("mody")
	public void mody() {}
	
	@GetMapping("remo")
	public void remo() {}
	
	@GetMapping("li")
	public void li() {
		log.info("*********************li********************");
	}
	
	@GetMapping("joonzis")
	public void joonzis() {}
	
	@GetMapping("/self_auth")
	public void self(Model model) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
	}
	
	@GetMapping("/charge")
	public void charge(Model model) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("clist",clist);
	}
	
	@GetMapping("/recoCount")
	public void reco(@RequestParam("bno") long bno, Model model) throws Exception {
		log.info("*************sdf**********");
		b_service.updateRecoCount(bno);
		b_service.updateHitDeleteCount(bno);
		model.addAttribute("board", b_service.get(bno));
	}
	
	@GetMapping("/best")
	public void best(Criteria cri, Model model) {
		List<CateVO> clist = c_service.getList();
		model.addAttribute("list", b_service.getBestList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, b_service.getBestTotal()));
		model.addAttribute("clist",clist);
	}
	@ResponseBody
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<BoardAttachVO>>getAttachList(long bno){
		log.info("==================getattachlist start============");
		
		log.info("getAttachList" + bno);
		log.info("==================getattachlist end============");
		return new ResponseEntity<List<BoardAttachVO>>(b_service.getAttachList(bno), HttpStatus.OK);
	}
}
