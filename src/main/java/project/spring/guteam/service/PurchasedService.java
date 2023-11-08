package project.spring.guteam.service;

import java.util.List;
import java.util.Map;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;

public interface PurchasedService {
	int create(PurchasedVO vo,int cash) throws Exception;
	List<GameVO> readGame(String memberId);
	Map<String, Object> readBuyGame(String gameIds,String memberId);
	int getCash(String memberId);
	List<PurchasedVO> read(String memberId);
	PurchasedVO find(String memeberId, int gameId);
	Map<String, Object> findFriends(String memberId, int gameId);
	int updateCash(String memberId,int cash);
}
