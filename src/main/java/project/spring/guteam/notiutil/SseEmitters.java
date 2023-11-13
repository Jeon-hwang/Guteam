package project.spring.guteam.notiutil;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Component
public class SseEmitters {
	private final Logger logger = LoggerFactory.getLogger(SseEmitters.class);
	private final Map<String, SseEmitter>emitters = new ConcurrentHashMap<String, SseEmitter>();
	
	public SseEmitter add(String memberId, SseEmitter emitter) {
		this.emitters.put(memberId, emitter);
		logger.info("new emitter added: {}", emitter);
		logger.info("emitter list size: {}", emitters.size());
		emitter.onCompletion(() -> { // onComplete 시 remove
			logger.info("onCompletion callback");
			this.emitters.remove(memberId);
		});
		emitter.onTimeout(() -> { // onTimeout 시 complete
			logger.info("onTimeout callback");
			emitter.complete();
		});
		return emitter;
	} // end add()

	public void friendRequest(String memberId, String sendMemberId) {
		emitters.forEach((key,emitter) -> {
			if(key.equals(memberId)&&emitter!=null) { 
				// map 에서 memberId 와 일치하는 키가 있으면 emitter로 event 발신
				try {
					emitter.send(SseEmitter.event().name(memberId).data(sendMemberId));
				}catch(IOException e){
					throw new RuntimeException(e);
				}
			}
		}); // end emitters.forEach()
		
	} // end friendRequest()

} // end SseEmitters
