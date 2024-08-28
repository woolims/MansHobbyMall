package com.puter.final_project.vo;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("user")
public class UserVo {

    int userIdx;
    int gIdx;
    String id;
    String password;
    String nickName;
    String name;
    String phone;
    String addr;
    String adminAt;
    long point;
    String createAt;
}
