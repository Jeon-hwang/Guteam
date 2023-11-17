package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.domain.MessageSaveVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.MessageReceiveDAO;
import project.spring.guteam.persistence.MessageSendDAO;

@Service // @Component
public class MessageServiceImple implements MessageService {
	private static final Logger logger = LoggerFactory.getLogger(MessageServiceImple.class);
	
	@Autowired
	private MessageSendDAO msgSendDAO;
	
	@Autowired
	private MessageReceiveDAO msgReceiveDAO;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Transactional(value = "transactionManager")
	@Override
	public int create(MessageSendVO svo) {
		logger.info("create() 호출 vo? " + svo.toString());
		svo.setReceiveMemberId((memberDAO.selectByNickname(svo.getReceiveMemberNickname())));
		logger.info("vo.setReceiveMemberId = " + svo.getReceiveMemberId());
		
		int result = msgSendDAO.insert(svo);
		if(result == 1) {
			logger.info("send-insert 성공");
			MessageReceiveVO rvo = new MessageReceiveVO();
			rvo.setReceiveMemberId(svo.getReceiveMemberId());
			rvo.setSendMemberId(svo.getSendMemberId());
			rvo.setSendMemberNickname(memberDAO.selectByMemberId(svo.getSendMemberId()));
			rvo.setMessageTitle(svo.getMessageTitle());
			rvo.setMessageContent(svo.getMessageContent());
			logger.info("rvo 잘 들어갔나 " + rvo.toString());
			
			result = msgReceiveDAO.insert(rvo);
			if(result == 1) {
				logger.info("receive-insert 성공");
			} else {
				logger.info("receive-insert 실패");
			}
			
		} else {
			logger.info("send-insert 실패");
		}
		
		return result;
	}
	
	@Override
	public MessageSendVO readBySend(int sendMessageId) {
		logger.info("readBySend() 호출 msgId? " + sendMessageId);
		return msgSendDAO.select(sendMessageId);
	}
	
	@Override
	public MessageReceiveVO readByReceive(int receiveMessageId) {
		logger.info("readByReceive() 호출 msgId? " + receiveMessageId);
		return msgReceiveDAO.select(receiveMessageId);
	}

	@Override
	public List<MessageSendVO> readSendList(String sendMemberId, PageCriteria criteria) {
		logger.info("readSendList() 호출");
			return msgSendDAO.select(sendMemberId, criteria);
	}
	
	@Override
	public List<MessageReceiveVO> readReceiveList(String receiveMemberId, PageCriteria criteria) {
		logger.info("readReceiveList() 호출");
			return msgReceiveDAO.select(receiveMemberId, criteria);
	}
	
	@Override
	public List<MessageSaveVO> readSavedList(String memberId, PageCriteria criteria) {
		logger.info("readSavedList() 호출");
		return msgReceiveDAO.selectSaved(memberId, criteria);
	}
	
	@Override
	public int getReceiveCounts(String receiveMemberId) {
		logger.info("getReceiveCounts() 호출");
		return msgReceiveDAO.getReceiveCounts(receiveMemberId);
	}
	
	@Override
	public int updateBox(String messageBox, int messageId, String check) {
		logger.info("updateBox(보관) 호출");
		if(check == "send") {
			return msgSendDAO.update(messageBox, messageId);
		} else  {
			logger.info("msgReceiveDAO.update로");
			return msgReceiveDAO.update(messageBox, messageId);			
		}
	}

	@Override
	public int deleteBySend(int sendMessageId) {
		logger.info("deleteBySend() 호출");
		return msgSendDAO.delete(sendMessageId);
	}
	
	@Override
	public int deleteByReceive(int receiveMessageId) {
		logger.info("deleteByReceive() 호출");
		return msgReceiveDAO.delete(receiveMessageId);
	}

	@Override
	public int getSentCounts(String SendMemberId) {
		logger.info("getSentCounts() 호출");
		return msgSendDAO.getSentCounts(SendMemberId);
	}

	@Override
	public int getBoxCounts(String memberId) {
		logger.info("getBoxCounts() 호출");
		return msgReceiveDAO.getBoxCounts(memberId);
	}



}
