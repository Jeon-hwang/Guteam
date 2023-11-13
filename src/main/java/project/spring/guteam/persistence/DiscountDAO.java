package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.DiscountVO;

public interface DiscountDAO {
	int insert(DiscountVO vo);
	// 할인 정보 입력
	DiscountVO select(String genre);
	// 할인 정보 조회
	int update(DiscountVO vo);
	// 할인 정보 수정
	int delete(String genre);
	// 할인 정보 삭제
	List<DiscountVO> selectAll();
	// 할인 정보 전체 조회
} // end DiscountDAO
