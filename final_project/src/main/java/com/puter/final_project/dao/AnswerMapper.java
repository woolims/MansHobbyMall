package com.puter.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.AnswerVo;

@Mapper
public interface AnswerMapper {

    // 댓글 추가
    public int insert(AnswerVo vo);


}
