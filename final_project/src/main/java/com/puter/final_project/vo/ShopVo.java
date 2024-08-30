package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("shop")
public class ShopVo {

    // 상품
    int pIdx;
    int categoryNo;
    int mcategoryNo;
    int dcategoryNo;
    String pName;
    String pEx;
    int amount; // 뷰에 미포함
    int price;

    // 대분류
    String categoryName;

    // 중분류
    String mcategoryName;

    // 소분류
    String dcategoryName;

    // 장바구니
    int scIdx; // 뷰에 미포함
    int userIdx; // 뷰에 미포함
    int scamount; // 뷰에 미포함

}
