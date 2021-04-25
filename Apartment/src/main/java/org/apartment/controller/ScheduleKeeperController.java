package org.apartment.controller;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.CustomUser;
import org.apartment.service.ScheduleService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/keeper/*")
public class ScheduleKeeperController {
	
	private ScheduleService service;
	
	@GetMapping("/scheduleKeeper")
	public String keeper_Schedule(Model model, Authentication auth){
	
		log.info("admit list");

		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		System.out.println(keeper.getName());
		int aptSeq =	keeper.getAptSeq();
		System.out.println(aptSeq);
		
		model.addAttribute("list", service.listSchedule(aptSeq, "0"));
		return "scheduleKeeper";
	}

	}