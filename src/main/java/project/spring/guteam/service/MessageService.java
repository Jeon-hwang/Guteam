package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.domain.MessageSaveVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageService {
	// CRUD(Create, Read, Update, Delete)
	int create(MessageSendVO vo);
	MessageSendVO readBySend(int sendMessageId);
	MessageReceiveVO readByReceive(int receiveMessageId);
	List<MessageSendVO> readSendList(String sendMemberId, PageCriteria criteria);
	List<MessageReceiveVO> readReceiveList(String receiveMemberId, PageCriteria criteria);
	List<MessageSaveVO> readSavedList(String memberId, PageCriteria criteria);
	int updateBox(String messageBox, int messageId, String check);
	int deleteBySend(int sendMessageId);
	int deleteByReceive(int receiveMessageId);
	
	int getTotalCounts();
}
