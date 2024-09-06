package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.InquiryVo;

@Mapper
public interface InquiryMapper {

    List<InquiryVo> selectList();

    // 게시글 추가
    public int inquiryInsert(InquiryVo vo);

    // 게시글 상세 조회
    public InquiryVo selectOne(int inIdx);

    // 게시글 삭제
    public int delete(int inIdx);

}
