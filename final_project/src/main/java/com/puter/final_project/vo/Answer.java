package com.puter.final_project.vo;
import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("answer")
public class Answer {

    int aIdx;
    int inIdx;
    int userIdx;
    String aContent;
    String aDate;
}
