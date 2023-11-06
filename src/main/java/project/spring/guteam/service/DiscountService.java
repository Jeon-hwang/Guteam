package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.DiscountVO;

public interface DiscountService {

	List<String> readAllGenre();

	int update(DiscountVO vo);

	List<DiscountVO> read();

	int delete(String genre);

}
