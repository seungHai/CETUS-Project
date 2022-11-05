package com.cetus.mapper;

import java.util.List;

import com.cetus.domain.BnoPlusId;
import com.cetus.domain.CatePlusCri;
import com.cetus.domain.MyFavoriteVO;
import com.cetus.domain.myDownloadVO;

public interface MyFavoriteMapper {
	public List<MyFavoriteVO> getListWithPaging(CatePlusCri cpc);
	public List<MyFavoriteVO> getList(String id);
	public int getremove(CatePlusCri cpc);
	public int getinsert(MyFavoriteVO vo);
	public MyFavoriteVO getBno(BnoPlusId bpi);
	public int getTotal(String id);
	public long board_remove(long bno);
	public int insertMyDownFiles(myDownloadVO vo);
	public List<MyFavoriteVO> getListWithPagingFile(CatePlusCri cpc);
	public int getTotalFile(String id);
	public long FavoriteCnt(long bno);
	public int getremoveFile(CatePlusCri cpc);
	public List<myDownloadVO> selectMyDownFilesBno(long bno);
}
