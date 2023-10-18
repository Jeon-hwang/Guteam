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
		logger.info("game update() 호출 : vo = " + vo);
		return gameDAO.update(vo);
	}

	@Override
	public int getTotalCount() {
		logger.info("game getTotalCount() 호출");
		return gameDAO.getTotalCounts();
	}

	@Override
	public int getTotalCount(String keyword) {
		logger.info("getTotalCount(keyword) 호출 : keyword = " + keyword);
		return gameDAO.getTotalCounts(keyword);
	}
	
	@Override
	public List<GameVO> read(int price, PageCriteria criteria) {
		logger.info("game read(price) 호출");
		return gameDAO.selectByPrice(price, criteria);
	}

	@Override
	public List<GameVO> read(String keyword, PageCriteria criteria) {
		logger.info("game read(keyword) 호출");
		return gameDAO.selectByNameOrGenre(keyword, criteria);
	}

	@Override
	public int getTotalCount(int price) {
		logger.info("getTotalCount(price) 호출 : price = " + price);
		return gameDAO.getTotalCounts(price);
	}

}