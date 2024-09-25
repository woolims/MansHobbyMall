package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("grade")
public class GradeVo {
    
    int gIdx;
    String gradeName;
    int authority;
    int discount;
}
