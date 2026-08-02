package com.aska.common.util;

import cn.hutool.core.map.MapUtil;
import cn.hutool.extra.servlet.ServletUtil;
import com.alibaba.fastjson.JSON;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtUtil {

    // token redis 过期时间，如果选择了记住我则默认时间为天
    public static final int REDIS_EXPIRE_DAY = 14;//天

    // 如果未选择的默认时间为分钟
    public static final int REDIS_EXPIRE_MINUTES = 30;//分钟

    public static final int DAY = 1; //3天
    public static final String SECRET = "XX#$%()(#*!()!KL<><MQLMNQNQJQK sdfkjsdrow32234545fdf>?N<:{LWPW";
    public static final String TOKEN_PREFIX = "Bearer ";
    public static final String HEADER_STRING = "Authorization";

    public static final String REFRESH_HEDAER_STRING = "refreshToken";
    /**
     * 加密工具
     *
     * @param userJson
     * @return
     */
    public static String generateToken(String userJson) {

        HashMap<String, Object> map = new HashMap<>();
        //you can put any data in the map
        map.put("userJson", userJson);
        Calendar now = Calendar.getInstance();
        now.setTime(new Date());
        //设置过期时间
        //now.add(Calendar.HOUR_OF_DAY, MINUTES);
        now.set(Calendar.DATE, now.get(Calendar.DATE) + DAY);
        String jwt = Jwts.builder()
                .setClaims(map)  //
                .setExpiration(now.getTime())//过期时间
                .signWith(SignatureAlgorithm.HS512, SECRET)//SECRET是加密算法对应的密钥，这里使用额是HS256加密算法
                .compact();
        return jwt;
    }

    /**
     * 验证
     *
     * @param token
     * @return
     */
    public static String validateToken(String token) {
        if (token != null) {
            // parse the token.
            Map<String, Object> body = Jwts.parser()
                    .setSigningKey(SECRET)
                    .parseClaimsJws(token.replace(TOKEN_PREFIX, ""))
                    .getBody();
            String userJson = (String) (body.get("userJson"));
            if (userJson == null || userJson.isEmpty()) {
                throw new TokenValidationException("Wrong token without username");
            }
            return userJson;
        } else {
            throw new TokenValidationException("Missing token");
        }
    }

    public static String getAdminId(HttpServletRequest request){
        String tokenHeader = request.getHeader(HEADER_STRING);
        //获取token值
        String token = JwtUtil.validateToken(tokenHeader);
        if(token == null){
            throw new TokenValidationException("Wrong token without username");
        }
        Map map = JSON.parseObject(token, Map.class);
        String id = MapUtil.get(map, "id", String.class);
        return id;
    }

    public static Integer getIsAdmin(HttpServletRequest request){
        String tokenHeader = request.getHeader(HEADER_STRING);
        //获取token值
        String token = JwtUtil.validateToken(tokenHeader);
        if(token == null){
            throw new TokenValidationException("Wrong token without username");
        }
        Map map = JSON.parseObject(token, Map.class);
        Integer isAdmin = MapUtil.get(map, "isAdmin", Integer.class);
        return isAdmin;
    }

    static class TokenValidationException extends RuntimeException {
        public TokenValidationException(String msg) {
            super(msg);
        }
    }

    /**
     * 是否存在token
     * @param token
     * @return
     */
    public static boolean isExit(String token) {
        try {
            Map<String, Object> body = Jwts.parser()
                    .setSigningKey(SECRET)
                    .parseClaimsJws(token.replace(TOKEN_PREFIX, ""))
                    .getBody();
            String userJson = (String) (body.get("userJson"));
            if(userJson == null || userJson.isEmpty()){
                return true;
            }
        } catch (Exception e) {
            return true;
        }
        return false;
    }
}
