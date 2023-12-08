package project.spring.guteam.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.security.Principal;
import java.util.ArrayList;
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
import project.spring.guteam.domain.FriendVO;
import project.spring.guteam.domain.MemberVO;
import project.spring.guteam.fileutil.MediaUtil;
import project.spring.guteam.service.FriendRequestService;
import project.spring.guteam.service.FriendService;
import project.spring.guteam.service.MemberService;

@Controller // @Component
@RequestMapping(value = "/friend")
public class FriendController {
	private static final Logger logger = LoggerFactory.getLogger(FriendController.class);
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private FriendRequestService friendRequestService;
	
	@Autowired
	private FriendService friendService;
	
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
    
	// 친구 목록
    @GetMapping("/list")
    public void listGET(Model model, Principal principal) {
    	logger.info("(friend) listGET() 호출");
    	List<String> sendMemberList;
    	List<String> receiveMemberList;
    	List<String> myFriendList;
    	
    	List<MemberVO> sendList = new ArrayList<MemberVO>();
    	List<MemberVO> receiveList = new ArrayList<MemberVO>();
    	List<MemberVO> friendList = new ArrayList<MemberVO>();
    	
    	sendMemberList = friendRequestService.readTo(principal.getName());
    	for(int i=0; i<sendMemberList.size(); i++) {
    		MemberVO vo = memberService.read(sendMemberList.get(i));
    		if(vo != null) { // null값 처리 조건문
    			sendList.add(vo);    			
    		}
    	}
    	
    	receiveMemberList = friendRequestService.readFrom(principal.getName());
    	for(int i=0; i<receiveMemberList.size(); i++) {
    		MemberVO vo = memberService.read(receiveMemberList.get(i));
    		if(vo != null) {
    			receiveList.add(vo);    			
    		}
    	}
    	
    	myFriendList = friendService.read(principal.getName());
    	for(int i=0; i<myFriendList.size(); i++) {
    		MemberVO vo = memberService.read(myFriendList.get(i));
    		if(vo != null) {
    			friendList.add(vo);    			
    		}
    	}
    	
    	model.addAttribute("vo", memberService.read(principal.getName()));
    	model.addAttribute("sendList", sendList);
    	model.addAttribute("receiveList", receiveList);
    	model.addAttribute("friendList", friendList);
    }
    
    // 친구 추가 요청
    @PostMapping("/addFriend")
    public String addFriend (FriendRequestVO vo, RedirectAttributes reAttr, Principal principal) {
    	logger.info("addFriend() vo ? " + vo.toString());
    	// 본인한테 용청하다니
    	if(vo.getReceiveMemberId().equals(principal.getName())) {
    		logger.info("본인입니다요.");
    		reAttr.addFlashAttribute("fnd_alert", "me");
            return "redirect:/friend/list";
    	}
    	// 이미 친구인지?
    	int result = friendService.read(principal.getName(), vo.getReceiveMemberId());
    	if ( memberService.read(vo.getReceiveMemberId())==null) {
    		logger.info("없는 아이디 입니다.");
			reAttr.addFlashAttribute("fnd_alert", "fail");
			return "redirect:/friend/list";
    	}
    	
    	if(result == 1) { // 이미 친구
    		reAttr.addFlashAttribute("fnd_alert", "friend");
	 			return "redirect:/friend/list";
    	}else {
    		// 친추할 아이디가 이미 나한테 요청
    		// ㄴ 조회시에는 friendRequestService.read(vo.getSendMemberId(), principal.getName())
    		//--> 초대시 바로 친구
    		result = friendRequestService.read(vo.getReceiveMemberId(), principal.getName());
    		logger.info("이미 요청 받아 친추시 바로 친구됨 보낸이 = " +  vo.getSendMemberId());
    		if(result == 1) {// id로 부터 받은 요청 조회
    			FriendVO fvo = new FriendVO(vo.getSendMemberId(), vo.getReceiveMemberId());
    			reAttr.addFlashAttribute("fnd_alert", "alreadyFrd");
        		return acceptPOST(fvo);
    		}else {
    			result = memberService.read(vo.getReceiveMemberId(), "check");
    			logger.info("멤버 중 아이디 있나? 1이면 있음 = " + result);
    			
    			if(result == 1) {// 위의 회원 전체 select이 밑으로 가면 좀더 효율적?
    				result = friendRequestService.read(principal.getName(), vo.getReceiveMemberId());
    				logger.info("이미 친추 요청 상태? 1이면 이미 신청함 = " + result);
    				if(result != 1) {
    					result = friendRequestService.create(vo);
    					logger.info("친구 요청 성공");
    					reAttr.addFlashAttribute("fnd_alert", "success");
    					return "redirect:/friend/list";
    				} else {
    					// 취소로 바꿔 줄 수 있음 (아니면 한번 더 요청하면 친구요청 취소)
    					logger.info("친구 신청 중복? y");
    					reAttr.addFlashAttribute("fnd_alert", "dupl");
    					return "redirect:/friend/list";
    				}
    			} else {
    				logger.info("없는 아이디 입니다.");
    				reAttr.addFlashAttribute("fnd_alert", "fail");
    				return "redirect:/friend/list";
    			}
    		}
    	}
 	} //end addFirend()
    
    // 친구 요청 신청 취소
    @PostMapping("/cancel")
    public String cancel (FriendVO vo) {
    	logger.info("친구 요청 취소 vo? " + vo.toString());
    	int result = friendRequestService.delete(vo.getMemberId(), vo.getFriendId());
    	if(result == 1) {
    		return "redirect:/friend/list";
    	} else {
    		return "redirect:/friend/list";
    	}
    }
    
	
	// 받은 요청 수락
    @PostMapping("/accept")
    public String acceptPOST(FriendVO vo) {
    	logger.info("acceptPOST() vo ? " + vo.toString());
    	int result = friendService.create(vo);
    	logger.info("친구 수락? " + result);
    	if(result == 1) {
    		return "redirect:/friend/list";
    	} else {
    		return "redirect:/friend/list";
    	}
    }
    
    // 받은 요청 거절
    @PostMapping("/reject")
    public String rejectPOST(FriendVO vo) {
    	logger.info("친구 요청 거절 vo? " + vo.toString());
    	int result = friendRequestService.delete(vo.getFriendId(), vo.getMemberId());
    	if(result == 1) {
    		return "redirect:/friend/list";
    	} else {
    		return "redirect:/friend/list";
    	}
    }
    
    // 친구 삭제
    @PostMapping("/delete")
    public String deletePOST(FriendVO vo, Principal principal) {
    	logger.info("친구 삭제 요청 vo = " + vo.toString());
    	int result = friendService.delete(principal.getName(), vo.getFriendId());
    	if(result == 1) {
    		return "redirect:/friend/list";
    	} else {
    		return "redirect:/friend/list";
    	}
    }
    
    
    // 미리보기
 	@GetMapping("/display")
     public ResponseEntity<byte[]> display(String fileName) {
//         logger.info("display() 호출 fileName = " + fileName);
         
         ResponseEntity<byte[]> entity = null;
         InputStream in = null;
         
         //  / 없을때 넣는 조건
         if(!(fileName.charAt(0) == '/')) {
         	fileName = "/" + fileName;
         }
         
         String filepath = uploadPath + fileName;
//         logger.info("filepath 경로 = " + filepath);
         
         try {
             in = new FileInputStream(filepath); // InputStream에 넣어서
             
             // 파일 확장자
             String extension = 
                     filepath.substring(filepath.lastIndexOf(".") + 1);
//             logger.info(extension);
             
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
