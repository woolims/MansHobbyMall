package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.UserVo;

@Mapper
public interface AdminMapper {

    List<UserVo> selectList();

    public int user_update(int userIdx);

    public int user_delete(int userIdx);

}
