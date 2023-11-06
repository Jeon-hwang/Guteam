package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.DiscountVO;

public interface DiscountDAO {
	int insert(DiscountVO vo);
	DiscountVO select(String genre);
	int update(DiscountVO vo);
	int delete(String genre);
	List<DiscountVO> selectAll();
}
