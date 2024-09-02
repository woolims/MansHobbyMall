// package com.puter.final_project;
// import org.springframework.security.core.authority.SimpleGrantedAuthority;
// import org.springframework.security.core.userdetails.User;
// import org.springframework.security.oauth2.core.user.OAuth2User;
// import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
// import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
// import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
// import org.springframework.security.oauth2.core.user.OAuth2UserRequest;
// import org.springframework.stereotype.Service;

// import java.util.Collections;
// import java.util.Map;

// @Service
// public class CustomOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {

//     @Override
//     public OAuth2User loadUser(OAuth2UserRequest userRequest) {
//         OAuth2User oAuth2User = new DefaultOAuth2UserService().loadUser(userRequest);
        
//         // 사용자 정보 추출
//         Map<String, Object> attributes = oAuth2User.getAttributes();
//         String name = (String) attributes.get("name");
//         String email = (String) attributes.get("email");

//         // 사용자 정보를 데이터베이스에 저장하거나 처리합니다.

//         // 반환할 OAuth2User 객체 생성
//         return new DefaultOAuth2User(
//                 Collections.singleton(new SimpleGrantedAuthority("ROLE_USER")),
//                 attributes, "name");
//     }
// }
