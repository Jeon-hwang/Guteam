package project.spring.guteam.service;

import java.util.List;
import java.util.Map;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameBoardService {
	int create(GameBoardVO vo);
	Map<String, Object> read(int gameId, PageCriteria criteria);
	Map<String, Object> read(int gameBoardId, String memberId);
	int update(GameBoardVO vo);
	int updateToDeleted(int gameBoardId);
	int getTotalCount(int gameId);
	int getTotalCount(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	Map<String, Object> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword);
	int update(int gameBoardId, int amount);
	Map<String, Object> read(int gameId, PageCriteria criteria, String orderBy);
	Map<String, Object> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword, String orderBy);
	List<GameBoardVO> readMyBoard(String memberId, PageCriteria criteria);
	int getCntMyBoard(String memberId);
}