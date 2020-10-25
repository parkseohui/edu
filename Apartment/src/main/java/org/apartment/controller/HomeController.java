package org.apartment.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.JoinKeeperVO;
import org.apartment.domain.JoinTenantVO;
import org.apartment.mapper.MemberMapper;
import org.apartment.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	BCryptPasswordEncoder encoder;
	@Autowired
	MemberService memberService;
	@Autowired
	MemberMapper memberMapper;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	@GetMapping("/keeper/dashboard")
	public String keeperHome(Authentication auth, Model model) {
		CustomKeeper keeper = (CustomKeeper)auth.getPrincipal();
		System.out.println(keeper.getAptSeq());
		System.out.println(memberMapper.showNotAdmitUser(keeper.getAptSeq()));
		model.addAttribute("waiting", memberMapper.showNotAdmitUser(keeper.getAptSeq()));
		return "managerDashBoard";
	}
	@GetMapping("/tenant/a")
	public String test() {
		return "test";
	}
	@GetMapping("/keeper/a")
	public String test1() {
		return "managerDashBoard";
	}
	// ?„¸?…? ë¡œê·¸?¸ ?˜?´ì§? 
	@GetMapping("/tenant/signin")
	public String signinGet() {
		return "tenantSignin";
	}
	
	
	@GetMapping("/keeper/signin")
	public String signinKeeper() {
		return "keeperSignin";
	}
	
	// tenant ?šŒ?›ê°??… ?˜?´ì§? & ?šŒ?›ê°??…?‹œ form ?š”ì²? ë°›ëŠ” ?˜?´ì§? 
	@GetMapping("/tenant/signup")
	public String signUpGet() {
		return "tenantSignup";
	}
	
	@PostMapping(value = "/tenant/signup",  produces="text/plain;charset=UTF-8")
	public String signUpPost(@ModelAttribute JoinTenantVO member, RedirectAttributes rttr) {
		logger.info("sign up " + member);
		member.setPassword(encoder.encode(member.getPassword()));
		int result = memberService.joinTenantService(member);
		System.out.println(member);
		if (result == -1) {
			rttr.addFlashAttribute("status", "ê°’ì´ ì¤‘ë³µ?˜?—ˆ?Šµ?‹ˆ?‹¤.");
			return "redirect:/tenant/signup";
		} else if (result == 0) {
			rttr.addFlashAttribute("status", "ë¬¸ì œê°? ?¼?–´?‚¬?Šµ?‹ˆ?‹¤. ? ?‹œ?›„ ?‹œ?„?•´ì£¼ì„¸?š”.");
			return "redirect:/tenant/signup";
		} else {
			rttr.addFlashAttribute("status", "?„±ê³µì ?œ¼ë¡? ?šŒ?›ê°??… ?˜?—ˆ?Šµ?‹ˆ?‹¤ ë¡œê·¸?¸ ?•´ì£¼ì„¸?š”.");
			return "redirect:/tenant/signin";
		}
	}
	// keeper ?šŒ?›ê°??… ?˜?´ì§? & ?šŒ?›ê°??…?‹œ form ?š”ì²? ë°›ëŠ” ë¶?ë¶? 
	@GetMapping(value ="/keeper/signup")
	public String keeperSignupPage() {
		return "keeperSignup";
	}
	
	@PostMapping(value = "/keeper/signup")
	public String keeperSignUp(@ModelAttribute JoinKeeperVO keeper, RedirectAttributes rttr) {
		logger.info("keeperSignup");
		keeper.setPassword(encoder.encode(keeper.getPassword()));
		int result = memberService.joinKeeperService(keeper);
		System.out.println(keeper);
		if (result == -1) {
			rttr.addFlashAttribute("status", "ê°’ì´ ì¤‘ë³µ?˜?—ˆ?Šµ?‹ˆ?‹¤.");
			return "redirect:signup";
		} else if (result == 0) {
			rttr.addFlashAttribute("status", "ë¬¸ì œê°? ?¼?–´?‚¬?Šµ?‹ˆ?‹¤. ? ?‹œ?›„ ?‹œ?„?•´ì£¼ì„¸?š”.");
			return "redirect:signup";
		} else {
			rttr.addFlashAttribute("status", "?„±ê³µì ?œ¼ë¡? ?šŒ?›ê°??… ?˜?—ˆ?Šµ?‹ˆ?‹¤ ë¡œê·¸?¸ ?•´ì£¼ì„¸?š”.");
			return "redirect:/signin";
		}
	}
	
	// ?•„?ŒŒ?Š¸ ë§Œë“œ?Š” ?˜?´ì§? ë§¤í•‘ 
	@GetMapping("/createApt")
	public String createApt() {
		return "createApt";
	}	
	
}
