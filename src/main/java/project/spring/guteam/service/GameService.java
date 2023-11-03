package project.spring.guteam.service;

import java.security.Principal;
import java.util.Map;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameService {
	// CRUD(Create, Read, Update, Delete)
	int create(GameVO vo);
	Map<String, Object> readAll(PageCriteria criteria);
	Map<String, Object> readGame(int gameId, Principal principal);
	int update(GameVO vo);
	int getTotalCount();
	int getTotalCountByPrice(int price);
	Map<String, Object> readByPrice(int price, PageCriteria criteria);
	Map<String, Object> readByKeyword(String keyword, PageCriteria criteria);
	int getTotalCountByKeyword(String keyword);
	int getSeqNo();
	Map<String, Object> readOrderBy(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria);
	Map<String, Object> recentlyViewedGames(String memberId);
	Map<String, Object> readInterestGames(String memberId, PageCriteria criteria);
	int getInterestKeywordCnt(String memberId);
}