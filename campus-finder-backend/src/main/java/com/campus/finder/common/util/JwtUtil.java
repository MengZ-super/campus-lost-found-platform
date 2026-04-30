package com.campus.finder.common.util;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * JWT 工具类
 */
@Slf4j
@Component
public class JwtUtil {

    @Value("${jwt.secret}")
    private String secret;

    @Value("${jwt.access-token-expiration}")
    private long accessTokenExpiration;

    @Value("${jwt.refresh-token-expiration}")
    private long refreshTokenExpiration;

    private SecretKey secretKey;

    @PostConstruct
    public void init() {
        // 确保密钥长度足够（至少256位）
        if (secret.length() < 32) {
            secret = secret + "0".repeat(32 - secret.length());
        }
        this.secretKey = Keys.hmacShaKeyFor(secret.getBytes(StandardCharsets.UTF_8));
    }

    /**
     * 生成AccessToken
     */
    public String generateAccessToken(Long userId, String username, String role) {
        return generateToken(userId, username, role, accessTokenExpiration);
    }

    /**
     * 生成RefreshToken
     */
    public String generateRefreshToken(Long userId, String username, String role) {
        return generateToken(userId, username, role, refreshTokenExpiration);
    }

    /**
     * 生成Token
     */
    private String generateToken(Long userId, String username, String role, long expiration) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("userId", userId);
        claims.put("username", username);
        claims.put("role", role != null ? role : "user");

        return Jwts.builder()
                .claims(claims)
                .subject(username)
                .issuedAt(new Date())
                .expiration(new Date(System.currentTimeMillis() + expiration))
                .signWith(secretKey)
                .compact();
    }

    /**
     * 解析Token
     */
    public Claims parseToken(String token) {
        try {
            return Jwts.parser()
                    .verifyWith(secretKey)
                    .build()
                    .parseSignedClaims(token)
                    .getPayload();
        } catch (ExpiredJwtException e) {
            log.warn("Token已过期: {}", e.getMessage());
            throw e;
        } catch (JwtException e) {
            log.warn("Token解析失败: {}", e.getMessage());
            throw e;
        }
    }

    /**
     * 验证Token
     */
    public boolean validateToken(String token) {
        try {
            parseToken(token);
            return true;
        } catch (JwtException e) {
            return false;
        }
    }

    /**
     * 验证Token并返回UserDetails
     */
    public boolean validateToken(String token, UserDetails userDetails) {
        final String username = getUsernameFromToken(token);
        return username != null && username.equals(userDetails.getUsername()) && !isTokenExpired(token);
    }

    /**
     * 从Token获取用户名
     */
    public String getUsernameFromToken(String token) {
        return parseToken(token).getSubject();
    }

    /**
     * 从Token获取用户ID
     */
    public Long getUserIdFromToken(String token) {
        Claims claims = parseToken(token);
        Object userId = claims.get("userId");
        if (userId instanceof Integer) {
            return ((Integer) userId).longValue();
        } else if (userId instanceof Long) {
            return (Long) userId;
        }
        return null;
    }

    /**
     * 判断Token是否过期
     */
    public boolean isTokenExpired(String token) {
        try {
            Date expiration = parseToken(token).getExpiration();
            return expiration.before(new Date());
        } catch (ExpiredJwtException e) {
            return true;
        }
    }

    /**
     * 获取Token剩余有效时间（毫秒）
     */
    public long getRemainingTime(String token) {
        try {
            Date expiration = parseToken(token).getExpiration();
            return expiration.getTime() - System.currentTimeMillis();
        } catch (ExpiredJwtException e) {
            return 0;
        }
    }

    /**
     * 从Token获取角色
     */
    public String getRoleFromToken(String token) {
        Claims claims = parseToken(token);
        Object role = claims.get("role");
        return role != null ? role.toString() : "user";
    }

    /**
     * 获取Token剩余有效时间（分钟）
     */
    public long getRemainingTimeInMinutes(String token) {
        return TimeUnit.MILLISECONDS.toMinutes(getRemainingTime(token));
    }
}
