package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface GameBoardDAO {
	int insert(GameBoardVO vo);
	List<GameBoardVO> select(int gameId, PageCriteria criteria);
	GameBoardVO selectByBoardId(int gameBoardId);
	int update(GameBoardVO vo);
	int delete(int gameBoardId);
	int getTotalCounts(int gameId);
	int getTotalCounts(int gameId, String keywordCriteria, String keyword);
	List<GameBoardVO> selectByMemberId(int gameId, String memberId);
	List<GameBoardVO> selectByKeyword(int gameId, String keyword);
	int updateCommentCnt(int gameBoardId, int amount);
	int updateDeleted(int gameBoardId);
}
