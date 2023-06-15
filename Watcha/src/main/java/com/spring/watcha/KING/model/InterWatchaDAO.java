package com.spring.watcha.KING.model;

import java.util.List;
import java.util.Map;

import com.spring.watcha.model.MovieVO;
import com.spring.watcha.model.user_collection_commentVO;

public interface InterWatchaDAO {

	// 영화 및 드라마 등 정보 가져오기 
  	MovieVO getMovieDetail(Map<String, String> paraMap);

    // 유저의 컬랙션 카드
	List<Map<String, String>> getCollection_view(Map<String, String> paraMap);

	
	// 더보기
	Map<String, String> totalCount(Map<String, String> paraMap);
	List<Map<String, String>> cardSeeMore(Map<String, String> paraMap);

	
	// 댓글쓰기 insert
	int addUserComment(user_collection_commentVO uccvo);

	// 페이징 처리하기
	List<Map<String, String>> uccListNoSearch(Map<String, String> paraMap);

	// 페이지바 토탈 페이지 알아보기
	int getUserCommentTotalPage(Map<String, String> paraMap);
	
	// 좋아요
	int getLikeSelect(Map<String, Object> paraMap);
	String getLikeInsertCollection(Map<String, Object> paraMap);
	String getLikeDeleteCollection(Map<String, Object> paraMap);

	// 컬렉션 영화 추가
	int getCollectionSelect(Map<String, Object> paraMap);
	String getCollectionAddDelete(Map<String, Object> paraMap);
	String getCollectionAddInsert(Map<String, Object> paraMap);

	// 컬렉션 값 유지
	int getMoviecollectionSelect(Map<String, String> paraMap);

	// 좋아요 총수
	int getLikeTotal(Map<String, Object> paraMap);

	// 좋아요 유지
	int getLikeMaintain(Map<String, String> paraMap);

	// 차트 1
	List<Map<String, String>> getWordcloud(Map<String, Object> paraMap);
	// 차트 2
	List<Map<String, String>> getPieBasic(Map<String, Object> paraMap);

	// 댓글 삭제
	int getDelUserComment(Map<String, Object> paraMap);

	// 댓글 수정
	int getUpdateComment(Map<String, Object> paraMap);

	// 한줄평 - 로그인한 회원이 해당 영화에 대해 작성한 한줄평 유무 및 한줄평 정보
	Map<String, String> reviewInfo(Map<String, String> paraMap);

	
		
		
}
