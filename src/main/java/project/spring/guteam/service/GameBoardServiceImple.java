package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.GameBoardVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameBoardDAO;

@Service
public class GameBoardServiceImple implements GameBoardService {
	private static Logger logger = LoggerFactory.getLogger(GameBoardServiceImple.class);
	
	@Autowired
	private GameBoardDAO gameBoardDAO;
	
	@Override
	public int create(GameBoardVO vo) {
		logger.info("gameBoard create() 호출 : vo = " + vo);
		return gameBoardDAO.insert(vo);
	}

	@Override
	public List<GameBoardVO> read(int gameId, PageCriteria criteria) {
		logger.info("gameBoard read() 호출 : gameId = " + gameId);
		return gameBoardDAO.select(gameId, criteria);
	}

	@Override
	public int update(GameBoardVO vo) {
		logger.info("gameBoard update() 호출 : vo = " + vo );
		return gameBoardDAO.update(vo);
	}

	@Override
	public int update(int gameBoardId) {
		logger.info("gameBoard update(gameBoardId) 호출 : gameBoardId = " + gameBoardId);
		return gameBoardDAO.updateDeleted(gameBoardId);
	}

	@Override
	public int getTotalCount(int gameId) {
		logger.info("gameBoard getTotalCount() 호출 ");
		return gameBoardDAO.getTotalCounts(gameId);
	}

	@Override
	public List<GameBoardVO> read(int gameId, PageCriteria criteria, String keywordCriteria, String keyword) {
		logger.info("gameBoard read(keyword) 호출 : keywordCriteria = " + keywordCriteria + ",keyword = " + keyword);
		if(keywordCriteria!=null&&keywordCriteria.equals("memberId")) {
			return gameBoardDAO.selectByMemberId(gameId, keyword, criteria);
		}else {
			return gameBoardDAO.selectByKeyword(gameId, keyword, criteria);
		}
	}

	@Override
	public GameBoardVO read(int gameBoardId) {
		logger.info("gameBoard read(gameBoardId) 호출 : gameBoardId = " + gameBoardId);
		return gameBoardDAO.selectByBoardId(gameBoardId);
	}

	@Override
	public int update(int gameBoardId, int amount) {
		logger.info("gameBoard updateCommentCnt() 호출");
		return gameBoardDAO.updateCommentCnt(gameBoardId, amount);
	}

	@Override
	public int getTotalCount(int gameId, PageCriteria criteria, String keywordCriteria, String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameBoardDAO.getTotalCounts(gameId, criteria, keywordCriteria, keyword);
	}

}
