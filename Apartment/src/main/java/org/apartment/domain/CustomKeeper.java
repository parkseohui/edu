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
public class CustomKeeper extends User {

	private static final long serialVersionUID = 1L;

	int keeperSeq;
	String id;
	String password;
	int aptSeq;
	String type;
	String name;
	
	private static Collection<? extends GrantedAuthority> authorities(KeeperVO user) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		System.out.println("keeper auth" + user.getType());
		authorities.add(new SimpleGrantedAuthority(user.getType()));
		return authorities;
	}

	public CustomKeeper(KeeperVO keeper) {
		super(keeper.getId(), keeper.getPassword(), authorities(keeper));
		this.keeperSeq = keeper.getKeeperSeq();
		this.id = keeper.getId();
		this.password = keeper.getPassword();
		this.aptSeq = keeper.getAptSeq();
		this.type = keeper.getType();
		this.name = keeper.getName();
	}

}
