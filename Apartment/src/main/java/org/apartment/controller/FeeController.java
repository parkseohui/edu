package org.apartment.controller;
import java.text.DateFormatSymbols;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apartment.domain.CustomKeeper;
import org.apartment.service.FeeService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/keeper/*")
public class FeeController {
	
	private FeeService service;

	
	@GetMapping("/levyRegister")
	public String levyRegister(Authentication auth){
		
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		keeper.getAptSeq();
		
		return "levyRegister";
	}
	
	@GetMapping("/feeRegister/{levyDateNum}")
	public String feeRegister(@PathVariable("levyDateNum") String levyDateNum, Model model){
		
		
		SimpleDateFormat simple = new SimpleDateFormat("yyyyMM");
		Date d;
		try {
			d = simple.parse(levyDateNum);
			SimpleDateFormat simple1 = new SimpleDateFormat("yyyy-MM-dd");
			String b = simple1.format(d);
			
			model.addAttribute("levyD", b);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return "feeRegister";
	}
	
	

}