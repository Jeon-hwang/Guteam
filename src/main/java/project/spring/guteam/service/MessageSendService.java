package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageSendService {
	// CRUD(Create, Read, Update, Delete)
	int create(MessageSendVO vo);
	MessageSendVO read(int sendMessageId);
	List<MessageSendVO> read(String sendMemberId, PageCriteria criteria);
//	List<MessageSendVO> read(String receiveMessageId, String sent, PageCriteria criteria);
	int getTotalCounts();
	int delete(int sendMessageId);
}
