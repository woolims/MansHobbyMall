package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("pImage")
public class PImageVo {
    int fileIdx;
    int pIdx;
    String fileName;
}
