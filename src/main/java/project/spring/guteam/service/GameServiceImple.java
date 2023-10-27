package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.ReviewDAO;

@Service
public class GameServiceImple implements GameService {
	private static final Logger logger = LoggerFactory.getLogger(GameServiceImple.class);
	
	@Autowired
	private ReviewDAO reviewDAO;
	
	@Autowired
	private GameDAO gameDAO;
		
	@Override
	public int create(GameVO vo) {
		logger.info("game create() 호출 : vo = " + vo);
		return gameDAO.insert(vo);
	}

	@Override
	public Map<String, Object> read(PageCriteria criteria) {
		logger.info("game read() 호출 : criteria = " + criteria.toString());
		List<GameVO> gameVOList = gameDAO.select(criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		Map<String, Object> args = new HashMap<>();
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Override
	public Map<String, Object> read(int gameId) {
		logger.info("game read(gameId) 호출 : gameId = " + gameId);
		GameVO vo = gameDAO.select(gameId);
		int rating = reviewDAO.getRating(gameId);
		Map<String, Object> args = new HashMap<>();
		args.put("vo", vo);
		args.put("rating", rating);
		return args;
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
	public Map<String, Object> read(int price, PageCriteria criteria) {
		logger.info("game read(price) 호출");
		List<GameVO> gameVOList = gameDAO.selectByPrice(price, criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		Map<String, Object> args = new HashMap<>();
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Override
	public Map<String, Object> read(String keyword, PageCriteria criteria) {
		logger.info("game read(keyword) 호출");
		List<GameVO> gameVOList = gameDAO.selectByNameOrGenre(keyword, criteria);
		List<Integer> ratingList = new ArrayList<>();
		for(int i = 0 ; i < gameVOList.size(); i++) {
			ratingList.add(reviewDAO.getRating(gameVOList.get(i).getGameId()));
		}
		Map<String, Object> args = new HashMap<>();
		args.put("gameVOList", gameVOList);
		args.put("ratingList", ratingList);
		return args;
	}

	@Override
	public int getTotalCount(int price) {
		logger.info("getTotalCount(price) 호출 : price = " + price);
		return gameDAO.getTotalCounts(price);
	}

	@Override
	public int getSeqNo() {
		int sequence = gameDAO.getSequenceNo();
		return sequence;
	}

}