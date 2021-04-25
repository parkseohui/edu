package org.apartment.domain;

import lombok.Data;

@Data
public class PollDetailVO {
	
	private String dong;
	private String ho;
	private String name;
	private int optionSeq;
	private String optionText;
	private String fileName;
}