package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("orders")
public class OrdersVo {
    
    int oIdx;
    int dsIdx;
    int bIdx;
    String daStartDate;
    String daEndDate;

    int userIdx;
    int pIdx;
    int bamount;
    String buyDate;

    String dsContent;

    String name;

    String pName;
}
