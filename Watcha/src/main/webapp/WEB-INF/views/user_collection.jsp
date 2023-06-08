<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<%
    String ctxPath = request.getContextPath();
%>     
    
<!DOCTYPE html>
<html>

<head>

<style type="text/css">

	body {
		border: solid 0px gray;
		word-break: break-all; 
		padding: 0;           
	}	

	div#container{
		border: solid 0px purple;
		width: 70%;
		margin: 20px auto; 
	}

	.profile {
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    
	}
			
	/*버튼 시작*/		
	.btnP{
	  background: white;
	  color: black;
	  border:none;
	  position:relative;
	  height:50px;
	  font-size: 15px;
	  cursor:pointer;
	  transition:800ms ease all;
	  outline:none;
	}
	.btnP:hover{
	  background:#fff;
	  color: #f3578d;
	}
	.btnP:before,.btnP:after{
	  content:'';
	  position:absolute;
	  top:0;
	  right:0;
	  height:2px;
	  width:0;
	  background: #f3578d;
	  transition:400ms ease all;
	}
	.btnP:after{
	  right:inherit;
	  top:inherit;
	  left:0;
	  bottom:0;
	}
	.btnP:hover:before,.btnP:hover:after{
	  width:100%;
	  transition:800ms ease all;
	}
	/*버튼 끝*/		
		
	.commentP {
	  width: 700px;
	  height: 35px;
	  font-size: 15px;
	  border: 0;
	  border-radius: 15px;
	  outline: none;
	  padding-left: 10px;
	  background-color: rgb(233, 233, 233);
	}	
	
	/* 출연,제작 시작 */ 
	@media (max-width: 768px) {
	    .carousel-inner .carousel-item > div {
	        display: none;
	    }
	    .carousel-inner .carousel-item > div:first-child {
	        display: block;
	    }
	}
	
	.carousel-inner .carousel-item.active,
	.carousel-inner .carousel-item-next,
	.carousel-inner .carousel-item-prev {
	    display: flex;
	}
	
	/* display 3 */
	@media (min-width: 768px) {
	    
	    .carousel-inner .carousel-item-right.active,
	    .carousel-inner .carousel-item-next {
	      transform: translateX(33.333%);
	    }
	    
	    .carousel-inner .carousel-item-left.active, 
	    .carousel-inner .carousel-item-prev {
	      transform: translateX(-33.333%);
	    }
	}
	
	.carousel-inner .carousel-item-right,
	.carousel-inner .carousel-item-left{ 
	  transform: translateX(0);
	}
	/* 출연,제작 끝 */
	
	input[type="checkbox"] { 
	   opacity: 0;
	}
	
	.btn:active, .btn:focus {
		outline:none !important;
		box-shadow:none !important;
	}
	
	#commentBack{
	  width: 700px;
	  font-size: 15px;
	  border: 0;
	  border-radius: 15px;
	  outline: none;
	  background-color: rgb(233, 233, 233);
	  margin: -25px 0 0 140px;
	}
	
	img#middle {
		 background-repeat: no-repeat;
		 background-size:cover;  
		 background-position: center center; 
		 height: 350px;
  	     width: 100%; 
  	     background-blend-mode: multiply;
  	     border-radius: 10px 10px;
  	     opacity: 0.4;
	} 
	
	#commentInfo{
	  width: 49%;
	  height: 300px;
	  border: solid 1px #eee;
	  border-radius: 15px;
	  float: left;
	  margin: 10px 0 10px 0;
	}
	
	#chart{ 
	  width: 49%;
	  height: 300px;
	  border: solid 1px #eee;
	  border-radius: 15px;
	  margin: -13px 0 10px 520px; 
	}		
	
	#profile_i {
		padding: 0 10px 0 15px;  
	}
	
	#uccontent {  
		padding: 15px 0 15px 70px;  
	}
	 
	#uctime { 
		padding: 0 0 0 300px;   
	}
		
</style>

<script type="text/javascript">

	
	$(document).ready(function(){
			
			/* 검색 엔터누를시  */ 
			$('input#user_collection_content').on('keyup', function(event){
		    	if( event.keyCode == 13 ){
		    		goAddUserWrite()
		    	}
		    });
		
		    goUserViewComment(1); // 페이징 처리 한 댓글 읽어오기
				
			/* 카드 더보기 시작 */
			$("span#totalHITCount").hide();
			$("span#countHIT").hide();
			
			displayHIT("1");
			// HIT 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기
			
			$("button#btnMoreHIT").click(function(){
				
				if($(this).text() == "처음으로"){
					
					$("div#displayHIT").empty();
					$("span#end").empty();
					displayHIT("1");
					$(this).text("더보기");
					
				}
				else{
					displayHIT($(this).val());
				}
				
			});// end of $("button#btnMoreHIT").click() --------------------------- 	
			/* 카드 더보기 끝 */
				
				
				
			/* 출연, 제작 시작*/	
			$('#recipeCarousel').carousel({ 
				  interval: 10000
			});
			
			$('.carousel .carousel-item').each(function(){
			    var minPerSlide = 5;
			    var next = $(this).next();
			    if (!next.length) {
			        next = $(this).siblings(':first');
			    }
			    next.children(':first-child').clone().appendTo($(this));
			    
			    for (var i=0;i<minPerSlide;i++) {
			        next=next.next();
			        if (!next.length) {
			        	next = $(this).siblings(':first');
			      	}
			        
			        next.children(':first-child').clone().appendTo($(this));
			   }
			});
			/* 출연, 제작 끝*/	
			
			/*좋아요 시작*/		
			$("input:checkbox[name='check_good']").click(function(){
				  
				if($('input:checkbox[name="check_good"]').is(":checked")) {
					 
				 	$(".goodi").css({"color":"#f3578d"}); 
				 	
				}
				else if(!$('input:checkbox[name="check_good"]').is(":checked")) {
		
					$(".goodi").css({"background-color":"","color":""}); 
				}
				
				goLikeCollection();
				
				$("input:checkbox[name='check_good']").toggle();
				
			  });
			/*좋아요 끝*/	
		
	});//end of $(document).ready(function()) ----------------------------------------------------------------------------


	// Function Declaration

	/* ==== 더보기 시작  ==== */
	let lenHIT = 5;
	// HIT 상품 "더보기..." 버튼을 클릭할때 보여줄 상품의 개수(단위)크기
	
	// display 할  HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayHIT(start){
		$.ajax({
			url:"<%= ctxPath %>/cardSeeMore.action",
		    data:{"start":start,  
		    	  "len"  :lenHIT 
		    },
		    dataType:"json",
		    success:function(json){
		    	
		    	 let html = "";
		    	 
		    	 if(start == "1" && json.length == 0){
			    	
		    		 html += "현재 상품 준비중...";
		    	 
		    	 	 $("div#displayHIT").html(html);
		    		 
		    	 }
		    	 else if(json.length > 0){
		    		 // 데이터가 존재하는 경우
		    		 
		    		 $.each(json, function(index, item){  
					    			    
				        html +=    "<div class='card mb-3' style='width: 10rem; display: inline-block; margin: 20px 0 0 30px;'>" +
									  "<img src='https://image.tmdb.org/t/p/w780"+item.poster_path+"' class='card-img-top' style='width: 100%; height: 220px;'/>" +
									  "<div class='card-body'>" +
									    "<h6 class='card-title' style='font-size: 14px; font-weight: bold; text-align: center; height: 20px;'>"+item.movie_title+"</h6>"+
									    "<p class='card-text'></p>" +
									    "<a href='project_detail.action?movie_id="+item.movie_id+"' class='stretched-link'></a>" +
									  "</div>" +
									"</div>"			 
								    		 
		    		 }); // end of $.each(json, function(index, item) -------------------------------------------
		    		
		    		 // 상품결과 출력하기		 
		    		 $("div#displayHIT").append(html);	
		    		 
	    			// >>> !!! 중요 !!! 더보기 버튼의 value 속성에 값을 지정하기 <<< //
	    			$("button#btnMoreHIT").val(Number(start) + lenHIT); 
	    			
	    			// span#countHIT 에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
	    			$("span#countHIT").text(Number($("span#countHIT").text()) + json.length);
	    			
	    			// 더보기... 버튼을 계속해서 클릭하여 countHIT 값과 totalHITCount 값이 일치하는 경우 
	    			if( Number($("span#totalHITCount").text()) == Number($("span#countHIT").text()) ){
	    				$("span#end").html("더이상 조회할 제품이 없습니다.");
	    				$("button#btnMoreHIT").text("처음으로");
	    				$("span#countHIT").text("0");
	    			} 
		    		 
		    	 } // end of else if(json.length > 0){} --------------------------------------
		    	
		    },
	        error: function(request, status, error){ // 페이지없으면 404 에러
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
	
		});					        
	}
	/* ==== 더보기 끝 ==== */

	/* ==== 댓글쓰기 시작 ==== */
	function goAddUserWrite() {
	  
	  const user_collection_content = $("input#user_collection_content").val().trim(); 
	  
	  if(user_collection_content == "") {
		  alert("댓글 내용을 입력하세요!!");
		  return;  // 종료 
	  }
	  
	     goAddUserWrite_noAttach();
	  
    }
	/* ==== 댓글쓰기 끝 ==== */
	 
    /* ==== 파일첨부가 없는 댓글쓰기 시작 ==== */
    function goAddUserWrite_noAttach() {
      $.ajax({
  		 url:"<%= request.getContextPath()%>/addUserComment.action",
  		 data:{"user_id":"${requestScope.collection_view[0].user_id}" 
  			  ,"user_collection_content":$("input#user_collection_content").val()
  			  ,"collection_id":$("input#collection_id").val()},
  		 type:"post",
  		 dataType:"json",
  		 success:function(json){
  			 
  			 goUserViewComment(1); // 페이징 처리 한 댓글 읽어오기
  			 
  			 $("input#commentContent").val("");
  		 },
  		 error: function(request, status, error){
			alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	     }
      });
    }
    /* ==== 파일첨부가 없는 댓글쓰기 끝 ==== */
  
    // === Ajax로 불러온 댓글내용을  페이징 처리 하기 시작  === //
    function goUserViewComment(currentShowPageNo) {
	  $.ajax({
		  url:"<%= request.getContextPath()%>/user_collection_commentList.action",
		  data:{"collection_id":$("input#collection_id").val(),
			    "currentShowPageNo":currentShowPageNo},
		  dataType:"json",
		  success:function(json){
			  // console.log("~~ 확인용 : " + JSON.stringify(json));
			  
			  
			  let html = "";
			  if(json.length > 0) {
				 $.each(json, function(index, item){
					  
					 html += "<tr>"; 
					 html += '<td id="profile_i">'+item.profile_image+"</td>";
					 html += "<td>"+item.name+"</td>";
					 html += '<td id="uccontent">'+item.user_collection_content+"</td>";
		             html += '<td id="uctime">'+item.user_collection_time+"</td>";  
		             html += "</tr>";  
		             
 				 }); 
			  }   
			  else {
				  html += "<tr>" +
				            "<td colspan='6' class='comment'>댓글이 없습니다</td>" +
				          "</tr>"; 
			  }
			  
			  $("tbody#commentDisplay").html(html);
			  
			  // === 페이지바 함수 호출 === //
			  makeUserCommentPageBar(currentShowPageNo);
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
    }
    //=== Ajax로 불러온 댓글내용을  페이징 처리 하기 끝  === // 
  
    // ==== 댓글내용 페이지바 Ajax로 만들기 ==== //
    function makeUserCommentPageBar(currentShowPageNo) {
	  
	  <%-- === 원글에 대한 totalPage 수를 알아오려고 한다. 시작 === --%>
	  $.ajax({
		  url:"<%= request.getContextPath()%>/getUserCommentTotalPage.action",
		  data:{"collection_id":$("input#collection_id").val(),
			    "sizePerPage":"3"},
		  type:"get", 
		  dataType:"json",
		  success:function(json){

			  // console.log("~~ 확인용 : " + JSON.stringify(json));
			  
			  if(json.totalPage > 0) {
				  // 댓글이 있는 경우 
				  
				  const totalPage = json.totalPage; 
				  
				  const blockSize = 4;
				  
				  let loop = 1;
				  /*
				      loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
				  */
				  
				  if(typeof currentShowPageNo == "string") {
					  currentShowPageNo = Number(currentShowPageNo);
				  }
				  
				// *** !! 다음은 currentShowPageNo 를 얻어와서 pageNo 를 구하는 공식이다. !! *** //
				let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;
				
				let pageBarHTML = "<ul style='list-style: none;'>";
				
				// === [맨처음][이전] 만들기 === //
				if(pageNo != 1) {
					pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goUserViewComment(\"1\")'>[맨처음]</a></li>";
					pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goUserViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>";
				}
				
				while( !(loop > blockSize || pageNo > totalPage) ) {
					
					if(pageNo == currentShowPageNo) {
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
					}
					else {
						pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goUserViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
					}
					
					loop++;
					pageNo++;
					
				}// end of while-----------------------
				
				
				// === [다음][마지막] 만들기 === //
				if( pageNo <= totalPage ) {
					pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goUserViewComment(\""+pageNo+"\")'>[다음]</a></li>";
					pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goUserViewComment(\""+totalPage+"\")'>[마지막]</a></li>"; 
				}
				 
				pageBarHTML += "</ul>";
				 
				$("div#pageBar").html(pageBarHTML);
				  
			  }// end of if(json.totalPage > 0)------------------
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }
  <%-- === 원글에 대한 totalPage 수를 알아오려고 한다. 끝 === --%>
    
  // === 좋아요 시작  === //
  function goLikeCollection() {
	  $.ajax({
		  url:"<%= request.getContextPath()%>/likeCollection.action",
		  data:{"collection_id":$("input#collection_id").val(), 
			    "user_id":"${requestScope.collection_view[0].user_id}"}, 
		  type:"post", 	      
		  dataType:"json",
		  success:function(json){
			   console.log("~~ 확인용 : " + JSON.stringify(json));
			  
			  
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
  }
  //=== 좋아요 끝  === //
  
  
</script>

<meta charset="UTF-8">
<title></title>
</head>
<body>

	<div id="container">
		<div class="card">
		    <div class="card-body"> 
		        
		        <img id="middle" src="https://image.tmdb.org/t/p/w1280${requestScope.collection_view[0].backdrop_path}"/>
		        
		        <hr style="margin: 0 30px 0 30px;">  	
		        
		        <span style="margin-left: 50px;"></span>
		        
		        <div id="commentInfo">
			        <span>닉네임:&nbsp;${requestScope.collection_view[0].nickname}</span>
			        <span>성명:&nbsp;${requestScope.collection_view[0].name}</span>
			        
					<span style= "width: 100px;"> 
					  <label for="check_good" style="cursor: pointer;">
					    <i class="far fa-thumbs-up goodi"></i><span class="goodi" style="font-weight: bolder">&nbsp;&nbsp;좋아요</span></label>
						<input type="checkbox" id="check_good" name="check_good"/>
					</span>
		        </div> 
		        
		        <div id="chart">
		        </div> 		        
			    
			
			
				<hr style="margin: 0 30px 0 30px;">  	    
		      
		    	<div style="font-size: 20px; font-weight: bold; margin: 20px 0 0 47px;">나의 컬렉션</div>	
 
				  <div class="row" id="displayHIT" style="margin-left: 20px;"></div>
   					
			      <div>
			         <p class="text-center">
			            <span id="end" style="display:block; margin:20px 0px 0 0; font-weight:bold; font-size: 12pt;"></span> 
			            <button type="button" class="btn" id="btnMoreHIT" style="font-weight:bold; color:#f3578d;">더보기</button>
			            <span id="totalHITCount">${requestScope.totalCount.count}</span>
			            <span id="countHIT">0</span>
			         </p>
			      </div>
			      
			    <hr style="margin: 0 30px 0 30px;">  
			    		
			    <div style="font-size: 20px; font-weight: bold; margin: 20px 0 0 47px; display: inline-block;">댓글</div>			
			    		
			         <input type="hidden" name="user_id" id="user_id" value="${requestScope.collection_view[0].user_id}" />
			         <input type="hidden" name="collection_id" id="collection_id" value="${requestScope.collection_view[0].collection_id}" /> 
		    	 
		    	<%-- === 댓글 내용 보여주기 === --%>
		    	<div id="commentBack">
			    	<table style="">
						<tbody id="commentDisplay"></tbody>
					</table>
		    	</div>
		    	
	    	   	<div style="display: flex;">  
		    	   <div id="pageBar" style="margin: 10px 0 0 400px; text-align: center;"></div>
		    	</div>	
		    	
		    	<input style="margin-left: 140px;" class="commentP" type="text" name="user_collection_content" id="user_collection_content">
		    	<button style="margin-left: 20px;" class="btnP" onclick="goAddUserWrite()"><i class="far fa-comment"></i>제출</button>
		    		
		    </div>
		</div>
	</div> 
	
</body>
</html>