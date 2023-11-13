package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.ViewedVO;

public interface ViewedDAO {
	int insert(ViewedVO vo);
	// 조회 정보 입력
	List<ViewedVO> selectToday(String memberId);
	// 조회 정보 조회
	int update(ViewedVO vo);
	// 조회 정보 수정
	ViewedVO selectOneToday(String memberId, int gameId);
	// 조회 정보 조회(오늘)

}
