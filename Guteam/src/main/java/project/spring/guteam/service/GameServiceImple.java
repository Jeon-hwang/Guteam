package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameDAO;

@Service
public class GameServiceImple implements GameService {
	private static final Logger logger = LoggerFactory.getLogger(GameServiceImple.class);
	
	@Autowired
	private GameDAO gameDAO;
	
	
	@Override
	public int create(GameVO vo) {
		logger.info("game create() 호출 : vo = " + vo);
		return gameDAO.insert(vo);
	}

	@Override
	public List<GameVO> read(PageCriteria criteria) {
		logger.info("game read() 호출 : criteria = " + criteria.toString());
		return gameDAO.select(criteria);
	}

	@Override
	public GameVO read(int gameId) {
		logger.info("game read(gameId) 호출 : gameId = " + gameId);
		return gameDAO.select(gameId);
	}

	@Override
	public int update(GameVO vo) {
		logger.info("update() 호출 : vo = " + vo);
		return gameDAO.update(vo);
	}

	@Override
	public int getTotalCount() {
		logger.info("getTotalCount() 호출");
		return gameDAO.getTotalCounts();
	}

}
