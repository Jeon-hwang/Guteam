package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameBoardService {
	int create(GameBoardVO vo);
	List<GameBoardVO> read(int gameId, PageCriteria criteria);
	GameBoardVO read(int gameBoardId);
	int update(GameBoardVO vo);
	int update(int gameBoardId);
	int getTotalCount(int gameId);
	int getTotalCount(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	List<GameBoardVO> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	int update(int gameBoardId, int amount);
}