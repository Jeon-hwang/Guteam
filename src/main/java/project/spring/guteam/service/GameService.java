package project.spring.guteam.service;

import java.util.Map;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameService {
	// CRUD(Create, Read, Update, Delete)
	int create(GameVO vo);
	Map<String, Object> read(PageCriteria criteria);
	Map<String, Object> read(int gameId);
	int update(GameVO vo);
	int getTotalCount();
	int getTotalCount(int price);
	Map<String, Object> read(int price, PageCriteria criteria);
	Map<String, Object> read(String keyword, PageCriteria criteria);
	int getTotalCount(String keyword);
	int getSeqNo();
}