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
		// 소켓 접속시
		sessionList.add(session);
		// 리스트에 추가하고
		String memberId = session.getPrincipal().getName();
		String nickname = memberService.read(memberId).getNickname();
		logger.info(session.getLocalAddress().getAddress()+" : nickname = " + nickname);
		for(WebSocketSession sess: sessionList) { // 입장 안내 문구를 채팅창에 보여줌
			sess.sendMessage(new TextMessage(nickname + " 님이 입장하셨습니다"));
		}
	} // end afterConnectionEstablished() 
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 메시지 전송시
		for(WebSocketSession sess: sessionList) { // 메시지를 채팅창에 보여줌
			String memberId = session.getPrincipal().getName();
			String nickname = memberService.read(memberId).getNickname();
			if(sess.equals(session)) {
				sess.sendMessage(new TextMessage("<span class='myChat'><div class='chatInfo'><div class='nickname'>"+nickname+"</div><div class='message'>"+message.getPayload()+"</div>"));
			}else {
				sess.sendMessage(new TextMessage("<span class='yourChat'><div class='chatInfo'><div class='nickname'>"+nickname+"</div><div class='message'>"+message.getPayload()+"</div>"));
			}
		}
	} // end handleTextMessage
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 접속 해제시 
		String memberId = session.getPrincipal().getName();
		String nickname = memberService.read(memberId).getNickname();
		sessionList.remove(session);
		// 접속을 해제시키고
		for(WebSocketSession sess: sessionList) {
			// 퇴장 안내 문구를 나머지 채팅창에 보여줌
			sess.sendMessage(new TextMessage(nickname + " 님이 퇴장하셨습니다"));
		}
	} // end afterConnectionClosed

} // end EchoHandler
