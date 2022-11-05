package com.cetus.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class myDownloadVO {
	private long bno;
	private int cash;
	private String carte, title, filesize,id;
}
