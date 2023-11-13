package project.spring.guteam.persistence;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.spring.guteam.domain.ThumbVO;

@Repository
public class ThumbDAOImple implements ThumbDAO{
	
	private static final Logger logger = LoggerFactory.getLogger(ThumbDAOImple.class);
	
	private static final String NAMESPACE = "project.spring.guteam.thumbMapper";
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insert(ThumbVO vo) {
		logger.info("Thumb insert() 호출 : vo = " + vo);
		return sqlSession.insert(NAMESPACE+".insert", vo);
	} // end insert()

	@Override
	public ThumbVO select(ThumbVO vo) {
		logger.info("Thumb select() 호출  : vo = " + vo);
		return sqlSession.selectOne(NAMESPACE + ".select", vo);
	} // end select()

	@Override
	public int delete(ThumbVO vo) {
		logger.info("Thumb delete() 호출 : vo = " + vo);
		return sqlSession.delete(NAMESPACE + ".delete", vo);
	} // end delete()

	@Override
	public int update(ThumbVO vo) {
		logger.info("Thumb update() 호출 : vo = " + vo);
		return sqlSession.update(NAMESPACE + ".update", vo);
	} // end update()

} // end ThumbDAOImple
