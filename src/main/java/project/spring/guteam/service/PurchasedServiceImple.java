package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;
import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.persistence.PurchasedDAO;

@Service
public class PurchasedServiceImple implements PurchasedService {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedServiceImple.class);
	
	@Autowired
	private WishListService wishListService;
	
	@Autowired 
	private PurchasedDAO dao;	
	
	@Autowired
	private GameService gameService;
	
	@Override
	@Transactional(value = "transactionManager")
	public int create(PurchasedVO vo) throws Exception{
		logger.info("create 생성");
		dao.insert(vo);
		WishListVO wishVO = new WishListVO(vo.getMemberId(), vo.getGameId());
		wishListService.delete(wishVO);
		return 1;
	}

	@Override
	@Transactional(value = "transactionManager")
	public List<GameVO> readGame(String memberId) {
		logger.info("read service 실행");
		List<PurchasedVO> list = dao.select(memberId);
		List<GameVO> gameList = new ArrayList<GameVO>();
		for(int i=0;i<list.size();i++) {
			GameVO gameVO = gameService.read(list.get(i).getGameId());
			gameList.add(gameVO);
		}
		return gameList;
	}

	@Override
	public List<PurchasedVO> read(String memberId) {
		logger.info("read service 실행");
		return dao.select(memberId);
	}

	@Override
	public PurchasedVO find(String memeberId, int gameId) {
		logger.info("find 실행");
		return dao.find(memeberId, gameId);
	}

}
