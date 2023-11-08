package project.spring.guteam.notiutil;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.atomic.AtomicLong;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Component
public class SseEmitters {
	private final Logger logger = LoggerFactory.getLogger(SseEmitters.class);
	private final List<SseEmitter>emitters = new CopyOnWriteArrayList<SseEmitter>();
	
	public SseEmitter add(SseEmitter emitter) {
		this.emitters.add(emitter);
		logger.info("new emitter added: {}", emitter);
		logger.info("emitter list size: {}", emitters.size());
		emitter.onCompletion(() -> {
			logger.info("onCompletion callback");
			this.emitters.remove(emitter);
		});
		emitter.onTimeout(() -> {
			logger.info("onTimeout callback");
			emitter.complete();
		});
		
		return emitter;
	}

	public void friendRequest(String memberId, String sendMemberId) {
		emitters.forEach(emitter -> {
			if(emitter!=null) {
				try {
					emitter.send(SseEmitter.event().name(memberId).data(sendMemberId));					
				}catch(IOException e){
					throw new RuntimeException(e);
				}
			}
		});
		
	}

}
