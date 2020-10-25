package org.apartment.domain;

import java.io.Serializable;

import org.springframework.stereotype.Component;

import lombok.Data;

@Data
@Component
public class TenantVO implements Serializable{
	int memberSeq;
	String id;
	String password;
	int aptSeq;
	int householdSeq;
	boolean admit;
	String type;
	String name;
	int dong;
	int ho;
}
