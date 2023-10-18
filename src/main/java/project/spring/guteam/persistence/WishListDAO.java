package project.spring.guteam.persistence;

import java.util.List;

import project.spring.guteam.domain.WishListVO;

public interface WishListDAO {
	int insert(WishListVO vo);
	List<WishListVO> select(String memberId);
	int delete(WishListVO vo);
}
