package project.spring.guteam.service;

import java.util.List;

import project.spring.guteam.domain.GameVO;
import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface WishListService {
	int create(WishListVO vo);
	List<GameVO> read(String memberId, PageCriteria criteria);
	List<String> read(int gameId);
	int delete(WishListVO vo);
	WishListVO find(String memberId, int gameId);
}
