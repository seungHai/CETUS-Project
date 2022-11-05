package com.cetus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cetus.domain.BoardAttachVO;
import com.cetus.domain.BoardVO;
import com.cetus.domain.CatePlusCri;
import com.cetus.domain.Criteria;
import com.cetus.domain.FileVO;
import com.cetus.mapper.BoardAttachMapper;
import com.cetus.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
//	@Override
//	public List<BoardVO> getList() {
//		log.info("getList.....");
//		return mapper.getList();
//	}
	
	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("getList with criteria................" + cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<BoardVO> getCategory(CatePlusCri cpc) {
		log.info("getCategory...");
		return mapper.getCateory(cpc);
	}

	@Override
	public List<BoardVO> getSubCategory(CatePlusCri cpc) {
		log.info("getSubCategory...");
		return mapper.getSubCategory(cpc);
	}
	
	@Transactional
	@Override
	public int register(BoardVO board) {
		
		log.info("register.........." + board);
		int result = mapper.insertSelectKey(board);
		long bno = mapper.getBno();
		mapper.resetFilesize();
		if(board.getAttachList() != null && board.getAttachList().size()>0){
			for(BoardAttachVO vo : board.getAttachList()) {
				vo.setBno(bno);
				log.info("***********************insert attachMapper***********************");
				attachMapper.insert(vo);
			}
		}
		
		return result;
	}

	@Override
	public BoardVO get(long bno) {
		
		log.info("get,,,,,,,," + bno);
	
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify,,,,,,,," + board);
		return mapper.update(board) == 1;
	}

	@Override
	public boolean remove(long bno) {
		log.info("remove,,,,,,,," + bno);
		attachMapper.deleteAll(bno);
		return mapper.delete(bno) == 1;
	}
	@Override
	public int getTotal() {
		return mapper.getTotal();
	}

	@Override
	public int getCateTotal(CatePlusCri cpc) {
		return mapper.getCateTotal(cpc);
	}

	@Override
	public int getSubCateTotal(CatePlusCri cpc) {
		return mapper.getSubCateTotal(cpc);
	}

	@Override
	public List<BoardVO> getSearch(CatePlusCri cpc) {
		return mapper.getSearch(cpc);
	}

	@Override
	public int getSearchTotal(CatePlusCri cpc) {
		return mapper.getSearchTotal(cpc);
	}
	@Override
	public long updateHitCount(long bno) {
		
		log.info("COUNT");
		
		return mapper.updateHitCount(bno);
		
	}
	@Override
	public long updateRecoCount(long bno){
		log.info("updateRecoCount.....");
		return mapper.updateRecoCount(bno);
	}
	@Override
	public long updateHitDeleteCount(long bno){
		log.info("updateRecoCount.....");
		return mapper.updateHitDeleteCount(bno);
	}

	@Override
	public List<BoardVO> getBestList(Criteria cri) {
		return mapper.getBestList(cri);
	}

	@Override
	public int getBestTotal() {
		return mapper.getBestTotal();
	}
	@Override
	public List<BoardAttachVO> getAttachList(long bno){
		log.info("get Attach list by bno" + bno);
		return attachMapper.findByBno(bno);
	}
	
	@Override
	   public long favorite_cnt(long bno) {
	      return mapper.favorite_cnt(bno);
	}
	   
   @Override
   public List<BoardVO> getFavoriteList(Criteria cri) {
      return mapper.getFavoriteList(cri);
   }

	@Override
	public int updateFilesize(long filesize) {
		log.info("********************updateFilesize*****************" + filesize);
		return mapper.updateFilesize(filesize);
	}

	@Override
	public int resetFilesize() {
		return mapper.resetFilesize();
	}

	@Override
	public FileVO getFileVO() {
		return mapper.getFileVO();
	}
	
	@Override
	public int getFavoriteTotal() {
		return mapper.getFavoriteTotal();
	}
	
	@Override
	public List<BoardVO> getListfavoritePaging(Criteria cri) {
		log.info("getList with criteria................" + cri);
		return mapper.getListfavoritePaging(cri);
	}
	
	@Override
	public int getfavoriteTotal() {
		return mapper.getfavoriteTotal();
	}
}
