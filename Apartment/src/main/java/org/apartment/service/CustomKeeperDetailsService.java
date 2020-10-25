package org.apartment.service;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.KeeperVO;
import org.apartment.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomKeeperDetailsService implements UserDetailsService{
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("userName" + username);
		KeeperVO member = memberMapper.keeperInfo(username);
		log.warn("this is " + member);
		return member == null ? null : new CustomKeeper(member);
	}
	
}
