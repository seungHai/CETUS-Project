package com.cetus.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyFavoriteVO {
	private String carte,title,filesize,id;
	private int cash,favorite_cnt;
	private long bno;
}
