package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.UserVo;

@Mapper
public interface UserMapper {

    List<UserVo> selectList();

    // id 에 해당되는 1건의 정보 얻어온다
    public UserVo selectOneFromId(String id);

    // email에 대한 유저 검색
    public UserVo selectOneFromEmail(String email, String esite);

    // 사용자 추가
    public int insert(UserVo vo);

    // 이메일 추가
    public int emailInsert(UserVo vo);

}
