package project.spring.guteam.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public List<PurchasedVO> read(String memberId) {
		return null;
	}

}
