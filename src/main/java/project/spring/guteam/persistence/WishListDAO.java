package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.WishListVO;
import project.spring.guteam.pageutil.PageCriteria;

public interface WishListDAO {
	int insert(WishListVO vo);
	List<WishListVO> select(String memberId);
	List<String> select(int gameId);
	WishListVO select(String memberId, int gameId);
	int delete(WishListVO vo);
	int deleteAll(String memberId);
}
