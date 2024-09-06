package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.ReviewVo;

@Mapper
public interface ReviewMapper {

    // 모든 리뷰 가져오기
    List<ReviewVo> getAllReviews();

    // 특정 리뷰 조회
    ReviewVo getReviewByIdx(int rvIdx);

    // 리뷰 작성
    int insertReview(ReviewVo review);

    // 리뷰 수정
    int updateReview(ReviewVo review);

    // 리뷰 삭제
    int deleteReview(int rvIdx);
}
