package com.cetus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cetus.domain.BnoPlusId;
import com.cetus.domain.CatePlusCri;
import com.cetus.domain.MyFavoriteVO;
import com.cetus.domain.myDownloadVO;
import com.cetus.mapper.MyFavoriteMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MyFavoriteServicelmpl implements MyFavoriteService{
	@Setter (onMethod_ = @Autowired)
	private MyFavoriteMapper mapper;
	
	@Override
	public int getremove(CatePlusCri cpc) {
		return mapper.getremove(cpc);
	}
	
	@Override
	public int getinsert(MyFavoriteVO vo) {
		return mapper.getinsert(vo);
	}
	
	@Override
	public MyFavoriteVO getBno(BnoPlusId bpi) {
		return mapper.getBno(bpi);
	}

	@Override
	public List<MyFavoriteVO> getList(String id) {
		return mapper.getList(id);
	}
	
	@Override
	public List<MyFavoriteVO> getListWithPaging(CatePlusCri cpc) {
		return mapper.getListWithPaging(cpc);
	}
	@Override
	public int getTotal(String id) {
		return mapper.getTotal(id);
	}

	@Override
	public long board_remove(long bno) {
		return mapper.board_remove(bno);
	}

	@Override
	public int insertMyDownFiles(myDownloadVO vo) {
		return mapper.insertMyDownFiles(vo);
	}

	@Override
	public List<MyFavoriteVO> getListWithPagingFile(CatePlusCri cpc) {
		return mapper.getListWithPagingFile(cpc);
	}

	@Override
	public int getTotalFile(String id) {
		return mapper.getTotalFile(id);
	}
	
	@Override
	   public long FavoriteCnt(long bno){
	      return mapper.FavoriteCnt(bno);
	}

	@Override
	public int getremoveFiles(CatePlusCri cpc) {
		return mapper.getremoveFile(cpc);
	}

	@Override
	public List<myDownloadVO> selectMyDownFilesBno(long bno) {
		return mapper.selectMyDownFilesBno(bno);
	}
}
