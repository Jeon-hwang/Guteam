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

@Async
@RestController
@RequestMapping(value="/sse")
public class SseController {
	private static final Logger logger = LoggerFactory.getLogger(SseController.class);
	
	private final SseEmitters sseEmitters;
	
	public SseController(SseEmitters sseEmitters) {
		this.sseEmitters = sseEmitters;
	}
	
	@GetMapping(value="/connect/{memberId}", produces=MediaType.TEXT_EVENT_STREAM_VALUE)
	public ResponseEntity<SseEmitter> connect(@PathVariable("memberId") String memberId){
		logger.info("connect! :" + memberId);
		SseEmitter emitter = new SseEmitter(60 * 1000L * 10);
		sseEmitters.add(memberId, emitter);
		return ResponseEntity.ok(emitter);
	}
	
	@PostMapping("/friendRequest/{memberId}")
	public ResponseEntity<Void> count(@PathVariable("memberId") String memberId, @RequestParam String sendMemberId){
		logger.info("memberId : " + memberId + ", sendMemberId : " + sendMemberId);
		sseEmitters.friendRequest(memberId, sendMemberId);
		return ResponseEntity.ok().build();
	}

}
