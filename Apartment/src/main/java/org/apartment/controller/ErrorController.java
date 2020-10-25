package org.apartment.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/error/*")
@Controller
public class ErrorController {
	@GetMapping("/401")
	public String hasNoAuth(Authentication auth, Model model) {
		return "401";
	}

}
