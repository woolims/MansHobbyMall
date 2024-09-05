package com.puter.final_project.dao;

import java.util.List;
import java.util.Map;

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

    int selectCategoryNo(String categoryName);

    int selectMcategoryNo(String mcategoryName);

    int selectDcategoryNo(String dcategoryName);

    ProductVo productInsert(ProductVo product);

    int productUpdate(ShopVo shop);

}
