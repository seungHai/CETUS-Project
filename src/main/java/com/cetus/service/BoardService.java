package com.cetus.service;

import java.util.List;

import com.cetus.domain.BoardAttachVO;
import com.cetus.domain.BoardVO;
import com.cetus.domain.CatePlusCri;
import com.cetus.domain.Criteria;
import com.cetus.domain.FileVO;

public interface BoardService {
	/* public List<BoardVO> getList(); */
	public List<BoardVO> getList(Criteria cri);
	public List<BoardVO> getCategory(CatePlusCri cpc);
	public List<BoardVO> getSubCategory(CatePlusCri cpc);
	public int register(BoardVO board);
	public BoardVO get(long bno);
	public boolean modify(BoardVO board);
	public boolean remove(long bno);
	public int getTotal();
	public int getCateTotal(CatePlusCri cpc);
	public int getSubCateTotal(CatePlusCri cpc);
	public List<BoardVO> getSearch(CatePlusCri cpc);
	public int getSearchTotal(CatePlusCri cpc);
	public long updateHitCount(long bno) throws Exception;
	public long updateHitDeleteCount(long bno);
	public long updateRecoCount(long bno) throws Exception;
	public List<BoardVO> getBestList(Criteria cri);
	public int getBestTotal();
	public List<BoardAttachVO> getAttachList(long bno);
	public List<BoardVO> getFavoriteList(Criteria cri);
	public long favorite_cnt(long bno);
	public int updateFilesize(long filesize);
	public int resetFilesize();
	public FileVO getFileVO();
	public int getFavoriteTotal(); // 나중에 삭제
	public List<BoardVO> getListfavoritePaging(Criteria cri);
	public int getfavoriteTotal();
}
