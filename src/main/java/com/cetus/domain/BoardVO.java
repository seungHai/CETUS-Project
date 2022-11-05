package com.cetus.domain;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardVO { // 게시판 정보 테이블
	private long bno, hit, recomendCount, price,filesize;
	private String nickname, title, content,filename,catecode,id,catecoderef;
	private Date reg_date, update_date;
	private int replyCnt,favorite_cnt;
	
	// 파일 업로드 시 한번에 BoardAttachVO를 처리하도록 list 사용
	private List<BoardAttachVO> attachList;
}
