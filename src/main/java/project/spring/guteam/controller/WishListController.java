package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/wishList")
public class WishListController {
	private static final Logger logger = LoggerFactory.getLogger(WishListController.class);
	

	@GetMapping("/myWishList")
	public void wishListGET() {
		logger.info("호출");
	}

}
