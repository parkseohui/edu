package org.apartment.domain;

import java.util.List;

import lombok.Data;

@Data
public class PollVO {
	
	private int pollSeq;
	private String question;
	private String startDate;
	private String endDate;
	private int hitcount;
	private String contents;
	private int aptSeq;
//	private String[] options;
	
	private List<String> options;

}