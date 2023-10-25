package project.spring.guteam.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.security.Principal;
import java.util.List;

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

import project.spring.guteam.domain.FriendRequestVO;
import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.fileutil.MediaUtil;
import project.spring.guteam.service.FriendRequestService;
import project.spring.guteam.service.MemberService;

@Controller // @Component
@RequestMapping(value = "/friend")
public class FriendController {
	private static final Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FriendRequestService friendRequestService;
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
//	// 친구 목록
//    @GetMapping("/list")
//    public void listGET(Model model, Principal principal) {
//    	logger.info("(friend) listGET() 호출");
//    	MemberVO vo = new MemberVO();
//		String memberId = principal.getName();
//		logger.info(memberId);
//		vo = memberService.read(memberId);
//		model.addAttribute("vo", vo);
//		logger.info(vo.toString());
//    }
    
//	// 친구 목록
//    @GetMapping("/list")
//    public void listGET(Model model, Principal principal) {
//    	logger.info("(friend) listGET() 호출");
//    	List<String> sendMemberList;
//    	List<MemberVO> sendList;
//    	sendMemberList = friendRequestService.readTo(principal.getName());
//    	for(int i=0; i<sendMemberList.size(); i++) {
//    		MemberVO vo = memberService.read(sendMemberList.get(i));
//    		sendList.add(vo);
//    	}
//    	model.addAttribute("sendList", sendList);
//    }
    
    // 친구 추가
    @PostMapping("/addFriend")
    public String addFriend (FriendRequestVO vo, Principal principal, RedirectAttributes reAttr) {
 		logger.info("addFriend() 호출 vo = " + vo.toString());
 		int result = friendRequestService.read(principal.getName());
 		if(result != 1) {
 			result = friendRequestService.create(vo);
 			if(result == 1) {
 	 			logger.info("친구 요청 성공");
 	 			reAttr.addFlashAttribute("alert", "success");
 	 			return "redirect:/friend/list";
 	 		} else {
 	 			logger.info("친구 요청 실패");
 	 			reAttr.addFlashAttribute("alert", "fail");
 	 			return "redirect:/friend/list";
 	 		}
 		} else {
 			logger.info("친구 신청 중복? y");
 			reAttr.addFlashAttribute("alert", "dupl");
 			return "redirect:/friend/list";
 		}
 	} //end addFirend()
    
	
	// 받은 요청 조회
    
    // 미리보기
 	@GetMapping("/display")
     public ResponseEntity<byte[]> display(String fileName) {
         logger.info("display() 호출 fileName = " + fileName);
         
         ResponseEntity<byte[]> entity = null;
         InputStream in = null;
         
         String filepath = uploadPath + fileName;
         logger.info("filepath 경로 = " + filepath);
         
         try {
             in = new FileInputStream(filepath); // InputStream에 넣어서
             
             // 파일 확장자
             String extension = 
                     filepath.substring(filepath.lastIndexOf(".") + 1);
             logger.info(extension);
             
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
	
	
} //end friendController
