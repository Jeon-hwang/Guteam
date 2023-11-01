package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.MessageVO;

public interface MessageService {
	// CRUD(Create, Read, Update, Delete)
	int create(MessageVO vo);
	List<MessageVO> read(String memberId);
	int delete(int messageId);
}
