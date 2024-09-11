package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.ProductVo;
import com.puter.final_project.vo.ShopVo;

@Mapper
public interface ShopMapper {

    // 게임카테고리 전체조회
    List<ShopVo> selectListGame(int categoryNo);

    // 스포츠카테고리 전체조회
    List<ShopVo> selectListSports(int categoryNo);

    // 메인카테고리 번호만 조회
    int selectRowTotalSports(int categoryNo);

    List<ShopVo> selectMCategoryNameList(int categoryNo);

    List<ShopVo> selectMCategoryNoList(int categoryNo);

    int selectMCategoryNo(ShopVo shop);

    List<ShopVo> selectdCategoryNameList(int mCategoryNo);

    int selectDCategoryNo(ShopVo shop);

    List<ShopVo> selectProductMCategoryList(int mCategoryNo);

    List<ShopVo> selectProductDCategoryList(int dCategoryNo);

    ShopVo selectProductInfoList(int categoryNo, int pIdx);

    List<ShopVo> selectAdminList();

    String selectPEx(int pIdx);

    int selectAdminCategoryNo(ShopVo shop);

    int selectAdminMcategoryNo(ShopVo shop);

    int selectAdminDcategoryNo(ShopVo shop);

    // int selectMaxPIdx();

    int productInsert(ShopVo shop);

    int productUpdate(ShopVo shop);

    List<ShopVo> selectCategoryNameList();

    List<ShopVo> selectMcategoryNameList(String categoryName);

    List<ShopVo> selectDcategoryNameList(String mcategoryName);

    

    List<ShopVo> selectSearchList(ShopVo shop);
    
    List<ShopVo> selectCategoryList(ShopVo shop);

    List<ShopVo> selectCategorySearchList(ShopVo shop);

    List<ShopVo> selectMcategoryList(ShopVo shop);

    List<ShopVo> selectMcategorySearchList(ShopVo shop);

    List<ShopVo> selectDcategoryList(ShopVo shop);

    List<ShopVo> selectDcategorySearchList(ShopVo shop);

}
