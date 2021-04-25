package org.apartment.controller;

import java.util.ArrayList;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.PollOptionVO;
import org.apartment.domain.PollVO;
import org.apartment.service.PollService;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/keeper/*")
@Log4j
@AllArgsConstructor
public class PollKeeperController {

	private PollService service;

	@GetMapping("/pollList")
	public String keeper_list(Model model, Authentication auth) {
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		int aptseq = keeper.getAptSeq();
		log.info("list");
		model.addAttribute("list", service.PollList(aptseq));

		return "pollList";
	}

	@GetMapping("/pollDetail")
	public String keeper_pollDetail(@RequestParam("seq") int seq, Model model) {
		log.info("detail..");

		model.addAttribute("detail", service.PollDetail(seq));

		return "pollDetail";
	}

	@GetMapping(value = "/pollSignThumnail", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> keeper_signThumnail(String fileName) {
		Resource resource = new FileSystemResource("c:\\upload\\s_sign\\" + fileName);

		String resourceName = resource.getFilename();

		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition",
					"attachment; filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@GetMapping(value = "/pollSignBigPicture", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> keeper_signBigPicture(String fileName) {
		Resource resource = new FileSystemResource("c:\\upload\\sign\\" + fileName);

		String resourceName = resource.getFilename();

		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition",
					"attachment; filename=" + new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/pollInsert")
	public String keeper_insert(PollVO poll, RedirectAttributes rttr, Authentication auth) {
		CustomKeeper keeper = (CustomKeeper) auth.getPrincipal();
		int aptseq = keeper.getAptSeq();
		log.info("insert:" + poll);
		poll.setAptSeq(aptseq);

		service.PollInsert(poll);
		ArrayList<PollOptionVO> options = new ArrayList<>();
		for (int i = 0; i < poll.getOptions().size(); i++) {
			PollOptionVO option = new PollOptionVO();
			option.setOptionText(poll.getOptions().get(i));
			option.setPollSeq(poll.getPollSeq());
			options.add(option);
		}

		service.PollOptionInsert(options);

		rttr.addFlashAttribute("result", poll.getPollSeq());

		return "redirect:/keeper/pollList";

	}

}