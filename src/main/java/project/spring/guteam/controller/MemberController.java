package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.service.MemberService;

@Controller // @Component
@RequestMapping(value="/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	
	// 로그인 메인

	@GetMapping("/login")
	public void loginGET() {
		logger.info("loginGET() 호출");
	}
	
	// 회원가입 화면
	@GetMapping("/register")
	public void registerGET() {
		logger.info("registerGET() 호출");
	}
	
	// 회원가입 등록
	@PostMapping("/register")
	public String registerPOST(MemberVO vo, RedirectAttributes reAttr) {
		logger.info("registerPOST() 호출");
		logger.info(vo.toString());
		
		int result = memberService.create(vo);
		logger.info(result + " 행 삽입");
		if(result == 1) {
			reAttr.addFlashAttribute("알림", "success");
			return "redirect:/game/list";
		} else {
			return "redirect:/member/login";
		}
	}
	
	
	

} //end MemberController
