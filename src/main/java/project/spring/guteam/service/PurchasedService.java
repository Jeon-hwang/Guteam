package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.PurchasedVO;

public interface PurchasedService {
	int create(PurchasedVO vo) throws Exception;
	List<PurchasedVO> read(String memberId);
	
}
