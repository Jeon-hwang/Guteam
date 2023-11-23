package project.spring.guteam.controller;

import java.security.Principal;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.service.WishListService;

@Controller
@RequestMapping(value="/wishList")
public class WishListController {
	private static final Logger logger = LoggerFactory.getLogger(WishListController.class);
	
	@Autowired
	private WishListService wishListService;
	
	
	@GetMapping("/myWishList")
	public void wishListGET(Principal principal,HttpServletRequest request,Model model) {
	
		String referer = request.getHeader("Referer");
		logger.info(referer);
		
		if(principal!=null) {			
		String memberId = principal.getName();
		
		Cookie[] cookies = request.getCookies();
		for(Cookie cookie : cookies) {
			if(cookie.getName().equals("wishListGameId")) {
				String[] gameIds = cookie.getValue().split("%");
				for(int i=0;i<gameIds.length;i++) {	
					int gameId = Integer.parseInt(gameIds[i]);
					logger.info("======gameId= "+gameId);
					
					// WishListVO tempt = wishListService.find(memberId,Integer.parseInt(gameIds[i]));
					if(wishListService.find(memberId,gameId)==null) {
						WishListVO vo = new WishListVO(memberId, gameId);
						logger.info(vo+"");
						wishListService.create(vo);						
					}
				}
			}// end cookie(wishListGameId)
		}
		}
		logger.info("호출");
		model.addAttribute("referer",referer);
	}

}
