package project.spring.guteam.persistence;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.DiscountVO;

@Repository
public class DiscountDAOImple implements DiscountDAO {
	private static final Logger logger = LoggerFactory.getLogger(DiscountDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.discountMapper";

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int insert(DiscountVO vo) {
		logger.info("discount insert() 호출 : vo = " + vo );
		return sqlSession.insert(NAMESPACE+".insert", vo);
	} // end insert()

	@Override
	public DiscountVO select(String genre) {
		logger.info("discount select() 호출 : genre = " + genre );
		return sqlSession.selectOne(NAMESPACE+".select", genre);
	} // end select()

	@Override
	public int update(DiscountVO vo) {
		logger.info("discount update() 호출 : vo = " + vo );
		return sqlSession.update(NAMESPACE+".update", vo);
	} // end update()

	@Override
	public int delete(String genre) {
		logger.info("discount delete() 호출 : vo = " + genre );
		return sqlSession.delete(NAMESPACE+".delete", genre);
	} // end delete()

	@Override
	public List<DiscountVO> selectAll() {
		logger.info("discount selectAll() 호출");
		return sqlSession.selectList(NAMESPACE+".select_all");
	} // end selectAll()

} // end DiscountDAOImple
