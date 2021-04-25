package org.apartment.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apartment.domain.CustomKeeper;
import org.apartment.domain.CustomUser;
import org.apartment.domain.JoinKeeperVO;
import org.apartment.domain.JoinTenantVO;
import org.apartment.domain.TenantFeeInfoVO;
import org.apartment.mapper.MemberMapper;
import org.apartment.service.FeeService;
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
	FeeService feeService;
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
	@GetMapping("/tenant/dashboard")
	public String tenantHome(Authentication auth, Model model) {
		CustomUser user = (CustomUser) auth.getPrincipal();
		System.out.println(user.getAptSeq());
		List<TenantFeeInfoVO> tenantFeeInfoVO =  feeService.tenantFeeInfo(user.getMemberSeq(), 6);
		model.addAttribute("tenantFeeInfo", tenantFeeInfoVO);
		System.out.println(tenantFeeInfoVO.size());
		
		TenantFeeInfoVO last = null;
		TenantFeeInfoVO beforeLast = null;
		TenantFeeInfoVO thirdLast = null;
		TenantFeeInfoVO fourthLast = null;
		TenantFeeInfoVO fifthLast = null;
		TenantFeeInfoVO sixthLast = null;

		if (tenantFeeInfoVO != null && tenantFeeInfoVO.size() >= 6) {
			last = tenantFeeInfoVO.get(0);
			beforeLast = tenantFeeInfoVO.get(1);
			thirdLast = tenantFeeInfoVO.get(2);
			fourthLast = tenantFeeInfoVO.get(3);
			fifthLast = tenantFeeInfoVO.get(4);
			sixthLast = tenantFeeInfoVO.get(5);
		} else if (tenantFeeInfoVO != null && tenantFeeInfoVO.size() == 5) {
			last = tenantFeeInfoVO.get(0);
			beforeLast = tenantFeeInfoVO.get(1);
			thirdLast = tenantFeeInfoVO.get(2);
			fourthLast = tenantFeeInfoVO.get(3);
			fifthLast = tenantFeeInfoVO.get(4);
		} else if (tenantFeeInfoVO != null && tenantFeeInfoVO.size() == 4) {
			last = tenantFeeInfoVO.get(0);
			beforeLast = tenantFeeInfoVO.get(1);
			thirdLast = tenantFeeInfoVO.get(2);
			fourthLast = tenantFeeInfoVO.get(3);
		} else if (tenantFeeInfoVO != null && tenantFeeInfoVO.size() == 3) {
			last = tenantFeeInfoVO.get(0);
			beforeLast = tenantFeeInfoVO.get(1);
			thirdLast = tenantFeeInfoVO.get(2);
		} else if (tenantFeeInfoVO != null && tenantFeeInfoVO.size() == 2) {
			last = tenantFeeInfoVO.get(0);
			beforeLast = tenantFeeInfoVO.get(1);
			System.out.println(last);
			
		} else if (tenantFeeInfoVO != null && tenantFeeInfoVO.size() == 1) {
			last = tenantFeeInfoVO.get(0);
			System.out.println(last);
		}
		
		model.addAttribute("last", last);
		model.addAttribute("beforeLast", beforeLast);
		model.addAttribute("thirdLast", thirdLast);
		model.addAttribute("fourthLast", fourthLast);
		model.addAttribute("fifthLast", fifthLast);
		model.addAttribute("sixthLast", sixthLast);
		
		return "userDashBoard";
	}
	@GetMapping("/tenant/a")
	public String test() {
		return "test";
	}
	@GetMapping("/keeper/a")
	public String test1() {
		return "managerDashBoard";
	}
	// 세입자 로그인 페이지 
	@GetMapping("/tenant/signin")
	public String signinGet() {
		return "tenantSignin";
	}
	@GetMapping("/tenant/main")
	public String tt() {
		return "userDashBoard";
	}
	
	@GetMapping("/keeper/signin")
	public String signinKeeper() {
		return "keeperSignin";
	}
	
	// tenant 회원가입 페이지 & 회원가입시 form 요청 받는 페이지 
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
			rttr.addFlashAttribute("status", "값이 중복되었습니다.");
			return "redirect:/tenant/signup";
		} else if (result == 0) {
			rttr.addFlashAttribute("status", "문제가 일어났습니다. 잠시후 시도해주세요.");
			return "redirect:/tenant/signup";
		} else {
			rttr.addFlashAttribute("status", "성공적으로 회원가입 되었습니다 로그인 해주세요.");
			return "redirect:/tenant/signin";
		}
	}
	// keeper 회원가입 페이지 & 회원가입시 form 요청 받는 부분 
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
			rttr.addFlashAttribute("status", "값이 중복되었습니다.");
			return "redirect:signup";
		} else if (result == 0) {
			rttr.addFlashAttribute("status", "문제가 일어났습니다. 잠시후 시도해주세요.");
			return "redirect:signup";
		} else {
			rttr.addFlashAttribute("status", "성공적으로 회원가입 되었습니다 로그인 해주세요.");
			return "redirect:/signin";
		}
	}
	
	// 아파트 만드는 페이지 매핑 
	@GetMapping("/createApt")
	public String createApt() {
		return "createApt";
	}	
	
}