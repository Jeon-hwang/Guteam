package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MessageVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageService {
	// CRUD(Create, Read, Update, Delete)
	int create(MessageVO vo);
	MessageVO read(int messageId);
	List<MessageVO> read(String memberId, PageCriteria criteria);
	int getTotalCounts();
	int delete(int messageId);
}
