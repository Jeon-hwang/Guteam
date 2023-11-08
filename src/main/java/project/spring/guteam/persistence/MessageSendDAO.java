package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.MessageSendVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageSendDAO {
	
	// 메세지 등록
	int insert(MessageSendVO vo);
	
	// 메세지 상세보기
	MessageSendVO select(int sendMessageId);
	
	// 보낸 메세지 조회 - 페이징 리스트 데이터
	List<MessageSendVO> select(String sendMemberId, PageCriteria criteria);
	
	// 메시지 보관
	int update(String messageBox, int sendMessageId);
	
	// 메세지 삭제
	int delete(int sendMessageId);
	
	int getTotalCounts();
	
}
