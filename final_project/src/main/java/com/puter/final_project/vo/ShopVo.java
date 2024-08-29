package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("shop")
public class ShopVo {

    // 상품
    int pIdx;

}
