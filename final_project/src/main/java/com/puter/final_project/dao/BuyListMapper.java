package com.puter.final_project.dao;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.BuyListVo;
import com.puter.final_project.vo.UserVo;

@Mapper
public interface BuyListMapper {

    public int insert(BuyListVo vo);

    public UserVo selectOne(int userIdx);

    public int selectBuyListOne(BuyListVo vo);

    public int orderInsert(int bIdx);

}
