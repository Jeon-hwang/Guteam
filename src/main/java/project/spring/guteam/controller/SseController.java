package project.spring.guteam.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import project.spring.guteam.notiutil.SseEmitters;

@RestController
@RequestMapping(value="/sse")
public class SseController {
	private static final Logger logger = LoggerFactory.getLogger(SseController.class);
	
	private final SseEmitters sseEmitters;
	
	public SseController(SseEmitters sseEmitters) {
		this.sseEmitters = sseEmitters;
	} // end SseController()
	
	@GetMapping(value="/connect/{memberId}", produces=MediaType.TEXT_EVENT_STREAM_VALUE)
	public ResponseEntity<SseEmitter> connect(@PathVariable("memberId") String memberId){
		logger.info("connect! :" + memberId);
		SseEmitter emitter = new SseEmitter(60 * 1000L * 10); 
		// 10분으로 설정(10분이 지나면 자동으로 클라이언트가 다시 요청하도록 함)
		sseEmitters.add(memberId, emitter); // sseEmitters 에 추가
		return ResponseEntity.ok(emitter);
	} // end connect()
	
	@Async
	@PostMapping("/friendRequest/{memberId}")
	public ResponseEntity<Void> friendRequest(@PathVariable("memberId") String memberId, @RequestParam String sendMemberId){
		logger.info("memberId : " + memberId + ", sendMemberId : " + sendMemberId);
		sseEmitters.friendRequest(memberId, sendMemberId); // 친구 요청을 memberId 를 기준으로 알림
		return ResponseEntity.ok().build();
	} // end friendRequest()
	
	@Async
	@PostMapping("/message/{memberId}")
	public ResponseEntity<Void> message(@PathVariable("memberId") String memberId, @RequestParam String sendMemberId){
		logger.info("memberId : " + memberId + ", sendMemberId : " + sendMemberId);
		sseEmitters.message(memberId, sendMemberId); // 메시지를 memberId 를 기준으로 알림
		return ResponseEntity.ok().build();
	}

} // end SseController
