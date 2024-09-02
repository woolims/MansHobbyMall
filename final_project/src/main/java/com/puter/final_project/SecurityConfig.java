package com.puter.final_project;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .authorizeHttpRequests(authorizeRequests ->
                authorizeRequests
                    .requestMatchers("/", "/login", "/public/**").permitAll()
                    .anyRequest().authenticated()
            )
            .oauth2Login(oauth2 -> 
                oauth2
                    .loginPage("/login")
                    // .userInfoEndpoint(e -> e.userService(customOAuth2UserService())) // 사용자 정의 OAuth2UserService 설정
                    .defaultSuccessUrl("/home.do", true)
                    .failureUrl("/login-error")
            )
            .logout(logout ->
                logout
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/login?logout")
            )
            .exceptionHandling(exceptions ->
                exceptions
                    .accessDeniedPage("/accessDenied")
            )
            .csrf(csrf -> csrf.disable());
        return http.build();
    }

    @Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return (web) -> web.ignoring().requestMatchers("/public/**");
    }

    // @Bean
    // public OAuth2UserService<OAuth2UserRequest, OAuth2User> customOAuth2UserService() {
    //     return new CustomOAuth2UserService();
    // }
}
