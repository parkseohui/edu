package org.apartment.service;

import org.apartment.domain.CustomUser;
import org.apartment.domain.TenantVO;
import org.apartment.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService{
	
	@Setter(onMethod_ = {@Autowired})
	private MemberMapper memberMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.warn("userName" + username);
		TenantVO member = memberMapper.memberInfo(username);
		log.warn("this is " + member);
		return member == null ? null : new CustomUser(member);
	}
	
}
