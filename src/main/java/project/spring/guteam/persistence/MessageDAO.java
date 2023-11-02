package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.MessageVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface MessageDAO {
	
	// 메세지 등록
	int insert(MessageVO vo);
	
	// 메세지 상세보기
	MessageVO select(int messageId);
	
	// 메세지 조회 - 페이징 리스트 데이터
	List<MessageVO> select(String receiveMemberId, PageCriteria criteria);
	
	int getTotalCounts();
	
	// 메세지 삭제
	int delete(int messageId);
	
}
