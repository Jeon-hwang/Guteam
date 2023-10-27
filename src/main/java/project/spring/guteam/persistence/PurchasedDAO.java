package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.PurchasedVO;

public interface PurchasedDAO {
	int insert(PurchasedVO vo);
	List<PurchasedVO> select(String memberId);
	public PurchasedVO find(String memberId, int gameId);
}
