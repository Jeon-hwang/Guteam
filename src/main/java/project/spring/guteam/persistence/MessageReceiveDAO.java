package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.MessageReceiveVO;
import project.spring.guteam.domain.MessageSaveVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageReceiveDAO {
	
	// 메세지 등록
	int insert(MessageReceiveVO vo);
	
	// 메세지 상세보기
	MessageReceiveVO select(int receiveMessageId);
	
	// 받은 메세지 조회 - 페이징 리스트 데이터
	List<MessageReceiveVO> select(String receiveMemberId, PageCriteria criteria);
	
	// 받은 메시지 조회 (보관)
	List<MessageSaveVO> selectSaved(String memberId, PageCriteria criteria);
	
	// 메시지 보관
	int update(String messageBox, int receiveMessageId);
	
	// 메세지 삭제
	int delete(int receiveMessageId);
	
	// 받은 메세지 총 갯수
	int getReceiveCounts(String receiveMemberId);
	
	// 보관 메세지 총 갯수
	int getBoxCounts(String memberId);
	
	
}
