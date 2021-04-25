package org.apartment.controller;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.CustomUser;
import org.apartment.domain.NoticeCriteria;
import org.apartment.domain.NoticePageDTO;
import org.apartment.domain.NoticeVO;
import org.apartment.service.NoticeService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/keeper/*")
@AllArgsConstructor
public class NoticeKeeperController {

	private NoticeService service;
	
	//Keeper의 공지 목록을 불러오는 Controller
	@GetMapping("/listNoticeKeeper")
	public String list(NoticeCriteria cri,Authentication auth, Model model){
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		int keeperAptSeq = keeper.getAptSeq();
		log.info("list : " + cri);
		log.info(keeperAptSeq);

	model.addAttribute("list", service.getList(cri, keeperAptSeq));	
	//model.addAttribute("pageMaker", new NoticePageDTO(cri, 60));
	int total = service.getTotal(cri,keeperAptSeq);
	log.info("total: " + total);
	log.info(model);

	model.addAttribute("pageMaker", new NoticePageDTO(cri, total));
	return "/listNoticeKeeper";
	}
	
	
	
	@GetMapping("/registerNoticeKeeper")
	public String registerNotice(){
		return "/registerNoticeKeeper";
	}
	
	@PostMapping("/registerNoticeKeeper")
	public String register(NoticeVO notice, Authentication auth, RedirectAttributes rttr){
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		int keeperAptSeq = keeper.getAptSeq();
		
		notice.setAptSeq(keeperAptSeq);
		log.info("register : " + notice);
		service.register(notice);
	
			rttr.addFlashAttribute("result", notice.getNoticeSeq());
		return "redirect:/keeper/listNoticeKeeper";
	}

	
	@GetMapping("/getNoticeKeeper")
	public String get(@RequestParam("noticeSeq")int noticeSeq, @ModelAttribute("cri") NoticeCriteria cri, Model model){
		log.info("/get");
		log.info(cri);
		
		model.addAttribute("notice", service.get(noticeSeq));	
		service.plusCnt(noticeSeq);
		
		return "/getNoticeKeeper";
	}
	
	@GetMapping("/modifyNoticeKeeper")
	public String modify(@RequestParam("noticeSeq")int noticeSeq, @ModelAttribute("cri") NoticeCriteria cri, Model model){
		log.info("/get");
		
		model.addAttribute("notice", service.get(noticeSeq));	
		return "/modifyNoticeKeeper";
	}
	
	@PostMapping("/modifyNoticeKeeper")
	public String modify(NoticeVO notice, @ModelAttribute("cri") NoticeCriteria cri, RedirectAttributes rttr){
		log.info("modify: " + notice);
	
		if(service.modify(notice)){
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/keeper/listNoticeKeeper";
	}
	
	@PostMapping("/removeNoticeKeeper")
	public String remove(@RequestParam("noticeSeq")int noticeSeq, @ModelAttribute("cri") NoticeCriteria cri, RedirectAttributes rttr){
		log.info("remove....." + noticeSeq);
		
		if(service.remove(noticeSeq)){
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/keeper/listNoticeKeeper";
	}


}