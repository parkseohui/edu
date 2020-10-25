package org.apartment.domain;

import java.util.List;

import lombok.Data;
@Data
public class FeeRegisterVO {

	private int householdSeq;
	private int aptSeq;
	private int dong;
	
	private List<FeeVO> feeList;
}
