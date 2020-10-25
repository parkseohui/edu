package org.apartment.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class MarketBoardVO implements Serializable{
private int seq;
private String writer; 
private String productName;
private int price;
private String fname;
private String contents;
private String regdate;
private String isSale;
private int apt_seq;



}
