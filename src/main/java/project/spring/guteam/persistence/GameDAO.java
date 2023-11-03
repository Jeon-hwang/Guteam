package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameDAO {
	int insert(GameVO vo);
	GameVO select(int gameId);
	int update(GameVO vo);
	List<GameVO> selectAll(PageCriteria criteria);
	int getTotalCounts();
	int getTotalCounts(String keyword);
	int getTotalCounts(int price);
	List<GameVO> selectByPrice(int price, PageCriteria criteria);
	List<GameVO> selectByNameOrGenre(String keyword, PageCriteria criteria);
	int getSequenceNo();
	List<GameVO> selectOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria);
	List<GameVO> selectInterestGames(String memberId);
	List<GameVO> selectByInterest(List<String> keywords, PageCriteria criteria);
}
