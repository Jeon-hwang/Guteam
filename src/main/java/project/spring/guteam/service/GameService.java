package project.spring.guteam.service;

import java.security.Principal;
import java.util.Map;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameService {
	// CRUD(Create, Read, Update, Delete)
	int create(GameVO vo);
	Map<String, Object> read(PageCriteria criteria);
	Map<String, Object> read(int gameId, Principal principal);
	int update(GameVO vo);
	int getTotalCount();
	int getTotalCount(int price);
	Map<String, Object> read(int price, PageCriteria criteria);
	Map<String, Object> read(String keyword, PageCriteria criteria);
	int getTotalCount(String keyword);
	int getSeqNo();
	Map<String, Object> read(String keyword, String keywordCriteria, String orderBy, PageCriteria criteria);
	Map<String, Object> recentlyViewedGames(String memberId);
	int getTotalCountInterest(String memberId);
	Map<String, Object> getInterestGames(String memberId, PageCriteria criteria);
}