package project.spring.guteam;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("구팀 프로젝트에 오신 여러분 환영합니다.");
		return "redirect:/game/list";
	} // end home() [mapping = "/" => "/game/list"]
	
	@GetMapping("/error/error")
	public void error() {
		logger.info("error페이지 호출");
	}
	
} // end HomeController
