package project.spring.guteam.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.service.MemberService;


@Controller // @Component
@RequestMapping(value = "/member")
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	// 로그인 메인
	@GetMapping("/login")
	public void loginGET() {
		logger.info("loginGET() 호출");
	}

	// 로그인
	@PostMapping("/login")
	public String loginPOST(String memberId, String password, String targetURL, HttpServletRequest request) {
		logger.info("loginPOST() 호출");
		if(memberId.equals("test") && password.equals("1234")) {
			logger.info("로그인 성공");
			HttpSession session = request.getSession();
			session.setAttribute("memberId", memberId);
			session.setMaxInactiveInterval(600);
			logger.info("세션 = " + session);
			logger.info("targetURL = " + targetURL);
			if(!targetURL.equals("")) {
				logger.info(targetURL);
				return "redirect:/" + targetURL;
			} else {
				return "redirect:/";
			}
		} else {
			logger.info("로그인 실패 targetURL = " + targetURL);
			return "redirect:/member/login";
		}
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		logger.info("logout() 호출");
		HttpSession session = request.getSession();
		if(session.getAttribute("memberId") != null) {
			session.removeAttribute("memberId");
			logger.info("로그아웃 성공");
			return "redirect:/";
		} else {
			return "redirect:/";
		}
	}
	
	

	// id 중복체크
	@PostMapping("/checkId")
	@ResponseBody
	public String checkIdPOST(String memberId) {
		logger.info("checkIdPOST() 호출");
		int result = memberService.read(memberId, "check");
		logger.info("memberService.read(memberId, \"check\") 값 = " +result);
		if (result == 1) {
			logger.info("id 있음 " + result);
			return "success";
		} else {
			logger.info("id 없음 " + result);
			return "fail";
		}
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
		if (result == 1) {
			reAttr.addFlashAttribute("알림", "success");
			return "redirect:/member/login";
		} else {
			return "redirect:/member/login";
		}
	}

} // end MemberController
