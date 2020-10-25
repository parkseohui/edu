package org.apartment.domain;

import lombok.Data;

@Data
public class UnitPriceVO {
	
    private int unitPriceSeq;
    private String levyDate;
    private int generalPrice;
    private int securityPrice;
    private int cleaningPrice;
    private int fumigationPrice;
    private int elevatorPrice;
    private int electricityPrice;
    private int waterPrice;

}
