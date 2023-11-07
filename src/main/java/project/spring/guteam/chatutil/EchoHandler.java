package project.spring.guteam.chatutil;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import project.spring.guteam.service.MemberService;

public class EchoHandler extends TextWebSocketHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	private List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Autowired
	private MemberService memberService;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		String memberId = session.getPrincipal().getName();
		String nickname = memberService.read(memberId).getNickname();
		for(WebSocketSession sess: sessionList) {
		sess.sendMessage(new TextMessage(nickname + " 님이 입장하셨습니다"));
		}
	}
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		for(WebSocketSession sess: sessionList) {
			String memberId = session.getPrincipal().getName();
			logger.info(memberId);
			String nickname = memberService.read(memberId).getNickname();
			sess.sendMessage(new TextMessage(nickname+": "+message.getPayload()));
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String memberId = session.getPrincipal().getName();
		String nickname = memberService.read(memberId).getNickname();
		sessionList.remove(session);
		for(WebSocketSession sess: sessionList) {
			sess.sendMessage(new TextMessage(nickname + " 님이 퇴장하셨습니다"));
		}
	}

}
