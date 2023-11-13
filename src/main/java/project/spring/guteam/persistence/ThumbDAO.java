package project.spring.guteam.persistence;

import project.spring.guteam.domain.ThumbVO;

public interface ThumbDAO {
	int insert(ThumbVO vo);
	// 추천 정보 입력
	ThumbVO select(ThumbVO vo);
	// 추천 정보 조회
	int delete(ThumbVO vo);
	// 추천 정보 삭제
	int update(ThumbVO vo);
	// 추천 정보 수정
} // end ThumbDAO
