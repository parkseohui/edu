package org.apartment.domain;

import java.util.Date;

import lombok.Data;

@Data
public class NoticeVO {

	private int noticeSeq;
	private String title;
	private String content;
	private Date regdate;
	private int hits;
	private String category;
	private int aptSeq;
	
	
}