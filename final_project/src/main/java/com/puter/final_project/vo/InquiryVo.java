package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("inquiry")
public class InquiryVo {

    int inIdx;
    int pIdx;
    int userIdx;
    String inType;
    String inContent;
    String inDate;
    String inPP;

}
