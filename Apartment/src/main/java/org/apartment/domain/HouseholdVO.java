package org.apartment.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class HouseholdVO implements Serializable{
	private int householdSeq;
	private int dong;
	private int ho;
	private int aptSeq;
	private float roomSize;
	}
