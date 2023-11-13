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
		model.addAttribute("genreList",genreList); // 현재 존재하는 모든 장르 리스트를 반환하여 dropdown 버튼에 보여줌
		model.addAttribute("discountList", discountList); // 장르별 할인 목록을 가져와 보여줌
	} // end updateGET() - [getMapping "/discount/update"]
	
	@PostMapping("/update")
	public String updatePOST(DiscountVO vo,  RedirectAttributes reAttr) {
//		logger.info("discount update() 호출 : vo = " + vo);
		int result = discountService.update(vo); // form data 로 테이블 자료를 업데이트함
		if(result == 1 ) {
			reAttr.addFlashAttribute("discount_result", "success");
			return "redirect:/game/list"; // 업데이트 성공시 메인 화면으로 redirect
		}else {
			reAttr.addFlashAttribute("discount_result", "fail");
			return "redirect:/discount/update"; // 업데이트 실패시 할인 페이지로 redirect
		}
	} // end updatePOST() - [postMapping "/discount/update" => "/game/list" or "/discount/update"]
	
	@PostMapping("/{genre}")
	public ResponseEntity<String> delete(@PathVariable("genre") String genre){
		int result = 0; 
		result = discountService.delete(genre); // 장르를 기준으로 할인 적용을 삭제함
		if(result==1) {
			return new ResponseEntity<String>("success", HttpStatus.OK); // 성공시 success 메시지를 전송
		}else {
			return new ResponseEntity<String>("fail", HttpStatus.OK); // 실패시 fail 메시지를 전송
		}
	} //end delete() - [postMapping "/{genre}"]
} // end DiscountController
