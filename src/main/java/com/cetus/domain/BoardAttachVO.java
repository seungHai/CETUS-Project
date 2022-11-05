package com.cetus.domain;

import lombok.AllArgsConstructor;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardAttachVO {
	private String uuid, uploadPath, fileName;
	private long bno;
	private boolean filesize;
}
