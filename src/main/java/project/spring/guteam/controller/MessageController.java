package project.spring.guteam.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.security.Principal;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.domain.MessageVO;
import project.spring.guteam.fileutil.MediaUtil;
import project.spring.guteam.service.MemberService;
import project.spring.guteam.service.MessageService;

@Controller // @Component
@RequestMapping(value = "/message")
public class MessageController {
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MessageService messageService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
	// 쪽지함 메인
	@GetMapping("/list")
	public void listGET(Model model, Principal principal) {
		logger.info("msg-listGET() 호출 ");
		MemberVO vo = null;
		if(principal!=null) {
			vo = memberService.read(principal.getName());
		}
		model.addAttribute("vo", vo);
//		logger.info("vo? " + vo.toString());
	}
	
	// 쪽지 상세 보기
	@GetMapping("/detail")
	public void detailGET(Model model, Integer messageId, Principal principal) {
		logger.info("msg-detailGET() 호출");
	}
	
	// 쪽지 보내기 화면
	@GetMapping("/register")
	public void registerGET(Model model, Principal principal) {
		logger.info("msg-registerGET() 호출");
		MemberVO vo = memberService.read(principal.getName());
		model.addAttribute("vo", vo);
		logger.info("vo? " + vo.toString());
	}
	
	// 쪽지 보내기
	@PostMapping("/register")
	public String registerPOST(MessageVO vo, String receiverNickname, Principal principal, RedirectAttributes reAttr) {
		logger.info("msg-registerPOST() 호출 vo ? " + vo.toString());
		int result = messageService.create(vo);
		if(result == 1) {
			logger.info("쪽지 보내기 성공");
			reAttr.addFlashAttribute("alert", "send");
			return "redirect:/message/list";
		} else {
			// 전송 실패시 작성 내역 유지되게 바꾸기
			logger.info("쪽지 전송 실패");
			return "redirect:/message/register";
		}
	}
	
	
	// 미리보기
 	@GetMapping("/display")
     public ResponseEntity<byte[]> display(String fileName) {
//	         logger.info("display() 호출 fileName = " + fileName);
         ResponseEntity<byte[]> entity = null;
         InputStream in = null;
         
         //  / 없을때 넣는 조건
         if(!(fileName.charAt(0) == '/')) {
         	fileName = "/" + fileName;
         }
         String filepath = uploadPath + fileName;
//	         logger.info("filepath 경로 = " + filepath);
         try {
             in = new FileInputStream(filepath); // InputStream에 넣어서 
             // 파일 확장자
             String extension = 
                     filepath.substring(filepath.lastIndexOf(".") + 1);
//	             logger.info(extension);
             
             // 응답 헤더(response header)에 Content-type 설정
             HttpHeaders httpHeaders = new HttpHeaders();
             httpHeaders.setContentType(MediaUtil.getMediaType(extension)); // 까지가 확장자 인식
             // 데이터 전송
             entity = new ResponseEntity<byte[]>( // ResponseEntity JSON에서 데이터 보낼때 씀
                     IOUtils.toByteArray(in), // 파일에서 읽은 데이터
                     httpHeaders, // 응답 헤더
                     HttpStatus.OK
                     );
         } catch (Exception e) {
             // TODO Auto-generated catch block
             e.printStackTrace();
         }
         return entity;
     } //end display()
	
} //end MessageController
