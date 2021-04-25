package org.apartment.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/tenant/*")
public class MemberController {
	
	@GetMapping("/user")
	public String userDashBoard(){
		return "userDashBoard";
	}

}
