package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.MessageSendDAO;

@Service // @Component
public class MessageSendServiceImple implements MessageSendService {
	private static final Logger logger = LoggerFactory.getLogger(MessageSendServiceImple.class);
	
	@Autowired
	private MessageSendDAO msgSendDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int create(MessageSendVO vo) {
		logger.info("create() 호출 vo? " + vo.toString());
		vo.setReceiveMemberId((memberDAO.selectByNickname(vo.getReceiveMemberId())));
		return msgSendDAO.insert(vo);
	}
	
	@Override
	public MessageSendVO read(int sendMessageId) {
		logger.info("read() 호출 msgId? " + sendMessageId);
		return msgSendDAO.select(sendMessageId);
	}

	@Override
	public List<MessageSendVO> read(String sendMemberId, PageCriteria criteria) {
		logger.info("page-read() 호출");
		return msgSendDAO.select(sendMemberId, criteria);
	}
	
//	@Override
//	public List<ReceiveMessageVO> read(String memberId, String sent, PageCriteria criteria) {
//		logger.info("page-read(me) 호출");
//		List<ReceiveMessageVO> list = dao.selectTo(memberId, criteria);
//		for(ReceiveMessageVO vo : list) {
//			vo.setReceiveMemberId(memberDAO.selectByMemberId(vo.getReceiveMemberId()));// 받은 사람 memberId를 닉넴으로 바꿔주기
//		}
//		return list;
//	}
	
	@Override
	public int getTotalCounts() {
		logger.info("getTotalCount() 호출");
		return msgSendDAO.getTotalCounts();
	}

	@Override
	public int delete(int sendMessageId) {
		logger.info("delete() 호출");
		return msgSendDAO.delete(sendMessageId);
	}



}
