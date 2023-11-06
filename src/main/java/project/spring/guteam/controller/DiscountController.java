package project.spring.guteam.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.DiscountVO;
import project.spring.guteam.service.DiscountService;

@Controller
@RequestMapping(value = "/discount")
public class DiscountController {
	private static final Logger logger = LoggerFactory.getLogger(DiscountController.class);
	
	@Autowired
	private DiscountService discountService;
	
	@GetMapping("/update")
	public void updateGET(Model model) {
		List<String> genreList = discountService.readAllGenre();
		List<DiscountVO> discountList = discountService.read();
		model.addAttribute("genreList",genreList);
		model.addAttribute("discountList", discountList);
	}
	
	@PostMapping("/update")
	public String updatePOST(DiscountVO vo,  RedirectAttributes reAttr) {
		logger.info("discount update() 호출 : vo = " + vo);
		int result = discountService.update(vo);
		if(result == 1 ) {
			reAttr.addFlashAttribute("discount_result", "success");
			return "redirect:/game/list";
		}else {
			reAttr.addFlashAttribute("discount_result", "fail");
			return "redirect:/discount/update";
		}
	}
	
	@PostMapping("/{genre}")
	public ResponseEntity<String> delete(@PathVariable("genre") String genre){
		int result = 0; 
		result = discountService.delete(genre);
		if(result==1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}else {
			return new ResponseEntity<String>("fail", HttpStatus.OK);
		}
	}
}
