package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.MessageVO;

public interface MessageDAO {
	
	// 메세지 등록
	int insert(MessageVO vo);
	
	// 메세지 조회
	List<MessageVO> select(String memberId);
	
	// 메세지 삭제
	int delete(int messageId);
	
}
