package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.MessageReceiveDAO;

@Service // @Component
public class MessageReceiveServiceImple implements MessageReceiveService {
	private static final Logger logger = LoggerFactory.getLogger(MessageReceiveServiceImple.class);
	
	@Autowired
	private MessageReceiveDAO msgReceiveDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public int create(MessageReceiveVO vo) {
		logger.info("create() 호출 vo? " + vo.toString());
		vo.setReceiveMemberId((memberDAO.selectByNickname(vo.getReceiveMemberId())));
		return msgReceiveDAO.insert(vo);
	}
	
	@Override
	public MessageReceiveVO read(int receiveMessageId) {
		logger.info("read() 호출 msgId? " + receiveMessageId);
		return msgReceiveDAO.select(receiveMessageId);
	}

	@Override
	public List<MessageReceiveVO> read(String receiveMemberId, PageCriteria criteria) {
		logger.info("page-read() 호출");
		return msgReceiveDAO.select(receiveMemberId, criteria);
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
		return msgReceiveDAO.getTotalCounts();
	}

	@Override
	public int delete(int receiveMessageId) {
		logger.info("delete() 호출");
		return msgReceiveDAO.delete(receiveMessageId);
	}



}
