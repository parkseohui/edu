package org.apartment.domain;


import java.util.List;

import lombok.Data;

@Data
public class FeeVO {

	private int feeSeq;
	private int householdSeq;
	private int generalBill;
	private int securityBill;
	private int cleaningBill;
	private int fumigationBill;
	private int elevatorBill;
	private int electricityBill;
	private int waterBill;
	
	private int ho;
	private int roomSize;
	
	
	public int getTotalValue() {
		return generalBill + securityBill + cleaningBill + fumigationBill
					+ elevatorBill + electricityBill + waterBill;
	}
}
