package project.spring.guteam.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.PurchasedVO;
import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.persistence.GameDAO;
import project.spring.guteam.persistence.MemberDAO;
import project.spring.guteam.persistence.PurchasedDAO;
import project.spring.guteam.persistence.WishListDAO;

@Service
public class PurchasedServiceImple implements PurchasedService {
	private static final Logger logger = LoggerFactory.getLogger(PurchasedServiceImple.class);
	
	@Autowired
	private WishListDAO wishListDAO;
	
	@Autowired
	private MemberDAO memberDAO;
		
	@Autowired 
	private PurchasedDAO purchasedDAO;	
	
	@Autowired
	private GameDAO gameDAO;
	
	
	@Override
	@Transactional(value = "transactionManager")
	public int create(PurchasedVO vo,int price) throws Exception{
		logger.info("create 생성");
		int result = 0;
		WishListVO wishVO = new WishListVO(vo.getMemberId(), vo.getGameId());
		int cash = getCash(vo.getMemberId())-price;
		if(purchasedDAO.find(vo.getMemberId(), vo.getGameId())==null) {
			if(cash>=0) {
				result = purchasedDAO.insert(vo);
				memberDAO.updateCash(cash, vo.getMemberId()); //캐쉬 업데이트
				wishListDAO.delete(wishVO);
			}else {
				result=0;
			}
		
		}else {
			//게임이 이미 존재하는 경우
			result =2;
		}
		 // 위시리스트에서 삭제
		/* 현재문제점 결제를 이중으로하면 캐쉬가 나중걸로 반영되어버린다 컨트롤러에서 계사하는게 맞는듯...*/
		return result;
	}
	
	public Map<String, Object> readBuyGame(String gameIds,String memberId){
		String[] StrArr = gameIds.split(",");
		List<GameVO> list = new ArrayList<GameVO>();
		for(String x : StrArr) {
			logger.info(x);
			GameVO vo = (GameVO) gameDAO.select(Integer.parseInt(x));
			list.add(vo);
		}
		int cash = memberDAO.select(memberId).getCash();
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("list", list);
		args.put("cash", cash);
		return args;
	}
	
	public int getCash(String memberId) {
		return memberDAO.select(memberId).getCash();
	}
	
	@Override
	@Transactional(value = "transactionManager")
	public List<GameVO> readGame(String memberId) {
		logger.info("read service 실행");
		List<PurchasedVO> list = purchasedDAO.select(memberId);
		List<GameVO> gameList = new ArrayList<GameVO>();
		for(int i=0;i<list.size();i++) {
			GameVO gameVO = (GameVO) gameDAO.select(list.get(i).getGameId());
			gameList.add(gameVO);
		}		
		return gameList;
	}

	@Override
	public List<PurchasedVO> read(String memberId) {
		logger.info("read service 실행");
		return purchasedDAO.select(memberId);
	}

	@Override
	public PurchasedVO find(String memeberId, int gameId) {
		logger.info("find 실행");
		return purchasedDAO.find(memeberId, gameId);
	}

	@Transactional(value = "transactionManager")
	@Override
	public Map<String, Object> findFriends(String memberId, int gameId) {
		logger.info("findFriends 실행");
		List<String> friendIdList = purchasedDAO.findFriends(memberId, gameId); // 게임을 가지고있는 친구 id만 List로 나온다
		List<String> imageNameList = new ArrayList<String>();
		for(int i = 0; i<friendIdList.size();i++) { 
			String friendId = friendIdList.get(i);
			String imageName = memberDAO.select(friendId).getMemberImageName();
			imageNameList.add(imageName);
		}
		Map<String, Object> args = new HashMap<String, Object>();
		args.put("imageNameList", imageNameList);
		args.put("friendIdList", friendIdList);
		return args;
	}

}
