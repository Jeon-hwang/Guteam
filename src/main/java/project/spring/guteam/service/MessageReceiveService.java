package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageReceiveService {
	// CRUD(Create, Read, Update, Delete)
	int create(MessageReceiveVO vo);
	MessageReceiveVO read(int receiveMessageId);
	List<MessageReceiveVO> read(String receiveMemberId, PageCriteria criteria);
//	List<MessageReceiveVO> read(String receiveMessageId, String sent, PageCriteria criteria);
	int getTotalCounts();
	int delete(int receiveMessageId);
}
