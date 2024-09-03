package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.InquiryVo;

@Mapper
public interface InquiryMapper {

    List<InquiryVo> selectList();

}
