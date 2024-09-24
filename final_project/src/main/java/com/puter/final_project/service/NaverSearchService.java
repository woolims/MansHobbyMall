package com.puter.final_project.service;

import java.util.Iterator;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.puter.final_project.dao.ShopMapper;
import com.puter.final_project.vo.ShopVo;

@Service
public class NaverSearchService {
    
    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    @Autowired
    ShopMapper shopMapper;


    ObjectMapper objectMapper = new ObjectMapper();

    public void searchAndSave( int categoryNo, String mcategoryName, String dcategoryName) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "https://openapi.naver.com/v1/search/shop.json?query=" + dcategoryName;

        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        String response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class).getBody();

        try {
            JsonNode jsonNode = objectMapper.readTree(response);
            Iterator<JsonNode> elements = jsonNode.get("items").elements();
           
            while (elements.hasNext()) {
                JsonNode item = elements.next();
                ShopVo shopVo = new ShopVo();
                shopVo.setPName(item.get("title").asText());
                shopVo.setPrice(item.get("lprice").asInt());
                shopVo.setCategoryNo(categoryNo);
                shopVo.setMcategoryName(mcategoryName);
                int mcategoryNo = shopMapper.selectMCategoryNo(shopVo);
                shopVo.setMcategoryNo(mcategoryNo);
                shopVo.setDcategoryName(dcategoryName);
                int dcategoryNo = shopMapper.selectdCategoryNo(shopVo);
                shopVo.setDcategoryNo(dcategoryNo);
                shopVo.setAmount(1);
                shopVo.setPEx("상품설명");
                // DTO를 Mapper를 통해 DB에 저장
                shopMapper.productInsert(shopVo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
