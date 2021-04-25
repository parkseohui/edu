package org.apartment.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class NoticeCriteria {

	private int pageNum;
	private int amount;
	
	public NoticeCriteria(){
		this(1,10);
	}
	public NoticeCriteria(int pageNum, int amount){
		this.pageNum = pageNum;
		this.amount = amount;
		
	}

}