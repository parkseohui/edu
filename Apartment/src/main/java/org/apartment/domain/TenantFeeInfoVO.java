package org.apartment.domain;

import lombok.Data;

@Data
public class TenantFeeInfoVO {

	 private int aptSeq;
	 private int memberSeq;
	 private int householdSeq;
	 private int feeSeq;
	 private int levySeq;
	 
	 private int dong;
	 private int ho;
	 private String name;
	 private String levyDate;
	 private String deadlineDate;
	 
	 private int generalBill;
	 private int securityBill;
	 private int cleaningBill;
	 private int fumigationBill;
	 private int elevatorBill;
	 private int electricityBill;
	 private int waterBill;
	 
	 private int rownum;
	
	 
	 
	public int getTotalFee() {
		return generalBill + securityBill + cleaningBill + fumigationBill + elevatorBill + electricityBill + waterBill;
	}
	
}