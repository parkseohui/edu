package org.apartment.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;

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
	
	private static Collection<? extends GrantedAuthority> authorities(TenantVO user) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		System.out.println("user auth" + user.getType());
		authorities.add(new SimpleGrantedAuthority(user.getType()));
		return authorities;
	}

//	public CustomUser(String name, String password, Collection<? extends GrantedAuthority> type) {
//		super(name, password, type);
//	}

	public CustomUser(TenantVO member) {
		super(member.getId(), member.getPassword(), authorities(member));
		this.memberSeq = member.getMemberSeq();
		this.id = member.getId();
		this.password = member.getPassword();
		this.aptSeq = member.getAptSeq();
		this.householdSeq = member.getHouseholdSeq();
		this.admit = member.isAdmit();
		this.type = member.getType();
		this.name = member.getName();
		this.dong = member.getDong();
		this.ho = member.getHo();
	}

}
