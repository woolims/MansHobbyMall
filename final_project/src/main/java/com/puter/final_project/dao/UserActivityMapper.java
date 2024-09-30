package com.puter.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.UserActivityVo;

@Mapper
public interface UserActivityMapper {
    
    int updateTotalBuyPlus(UserActivityVo vo);

    int updateTotalBuyMinus(UserActivityVo vo);

    int updateTotalReviewPlus(int userIdx);

    int updateTotalReviewMinus(int userIdx);

    int callUpdateUserGrade(int userIdx);
}
