package com.cetus.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cetus.domain.BoardAttachVO;
import com.cetus.domain.BoardVO;
import com.cetus.domain.CatePlusCri;
import com.cetus.domain.Criteria;
import com.cetus.domain.FileVO;

public interface BoardMapper {
	/* public List<BoardVO> getList(); */
	public List<BoardVO> getListWithPaging(Criteria cri);
	public List<BoardVO> getCateory(CatePlusCri cpc);
	public List<BoardVO> getSubCategory(CatePlusCri cpc);
	public int insert(BoardVO board);
	public int insertSelectKey(BoardVO board);
	public BoardVO read(long bno);
	public int delete(long bno);
	public int update(BoardVO board);
	public int getTotal();
	public int getCateTotal(CatePlusCri cpc);
	public int getSubCateTotal(CatePlusCri cpc);
	public List<BoardVO> getSearch(CatePlusCri cpc);
	public int getSearchTotal(CatePlusCri cpc);
	public long updateHitCount(long bno);
	public long updateHitDeleteCount(long bno);
	public long updateRecoCount(long bno);
	public List<BoardVO> getBestList(Criteria cri);
	public int getBestTotal();
	public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
	public long getBno();
	public List<BoardAttachVO> getAttachList(long bno);
	public List<BoardVO> getFavoriteList(Criteria cri);
	public long favorite_cnt(long bno);
	public int updateFilesize(long filesize);
	public int resetFilesize();
	public FileVO getFileVO();
	public int getFavoriteTotal(); // 나중에 삭제 안씀
	public List<BoardVO> getListfavoritePaging(Criteria cri);
	public int getfavoriteTotal();
}
