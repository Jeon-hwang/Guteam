package project.spring.guteam.persistence;

import project.spring.guteam.domain.ThumbVO;

public interface ThumbDAO {
	int insert(ThumbVO vo);
	ThumbVO select(ThumbVO vo);
	int delete(ThumbVO vo);
	int update(ThumbVO vo);
}
