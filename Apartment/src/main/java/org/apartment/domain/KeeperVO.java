package org.apartment.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class KeeperVO implements Serializable{
	int keeperSeq;
	String id;
	String password;
	int aptSeq;
	boolean admit;
	String type;
	String name;
}
