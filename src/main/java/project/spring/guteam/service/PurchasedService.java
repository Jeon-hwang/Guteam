package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;

public interface PurchasedService {
	int create(PurchasedVO vo) throws Exception;
	List<GameVO> readGame(String memberId);
	List<PurchasedVO> read(String memberId);
	PurchasedVO find(String memeberId, int gameId);
}
