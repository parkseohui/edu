package org.apartment.domain;

import lombok.Data;

@Data
public class JoinTenantVO {
	String name;
	int aptSeq;
	String id;
	String password;
	String type;
	String dong;
	String ho;
}
