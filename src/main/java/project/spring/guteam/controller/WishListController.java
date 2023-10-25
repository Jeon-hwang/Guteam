package project.spring.guteam.controller;

import java.security.Principal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/wishList")
public class WishListController {
	private static final Logger logger = LoggerFactory.getLogger(WishListController.class);
	

	@GetMapping("/myWishList")
	public void wishListGET() {
		logger.info("호출");
	}

	@PostMapping("/myWishList")
	public String wishListPOST(int[] gameIds, int totalPriceInput, Principal principal) {
		for(int x : gameIds) {
			logger.info(x + "게임");
		}
		logger.info(totalPriceInput + "원");
		logger.info(principal.getName()+ "유저가 고름");
		return "redirect:/purchased/purchaseWindow?";
	}
}
