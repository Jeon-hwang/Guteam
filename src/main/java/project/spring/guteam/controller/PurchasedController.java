package project.spring.guteam.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.service.PurchasedService;

@Controller
@RequestMapping(value="/purchased")
public class PurchasedController {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedController.class);
	
	@Autowired
	PurchasedService purchasedService;
	
	@GetMapping("/myPurchased")
	public void myPurchased() {}
	
	/*@PostMapping("/myWishList")
	public String wishListPOST(int[] gameIds, int totalPriceInput, Principal principal) {
		logger.info(totalPriceInput + "원");
		logger.info(principal.getName()+ "유저가 고름");
		return "redirect:/purchased/purchaseWindow";
	}*/
	
	  @GetMapping("/purchaseWindow")
	  public void purchaseWindow(Model model,String gameIds, Principal principal) {
		  	logger.info(principal.getName()); // 로그인 되 어있는 아이디
			logger.info(gameIds + "게임"); // 체크해둔 게임들
			
			Map<String, Object> data = purchasedService.readBuyGame(gameIds, principal.getName());
			List<GameVO> list = (List<GameVO>) data.get("list");
			int cash = (int) data.get("cash");
			
			model.addAttribute("list", list);
			model.addAttribute("cash", cash);
  }
/*	public void purchaseWindow(Model model,int gameId,String memberId) {
		logger.info("구매창으로 이동 게임아디 : , 멤버 아디 : "+gameId+", "+memberId);
		GameVO gameVO = gameService.read(gameId);
		MemberVO memberVO = memberService.read(memberId);
		model.addAttribute("memberVO", memberVO);
		model.addAttribute("gameVO", gameVO);
	}*/
}
