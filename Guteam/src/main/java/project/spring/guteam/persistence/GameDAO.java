package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameDAO {
	int insert(GameVO vo);
	List<GameVO> select();
	GameVO select(int gameId);
	int update(GameVO vo);
	int delete(int gameId);
	List<GameVO> select(PageCriteria criteria);
	int getTotalCounts();
	List<GameVO> selectByPrice(int price);
	List<GameVO> selectByNameOrGenre(String keyword);
}
