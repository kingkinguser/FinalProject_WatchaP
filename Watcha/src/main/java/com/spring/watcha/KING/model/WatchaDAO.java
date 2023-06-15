package com.spring.watcha.KING.model;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.collection_likeVO;
import com.spring.watcha.model.user_collection_commentVO;


@Component
@Repository
public class WatchaDAO implements InterWatchaDAO {
	
		@Resource
		private SqlSessionTemplate sqlsession ;

	   // 영화 정보 가져오기 	
	   @Override
	   public MovieVO getMovieDetail(Map<String, String> paraMap) {
	      MovieVO movie = sqlsession.selectOne("watcha.getMovieDetails", paraMap); 
	      
	      return movie;
	   }
	
	    // 유저의 컬랙션 카드
		@Override
		public List<Map<String, String>> getCollection_view(Map<String, String> paraMap) {

			List<Map<String, String>> collection_viewList = sqlsession.selectList("watcha.getCollection_view", paraMap); 
			
			return collection_viewList;
			
		}

		
		// 더보기
		@Override
		public Map<String, String> totalCount(Map<String, String> paraMap) {
			
			Map<String, String> totalCount = sqlsession.selectOne("watcha.totalCount", paraMap); 
			
			return totalCount;
		}
		@Override
		public List<Map<String, String>> cardSeeMore(Map<String, String> paraMap) {
			
			List<Map<String, String>> cardSeeMore = sqlsession.selectList("watcha.cardSeeMore", paraMap); 
			
			return cardSeeMore;
		}

		 
		// 댓글쓰기 insert
		@Override
		public int addUserComment(user_collection_commentVO uccvo) {
			
			int n = sqlsession.insert("watcha.addUserComment", uccvo);
			return n;
		}

		// 페이징 처리하기
		@Override
		public List<Map<String, String>> uccListNoSearch(Map<String, String> paraMap) {
			List<Map<String, String>> uccList = sqlsession.selectList("watcha.uccListNoSearchWithPaging", paraMap);
			return uccList;
		}

		// 페이지바 토탈 페이지 알아보기
		@Override
		public int getUserCommentTotalPage(Map<String, String> paraMap) {
			
			int totalPage = sqlsession.selectOne("watcha.getUserCommentTotalPage", paraMap);
			return totalPage;
		}
		
		// 좋아요
		@Override
		public int getLikeSelect(Map<String, Object> paraMap) {
			int n = sqlsession.selectOne("watcha.getLikeSelect", paraMap);
			return n;
		}
		@Override
		public String getLikeInsertCollection(Map<String, Object> paraMap) {
			
			String likeCollection = sqlsession.selectOne("watcha.getLikeInsertCollection", paraMap);
			return likeCollection;
		}
		@Override
		public String getLikeDeleteCollection(Map<String, Object> paraMap) {
			String likeCollection = sqlsession.selectOne("watcha.getLikeDeleteCollection", paraMap);
			return likeCollection;
		}

		// 컬렉션 영화 추가
		@Override
		public int getCollectionSelect(Map<String, Object> paraMap) {
			int n = sqlsession.selectOne("watcha.getCollectionSelect", paraMap);
			return n;
		}
		@Override
		public String getCollectionAddDelete(Map<String, Object> paraMap) {
			String collectionAdd = sqlsession.selectOne("watcha.getCollectionAddDelete", paraMap);
			return collectionAdd;
		}
		@Override
		public String getCollectionAddInsert(Map<String, Object> paraMap) {
			String collectionAdd = sqlsession.selectOne("watcha.getCollectionAddInsert", paraMap);
			return collectionAdd;
		}

		// 컬렉션 값
		@Override
		public int getMoviecollectionSelect(Map<String, String> paraMap) {
			int n = sqlsession.selectOne("watcha.getMoviecollectionSelect", paraMap);
			return n; 
		}

		// 좋아요 총수
		@Override
		public int getLikeTotal(Map<String, Object> paraMap) {
			int n = sqlsession.selectOne("watcha.getLikeTotal", paraMap);
			return n;
		}

		// 좋아요 유지 
		@Override
		public int getLikeMaintain(Map<String, String> paraMap) {
			int n = sqlsession.selectOne("watcha.getLikeMaintain", paraMap);
			return n;
		}
		
		// 차트 1
		@Override
		public List<Map<String, String>> getWordcloud(Map<String, Object> paraMap) {
			List<Map<String, String>> wordcloud = sqlsession.selectList("watcha.getWordcloud", paraMap);
			return wordcloud;
		}
		
		// 차트 2
		@Override
		public List<Map<String, String>> getPieBasic(Map<String, Object> paraMap) {
			List<Map<String, String>> pieBasic = sqlsession.selectList("watcha.getPieBasic", paraMap);
			return pieBasic;
		}

		// 댓글 삭제
		@Override
		public int getDelUserComment(Map<String, Object> paraMap) {
			int n = sqlsession.delete("watcha.getDelUserComment", paraMap);
			return n;
			 
		}

		// 댓글 수정
		@Override
		public int getUpdateComment(Map<String, Object> paraMap) {
			int n = sqlsession.update("watcha.getUpdateComment", paraMap);
			return n;
		}

	   // 한줄평 - 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
	   @Override
	   public Map<String, String> reviewInfo(Map<String, String> paraMap) {
	      Map<String, String> reviewInfo = sqlsession.selectOne("watcha.reviewInfo", paraMap);
	      return reviewInfo;
	   }
		
		
}
