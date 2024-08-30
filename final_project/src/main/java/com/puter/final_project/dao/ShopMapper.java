package com.puter.final_project.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.ShopVo;

@Mapper
public interface ShopMapper {

    // 게임카테고리 전체조회
    List<ShopVo> selectListGame(int categoryNo);

    // 스포츠카테고리 전체조회
    List<ShopVo> selectListSports(int categoryNo);

    // 메인카테고리 번호만 조회
    int selectRowTotalSports(int categoryNo);

    // 페이징처리

    List<ShopVo> selectPageList(Map<String, Object> map);

    int selectRowTotalGame();

    int selectRowTotalSports();

}
