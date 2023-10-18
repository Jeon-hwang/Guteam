package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameService {
	// CRUD(Create, Read, Update, Delete)
	int create(GameVO vo);
	List<GameVO> read(PageCriteria criteria);
	GameVO read(int gameId);
	int update(GameVO vo);
	int getTotalCount();
	List<GameVO> read(int price, PageCriteria criteria);
	List<GameVO> read(String keyword, PageCriteria criteria);
}
