package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameDAO {
	int insert(GameVO vo);
	List<GameVO> select();
	GameVO select(int gameId);
	int update(GameVO vo);
	List<GameVO> select(PageCriteria criteria);
	int getTotalCounts();
	int getTotalCounts(String keyword);
	int getTotalCounts(int price);
	List<GameVO> selectByPrice(int price, PageCriteria criteria);
	List<GameVO> selectByNameOrGenre(String keyword, PageCriteria criteria);
	int getSequenceNo();
	List<GameVO> selectOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria);
	List<GameVO> selectInterest(String memberId);
	List<GameVO> selectInterestByKeyword(List<String> keywords, PageCriteria criteria);
	int getTotalCountsInterest(List<String>keywords);
}
