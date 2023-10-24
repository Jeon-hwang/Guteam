package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.pageutil.PageCriteria;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.WishListDAO;

@Service
public class WishListServiceImple implements WishListService {
private static final Logger logger = LoggerFactory.getLogger(WishListServiceImple.class);
	
	@Autowired 
	WishListDAO wishListDAO;
	
	@Autowired
	GameDAO gameDAO;
	
	@Override
	public int create(WishListVO vo) {
		logger.info("create() 실행");
		return wishListDAO.insert(vo);
	}
	
	@Transactional(value= "transactionManager")
	@Override
	public List<GameVO> read(String memberId, PageCriteria criteria) {
		logger.info("read() 실행");
		List<WishListVO> list = wishListDAO.select(memberId,criteria);
		List<GameVO> gList = new ArrayList<GameVO>();
		for(int i = 0 ; i<list.size();i++) {
			int gameId = list.get(i).getGameId();
			GameVO vo = gameDAO.select(gameId);
			gList.add(vo);
		}
		
		return gList; 
	}

	@Override
	public List<String> read(int gameId) {
		logger.info("read() 실행");
		return wishListDAO.select(gameId);
	}

	@Override
	public int delete(WishListVO vo) {
		logger.info("delete() 실행");
		return wishListDAO.delete(vo);
	}

	@Override
	public WishListVO find(String memberId, int gameId) {
		logger.info("find() 실행");
		WishListVO vo = wishListDAO.select(memberId, gameId);
		logger.info(vo.toString());
		return vo;
	}

}
