package project.spring.guteam.controller;

import java.security.Principal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.KakaoPayApprovalVO;
import project.spring.guteam.service.KakaoPayService;
import project.spring.guteam.service.MemberService;

@Controller // @Component
@RequestMapping(value="/payment")
public class PaymentController {
	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);
	
	// 카카오페이 결제
	@Autowired
	private KakaoPayService kakaoPay;
	
	@Autowired
	private MemberService memberService;
		
	@PostMapping("/kakaoPay")
	public String KakaoPay(Principal principal, Integer cash) {
		 logger.info("kakaoPay post............................................");
	     return "redirect:" + kakaoPay.kakaoPayReady(principal.getName(), cash);
		
	}
	
	@GetMapping("/kakaoPaySuccess")
	public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, RedirectAttributes reAttr, Principal principal, Integer cash) {
        logger.info("kakaoPaySuccess get............................................");
        logger.info("kakaoPaySuccess pg_token : " + pg_token);
        KakaoPayApprovalVO vo = kakaoPay.kakaoPayInfo(pg_token, principal.getName(), cash+"");
        int result=0;
        if(vo.getPartner_user_id().equals(principal.getName())) {
        	result = memberService.update(vo.getPartner_user_id(), vo.getAmount().getTotal());        	
        }
        if(result==1) {
        	reAttr.addFlashAttribute("charge_result", "success");
        	reAttr.addFlashAttribute("info", vo);
        	return "redirect:/member/profiles";  
        }
        return "redirect:/member/profiles";
    }
    
}
