package org.apartment.controller;

import org.apartment.domain.CustomUser;
import org.apartment.service.MapService;
import org.apartment.service.MarketBoardService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/tenant/*")
@Log4j
@AllArgsConstructor
public class MapController {
	
	private MapService service;
	
	@RequestMapping("/map" )
	public String mapmap(Model model, Authentication auth) {
		log.info("map½ÇÇà");
		CustomUser user = (CustomUser) auth.getPrincipal();
		int userseq=user.getAptSeq();
		model.addAttribute("place", service.getXY(userseq));
		return "map";
	}
}
