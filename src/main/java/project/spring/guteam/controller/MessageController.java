package project.spring.guteam.controller;

import java.security.Principal;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.domain.MessageSaveVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.pageutil.PageMaker;
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
	
	// 받은 쪽지함 (메인)
	@GetMapping("/list")
	public void list(Model model, Principal principal, Integer page, Integer numsPerPage) {
		logger.info("msg-listGET() 호출 ");
		logger.info("page = " + page + "/ numsPerPage = " + numsPerPage);
		MemberVO vo = null;
		PageCriteria criteria = new PageCriteria();
		criteria.setNumsPerPage(8);
		if(page != null) {
			criteria.setPage(page);
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		if(principal != null) {
			vo = memberService.read(principal.getName());
			logger.info("vo? " + vo.toString());
		}
		model.addAttribute("vo", vo);
		
		List<MessageReceiveVO> list = messageService.readReceiveList(vo.getMemberId(), criteria);
		model.addAttribute("list", list);
		logger.info("list = " + list.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(messageService.getReceiveCounts(principal.getName()));
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
		
	} //end list()
	
	// 보낸 쪽지함
	@GetMapping("/sent")
	public void sent(Model model, Principal principal, Integer page, Integer numsPerPage) {
		logger.info("sentGET() 호출");
		logger.info("page = " + page + "/ numsPerPage = " + numsPerPage);
		MemberVO vo = null;
		PageCriteria criteria = new PageCriteria();
		criteria.setNumsPerPage(8);
		if(page != null) {
			criteria.setPage(page);
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		if(principal != null) {
			vo = memberService.read(principal.getName());
			logger.info("vo? " + vo.toString());
		}
		model.addAttribute("vo", vo);
		
		List<MessageSendVO> list = messageService.readSendList(vo.getMemberId(), criteria);
		model.addAttribute("list", list);
		logger.info(list.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(messageService.getSentCounts(principal.getName()));
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
	}
	
	// 쪽지 보관함
	@GetMapping("/msgBox")
	public void msgBox(Model model, Principal principal, Integer page, Integer numsPerPage) {
		logger.info("msgBox() 호출");
		logger.info("page = " + page + "/ numsPerPage = " + numsPerPage);
		MemberVO vo = null;
		PageCriteria criteria = new PageCriteria();
		criteria.setNumsPerPage(8);
		if(page != null) {
			criteria.setPage(page);
		}
		if(numsPerPage != null) {
			criteria.setNumsPerPage(numsPerPage);
		}
		
		if(principal != null) {
			vo = memberService.read(principal.getName());
			logger.info("vo? " + vo.toString());
		}
		model.addAttribute("vo", vo);
		
		List<MessageSaveVO> list = messageService.readSavedList(vo.getMemberId(), criteria);
		model.addAttribute("list", list);
		logger.info(list.toString());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCriteria(criteria);
		pageMaker.setTotalCount(messageService.getBoxCounts(principal.getName()));
		pageMaker.setPageData();
		model.addAttribute("pageMaker", pageMaker);
	}
	
	// 쪽지 상세 보기
	@GetMapping("/detail")
	public String detail(Model model, int messageId, Integer page, Principal principal) {
		logger.info("msg-detail() 호출 messageId = " + messageId );
		MessageSendVO svo = messageService.readBySend(messageId);
		MessageReceiveVO rvo = messageService.readByReceive(messageId);
		if(rvo != null && rvo.getReceiveMemberId().equals(principal.getName())) { // 매개변수를 int로 사용하면 null 값 처리를 할 수 없음
			logger.info("받은 쪽지의 상세 rvo = " + rvo.toString());
			model.addAttribute("vo", rvo);
			model.addAttribute("sendOrReceive","receive");
		}else if(svo != null && svo.getSendMemberId().equals(principal.getName())){	
			logger.info("보낸 쪽지의 상세 rvo = " + svo.toString());
			model.addAttribute("vo", svo);
			model.addAttribute("sendOrReceive","send");
		}else {
			return "/404";
		}
		model.addAttribute("page", page);
		return "message/detail";
	}
	
	// 쪽지 보내기 화면
	@GetMapping("/write")
	public void writeGET(Model model, Principal principal, String receiveMemberId, String messageTitle, String messageContent) {
		logger.info("msg-writeGET() 호출");
		MemberVO vo = memberService.read(principal.getName());
		model.addAttribute("vo", vo);
		model.addAttribute("receiveMemberId", receiveMemberId);
		model.addAttribute("messageContent", messageContent);
		model.addAttribute("messageTitle",messageTitle);
		logger.info("vo? " + vo.toString());
	}
	
	// 쪽지 보내기
	@PostMapping("/write")
	public String writePOST(MessageSendVO svo, String receiverNickname, Principal principal, RedirectAttributes reAttr) {
		logger.info("msg-writePOST() 호출 vo ? " + svo.toString());
		int result = messageService.create(svo);
		if(result == 1) {
			logger.info("쪽지 보내기 성공");
			reAttr.addFlashAttribute("alert", "send");
			return "redirect:/message/list";
			
		} else {
			// 전송 실패시 작성 내역 유지되게 바꾸기
			logger.info("쪽지 전송 실패");
			return "redirect:/message/write";
		}
	}
//	
//	
//	
//	
//	// 미리보기
// 	@GetMapping("/display")
//     public ResponseEntity<byte[]> display(String fileName) {
////	         logger.info("display() 호출 fileName = " + fileName);
//         ResponseEntity<byte[]> entity = null;
//         InputStream in = null;
//         
//         //  / 없을때 넣는 조건
//         if(!(fileName.charAt(0) == '/')) {
//         	fileName = "/" + fileName;
//         }
//         String filepath = uploadPath + fileName;
////	         logger.info("filepath 경로 = " + filepath);
//         try {
//             in = new FileInputStream(filepath); // InputStream에 넣어서 
//             // 파일 확장자
//             String extension = 
//                     filepath.substring(filepath.lastIndexOf(".") + 1);
////	             logger.info(extension);
//             
//             // 응답 헤더(response header)에 Content-type 설정
//             HttpHeaders httpHeaders = new HttpHeaders();
//             httpHeaders.setContentType(MediaUtil.getMediaType(extension)); // 까지가 확장자 인식
//             // 데이터 전송
//             entity = new ResponseEntity<byte[]>( // ResponseEntity JSON에서 데이터 보낼때 씀
//                     IOUtils.toByteArray(in), // 파일에서 읽은 데이터
//                     httpHeaders, // 응답 헤더
//                     HttpStatus.OK
//                     );
//         } catch (Exception e) {
//             // TODO Auto-generated catch block
//             e.printStackTrace();
//         }
//         return entity;
//     } //end display()
//	
} //end MessageController
