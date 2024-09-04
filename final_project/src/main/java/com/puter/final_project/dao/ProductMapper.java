package com.puter.final_project.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.puter.final_project.vo.ProductVo;

@Mapper
public interface ProductMapper {

    List<ProductVo> selectList();

    ProductVo productInsert(ProductVo product);

    int pDelete(int pIdx);

}
